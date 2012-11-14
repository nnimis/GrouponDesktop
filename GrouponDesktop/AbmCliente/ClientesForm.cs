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
        private ClienteManager _clienteManager = new ClienteManager();
        private bool _isSearchMode = false;
        public event EventHandler<UserSelectedEventArgs> OnUserSelected;

        public ClientesForm()
        {
            InitializeComponent();
        }

        public void SetSearchMode()
        {
            buttonsPanel.Visible = false;
            _isSearchMode = true;
        }

        private void ClientesForm_Load(object sender, EventArgs e)
        {
            var dataSource = _clienteManager.GetAll();
            if (_isSearchMode)
            {
                dataSource.Remove(new Cliente() { UserID = Session.User.UserID });
            }
            dgvClientes.AutoGenerateColumns = false;
            dgvClientes.DataSourceChanged += new EventHandler(dgvClientes_DataSourceChanged);
            dataSource.Remove(new Cliente() { UserID = Session.User.UserID });
            dgvClientes.DataSource = dataSource;
            dgvClientes.DoubleClick += new EventHandler(dgvClientes_DoubleClick);
        }

        void dgvClientes_DataSourceChanged(object sender, EventArgs e)
        {
            var dataSource = dgvClientes.DataSource as BindingList<Cliente>;
            lblResults.Text = dataSource.Count.ToString();
        }

        void dgvClientes_DoubleClick(object sender, EventArgs e)
        {
            if (dgvClientes.SelectedRows == null || dgvClientes.SelectedRows.Count == 0) return;
            var row = dgvClientes.SelectedRows[0];
            var cliente = row.DataBoundItem as Cliente;
            if (OnUserSelected != null)
            {
                OnUserSelected(this, new UserSelectedEventArgs()
                {
                    User = cliente as User
                });
            }
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
                    _clienteManager.Delete(cliente);
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
            var dataSource = dgvClientes.DataSource as BindingList<Cliente>;
            var cliente = e.User as Cliente;
            if (dataSource.Contains(cliente)) dataSource.Remove(cliente);
            dataSource.Add(cliente);
            dgvClientes.DataSource = new BindingList<Cliente>(dataSource.OrderBy(x => x.Apellido + x.Nombre).ToList());
            dgvClientes.Refresh();
            MessageBox.Show("Se han guardado los datos del cliente " + e.Username);
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var regForm = new RegistroForm();
            regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
            regForm.Profile = Profile.Cliente;
            ViewsManager.LoadModal(regForm);
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtApellido.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtDNI.Text = string.Empty;
            dgvClientes.DataSource = _clienteManager.GetAll();
            dgvClientes.Refresh();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            long dni = 0;
            if (!string.IsNullOrEmpty(txtDNI.Text) && !long.TryParse(txtDNI.Text, out dni))
            {
                MessageBox.Show("El DNI debe ser numérico");
                return;
            }
            var clientes = _clienteManager.GetAll();
            if (!string.IsNullOrEmpty(txtApellido.Text))
            {
                clientes = new BindingList<Cliente>(clientes.Where(x => x.Apellido.ToLowerInvariant().Contains(txtApellido.Text.ToLowerInvariant())).ToList());
            }
            if (!string.IsNullOrEmpty(txtNombre.Text))
            {
                clientes = new BindingList<Cliente>(clientes.Where(x => x.Nombre.ToLowerInvariant().Contains(txtNombre.Text.ToLowerInvariant())).ToList());
            }
            if (!string.IsNullOrEmpty(txtEmail.Text))
            {
                clientes = new BindingList<Cliente>(clientes.Where(x => x.DetalleEntidad.Email.ToLowerInvariant().Contains(txtEmail.Text.ToLowerInvariant())).ToList());
            }
            if (!string.IsNullOrEmpty(txtDNI.Text))
            {
                clientes = new BindingList<Cliente>(clientes.Where(x => x.DNI == dni).ToList());
            }
            clientes.Remove(new Cliente() { UserID = Session.User.UserID });
            dgvClientes.DataSource = new BindingList<Cliente>(clientes.OrderBy(x => x.Apellido + x.Nombre).ToList());
            dgvClientes.Refresh();
        }
    }
}
