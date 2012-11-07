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
        private ProveedorManager manager = new ProveedorManager();

        public ProveedoresForm()
        {
            InitializeComponent();
        }

        private void ProveedoresForm_Load(object sender, EventArgs e)
        {
            var bindingSource = new BindingSource();
            var table = manager.GetAll();
            proveedoresGrid.AutoGenerateColumns = false;
            proveedoresGrid.DataSource = table;
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
                    manager.Delete(proveedor);
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
            proveedoresGrid.Refresh();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var regForm = new RegistroForm();
            regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
            regForm.Profile = Profile.Proveedor;
            ViewsManager.LoadModal(regForm);
        }
    }
}
