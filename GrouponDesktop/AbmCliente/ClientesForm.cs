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
            if (dgvClientes.SelectedRows == null || dgvClientes.SelectedRows.Count == 0) return;
            var row = dgvClientes.SelectedRows[0];
            var cliente = row.DataBoundItem as Cliente;
            var regForm = new RegistroForm();
            regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
            regForm.SetUser(cliente);
            
            ViewsManager.LoadModal(regForm);
        }

        void regForm_OnUserSaved(object sender, UserSavedEventArgs e)
        {
            MessageBox.Show("Se han guardado los datos del cliente " + e.Username);
            var dataSource = dgvClientes.DataSource as BindingList<Cliente>;
            var cliente = e.User as Cliente;
            if (dataSource.Contains(cliente)) dataSource.Remove(cliente);
            dataSource.Add(cliente);
            dgvClientes.Refresh();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var regForm = new RegistroForm();
            regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
            regForm.Profile = Profile.Cliente;
            ViewsManager.LoadModal(regForm);
        }
    }
}
