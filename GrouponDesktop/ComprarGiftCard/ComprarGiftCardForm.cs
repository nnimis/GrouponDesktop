using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;
using GrouponDesktop.Common;
using GrouponDesktop.Business;
using System.Collections;

namespace GrouponDesktop.ComprarGiftCard
{
    [PermissionRequired(Functionalities.GiftCards)]
    public partial class ComprarGiftCardForm : Form
    {
        private GiftCardManager _manager = new GiftCardManager();

        public ComprarGiftCardForm()
        {
            InitializeComponent();
            dataGridView.AutoGenerateColumns = false;
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var form = new NuevaGiftCard();
            form.OnGiftCardCreated += new EventHandler<NewGiftCardEventArgs>(form_OnGiftCardCreated);
            ViewsManager.LoadModal(form);
        }

        void form_OnGiftCardCreated(object sender, NewGiftCardEventArgs e)
        {
            _manager.Add(e.GiftCard);
            MessageBox.Show("Se ha comprado la GiftCard");
            ((BindingList<GiftCard>)dataGridView.DataSource).Add(e.GiftCard);
        }

        private void ComprarGiftCardForm_Load(object sender, EventArgs e)
        {
            dataGridView.DataSourceChanged += new EventHandler(dataGridView_DataSourceChanged);
            dataGridView.AutoGenerateColumns = false;
            dataGridView.DataSource = _manager.GetAll(new Cliente() { UserID = Session.User.UserID });
            dataGridView.Refresh();
        }

        void dataGridView_DataSourceChanged(object sender, EventArgs e)
        {
            var dataSource = dataGridView.DataSource as IList;
            lblResults.Text = dataSource.Count.ToString();
        }
    }
}
