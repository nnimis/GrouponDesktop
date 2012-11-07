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

namespace GrouponDesktop.AbmCliente
{
    [PermissionRequired(Functionalities.AdministrarClientes)]
    public partial class ClientesForm : Form
    {
        private ClienteManager clienteManager = new ClienteManager();

        public ClientesForm()
        {
            InitializeComponent();
        }

        private void ClientesForm_Load(object sender, EventArgs e)
        {
            var bindingSource = new BindingSource();
            var clientesTable = clienteManager.GetAll();
            dgvClientes.AutoGenerateColumns = false;
            dgvClientes.DataSource = clientesTable;
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (dgvClientes.SelectedRows == null || dgvClientes.SelectedRows.Count == 0) return;
            var row = dgvClientes.SelectedRows[0];
            var cliente = row.DataBoundItem as Cliente;
            if (MessageBox.Show(string.Format("Confirma que desea eliminar al cliente {0} {1}?", cliente.Nombre.Trim(), cliente.Apellido.Trim())
                , "Eliminar cliente", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {
                    clienteManager.Delete(cliente);
                    var dataSource = dgvClientes.DataSource as BindingList<Cliente>;
                    dataSource.Remove(cliente);
                    dgvClientes.Refresh();
                    MessageBox.Show(string.Format("Cliente {0} {1} eliminado", cliente.Nombre.Trim(), cliente.Apellido.Trim()));
                }
                catch
                {
                    MessageBox.Show("Error al eliminar el cliente");
                }
            }
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            //if (rolesDataGridView.SelectedRows == null || rolesDataGridView.SelectedRows.Count == 0) return;
            //var row = rolesDataGridView.SelectedRows[0];
            //var rol = row.DataBoundItem as Rol;
            //if (rol.ID == Session.DefaultRoleID)
            //{
            //    MessageBox.Show("Rol no editable");
            //    return;
            //}
            //var addEditForm = new AddEditRoleForm(rol);
            //addEditForm.OnRoleUpdated += new EventHandler<RoleUpdatedEventArgs>(addEditForm_OnRoleUpdated);
            //ViewsManager.LoadModal(addEditForm);
        }
    }
}
