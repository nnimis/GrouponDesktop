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

namespace GrouponDesktop.CargaCredito
{
    [PermissionRequired(Functionalities.CargarCredito)]
    public partial class CargarCreditoForm : Form
    {
        private PagosManager _manager = new PagosManager();

        public CargarCreditoForm()
        {
            InitializeComponent();
        }

        private void CargarCreditoForm_Load(object sender, EventArgs e)
        {
            var data = _manager.GetAll(Session.User);
            dataGridView.DataSource = data;
            dataGridView.Refresh();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var frm = new NuevoPago();
            frm.OnPagoAdded += new EventHandler<PagoAddedEventArgs>(frm_OnPagoAdded);
            ViewsManager.LoadModal(frm);
        }

        void frm_OnPagoAdded(object sender, PagoAddedEventArgs e)
        {
            _manager.Add(e.Pago, Session.User);
            var dataSource = (BindingList<Pago>)dataGridView.DataSource;
            dataSource.Add(e.Pago);
            dataGridView.Refresh();
            MessageBox.Show("El pago ha sido acreditado");
        }
    }
}
