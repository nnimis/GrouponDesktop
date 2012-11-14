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
using GrouponDesktop.Login;

namespace GrouponDesktop.AbmProveedor
{
    [PermissionRequired(Functionalities.AdministrarProveedores)]
    public partial class ProveedoresForm : Form
    {
        private ProveedorManager _manager = new ProveedorManager();
        public event EventHandler<UserSelectedEventArgs> OnUserSelected;

        public ProveedoresForm()
        {
            InitializeComponent();
        }

        public void SetSearchMode()
        {
            buttonsPanel.Visible = false;
        }

        private void ProveedoresForm_Load(object sender, EventArgs e)
        {
            var bindingSource = new BindingSource();
            var table = _manager.GetAll();
            table.Remove(new Proveedor() { UserID = Session.User.UserID });
            proveedoresGrid.AutoGenerateColumns = false;
            proveedoresGrid.DataSourceChanged += new EventHandler(proveedoresGrid_DataSourceChanged);
            proveedoresGrid.DataSource = table;
            proveedoresGrid.DoubleClick += new EventHandler(proveedoresGrid_DoubleClick);
        }

        void proveedoresGrid_DataSourceChanged(object sender, EventArgs e)
        {
            var dataSource = proveedoresGrid.DataSource as BindingList<Proveedor>;
            lblResults.Text = dataSource.Count.ToString();
        }

        void proveedoresGrid_DoubleClick(object sender, EventArgs e)
        {
            if (proveedoresGrid.SelectedRows == null || proveedoresGrid.SelectedRows.Count == 0) return;
            var row = proveedoresGrid.SelectedRows[0];
            var proveedor = row.DataBoundItem as Proveedor;

            if (OnUserSelected != null)
            {
                OnUserSelected(this, new UserSelectedEventArgs()
                {
                    User = proveedor as User
                });
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (proveedoresGrid.SelectedRows == null || proveedoresGrid.SelectedRows.Count == 0) return;
            var row = proveedoresGrid.SelectedRows[0];
            var proveedor = row.DataBoundItem as Proveedor;
            if (MessageBox.Show(string.Format("Confirma que desea eliminar al proveedor {0}?", proveedor.RazonSocial.Trim())
                , "Eliminar proveedor", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {
                    _manager.Delete(proveedor);
                    var dataSource = proveedoresGrid.DataSource as BindingList<Proveedor>;
                    dataSource.Remove(proveedor);
                    proveedoresGrid.Refresh();
                    MessageBox.Show(string.Format("Proveedor {0} eliminado", proveedor.RazonSocial.Trim()));
                }
                catch
                {
                    MessageBox.Show("Error al eliminar el proveedor");
                }
            }
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (proveedoresGrid.SelectedRows == null || proveedoresGrid.SelectedRows.Count == 0) return;
            var row = proveedoresGrid.SelectedRows[0];
            var proveedor = row.DataBoundItem as Proveedor;
            var regForm = new RegistroForm();
            regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
            regForm.SetUser(proveedor);

            ViewsManager.LoadModal(regForm);
        }

        void regForm_OnUserSaved(object sender, UserSavedEventArgs e)
        {
            MessageBox.Show("Se han guardado los datos del proveedor " + e.Username);
            var dataSource = proveedoresGrid.DataSource as BindingList<Proveedor>;
            var proveedor = e.User as Proveedor;
            if (dataSource.Contains(proveedor)) dataSource.Remove(proveedor);
            dataSource.Add(proveedor);
            proveedoresGrid.DataSource = new BindingList<Proveedor>(dataSource.OrderBy(x => x.RazonSocial).ToList());
            proveedoresGrid.Refresh();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var regForm = new RegistroForm();
            regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
            regForm.Profile = Profile.Proveedor;
            ViewsManager.LoadModal(regForm);
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtRazonSocial.Text = string.Empty;
            txtCUIT.Text = string.Empty;
            txtEmail.Text = string.Empty;
            proveedoresGrid.DataSource = _manager.GetAll();
            proveedoresGrid.Refresh();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            var proveedores = _manager.GetAll();
            if (!string.IsNullOrEmpty(txtRazonSocial.Text))
            {
                proveedores = new BindingList<Proveedor>(proveedores.Where(x => x.RazonSocial.ToLowerInvariant().Contains(txtRazonSocial.Text.ToLowerInvariant())).ToList());
            }
            if (!string.IsNullOrEmpty(txtEmail.Text))
            {
                proveedores = new BindingList<Proveedor>(proveedores.Where(x => x.DetalleEntidad.Email.ToLowerInvariant().Contains(txtEmail.Text.ToLowerInvariant())).ToList());
            }
            if (!string.IsNullOrEmpty(txtCUIT.Text))
            {
                proveedores = new BindingList<Proveedor>(proveedores.Where(x => x.CUIT.ToLowerInvariant().Equals(txtCUIT.Text.ToLowerInvariant())).ToList());
            }
            proveedores.Remove(new Proveedor() { UserID = Session.User.UserID });
            proveedoresGrid.DataSource = proveedores;
            proveedoresGrid.Refresh();
        }
    }
}
