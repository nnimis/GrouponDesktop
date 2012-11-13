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

namespace GrouponDesktop.ArmarCupon
{
    [PermissionRequired(Functionalities.CrearCupon)]
    public partial class ArmarCuponesForm : Form
    {
        private CuponManager _manager = new CuponManager();

        public ArmarCuponesForm()
        {
            InitializeComponent();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var form = new NuevoCupon();
            form.OnCuponSaved += new EventHandler<CuponSavedEventArgs>(form_OnCuponSaved);
            ViewsManager.LoadModal(form);
        }

        void form_OnCuponSaved(object sender, CuponSavedEventArgs e)
        {
            e.Cupon.ID = _manager.Add(e.Cupon);
            ((BindingList<Cupon>)dataGridView.DataSource).Add(e.Cupon);
            dataGridView.Refresh();
            ((NuevoCupon)sender).Close();
            MessageBox.Show("Se ha creado un nuevo Cupón");
        }

        private void ArmarCuponesForm_Load(object sender, EventArgs e)
        {
            dataGridView.AutoGenerateColumns = false;
            dataGridView.DataSourceChanged += new EventHandler(dataGridView_DataSourceChanged);
            dataGridView.DataSource = _manager.GetAll(new Proveedor() { UserID = Session.User.UserID });
        }

        void dataGridView_DataSourceChanged(object sender, EventArgs e)
        {
            var dataSource = dataGridView.DataSource as IList;
            lblResults.Text = dataSource.Count.ToString();
        }
    }
}
