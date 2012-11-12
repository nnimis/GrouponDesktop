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
using GrouponDesktop.Login;
using GrouponDesktop.AbmProveedor;
using GrouponDesktop.Business;

namespace GrouponDesktop.FacturarProveedor
{
    [PermissionRequired(Functionalities.Facturar)]
    public partial class FacturaProveedorForm : Form
    {
        private Proveedor _proveedor;
        private ProveedoresForm _proveedoresForm;

        public FacturaProveedorForm()
        {
            InitializeComponent();
            dataGridView.AutoGenerateColumns = false;
        }

        private void btnBuscarProveedor_Click(object sender, EventArgs e)
        {
            if (_proveedoresForm == null)
            {
                _proveedoresForm = new ProveedoresForm();
                _proveedoresForm.SetSearchMode();
                _proveedoresForm.OnUserSelected += new EventHandler<UserSelectedEventArgs>(_proveedoresForm_OnUserSelected);
            }
            ViewsManager.LoadModal(_proveedoresForm);
        }

        void _proveedoresForm_OnUserSelected(object sender, UserSelectedEventArgs e)
        {
            _proveedor = e.User as Proveedor;
            _proveedoresForm.Hide();
            txtProveedor.Text = _proveedor.UserName;
        }

        private void btnFiltrar_Click(object sender, EventArgs e)
        {
            if (dtpDesde.Value > dtpHasta.Value)
            {
                MessageBox.Show("La fecha desde debe ser menor o igual que la fecha hasta");
            }
            var manager = new CompraCuponManager();
            dataGridView.DataSource = manager.GetParaFacturar(_proveedor, dtpDesde.Value, dtpHasta.Value);
            dataGridView.Refresh();
        }

        private void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            if (_proveedor == null)
            {
                MessageBox.Show("Debe seleccionar un proveedor para poder generar una factura");
                return;
            }
            if (dtpDesde.Value > dtpHasta.Value)
            {
                MessageBox.Show("La fecha desde debe ser menor o igual que la fecha hasta");
            }
            var data = (BindingList<CompraCupon>)dataGridView.DataSource;
            if (data == null || data.Count == 0)
            {
                MessageBox.Show("No hay cupones consumidos para poder generar una factura");
                return;
            }
            var montoFactura = data.Sum(x => x.Precio);
            if (MessageBox.Show(string.Format("Confirma emitir la factura para el proveedor '{0}' por ${1}?", _proveedor.UserName, montoFactura)) != DialogResult.OK)
                return;

            var manager = new FacturaManager();
            var nroFactura = manager.GenerarFactura(_proveedor, data, DateTime.Now);
            MessageBox.Show(string.Format("Se ha generado la factura Nro. {1} para el proveedor '{0}' por ${2}", _proveedor.UserName, nroFactura, montoFactura));
            dataGridView.DataSource = null;
            dataGridView.Refresh();
        }
    }
}
