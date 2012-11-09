using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Business;
using GrouponDesktop.Common;
using GrouponDesktop.Login;
using GrouponDesktop.Core;

namespace GrouponDesktop
{
    [NonNavigable]
    public partial class RegistroForm : Form
    {
        public event EventHandler<UserSavedEventArgs> OnUserSaved;
        private List<Profile> Profiles;
        private ClienteUserControl clienteUserControl = new ClienteUserControl();
        private ProveedorUserControl proveedorUserControl = new ProveedorUserControl();
        private Proveedor _proveedor = new Proveedor();
        private Cliente _cliente = new Cliente();
        public Profile Profile
        {
            get
            {
                return (Profile)cbxProfiles.SelectedItem;
            }
            set
            {
                cbxProfiles.SelectedItem = value;
                cbxProfiles.Enabled = false;
                cbxProfiles.Visible = false;
                lblPerfil.Visible = false;
            }
        }

        public RegistroForm()
        {
            InitializeComponent();
            var manager = new ProfileManager();
            Profiles = manager.GetRegistrationProfiles();
            Profiles.ForEach(x => cbxProfiles.Items.Add(x));
            cbxProfiles.SelectedIndex = 0;
        }

        public void SetUser(User user)
        {
            txtUsername.Text = user.UserName;
            txtUsername.Enabled = false;
            txtPassword.Enabled = false;
            txtConfirmPassword.Enabled = false;
            cbxProfiles.Enabled = false;
            if (user is Cliente)
            {
                _cliente = user as Cliente;
                cbxProfiles.SelectedItem = Profile.Cliente;
                clienteUserControl.SetUser(_cliente);
            }
            else
            {
                _proveedor = user as Proveedor;
                cbxProfiles.SelectedItem = Profile.Proveedor;
                proveedorUserControl.SetUser(_proveedor);
            }
        }

        private void RegistroForm_Load(object sender, EventArgs e)
        {
            
        }

        private void cbxProfiles_SelectedIndexChanged(object sender, EventArgs e)
        {
            userPanel.Controls.Clear();
            if (Profile == Profile.Cliente)
            {
                userPanel.Controls.Add(clienteUserControl);
            }
            else
            {
                userPanel.Controls.Add(proveedorUserControl);
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            User user = null;
            if (Profile == Profile.Cliente)
            {
                _cliente = ((ClienteUserControl)clienteUserControl).GetCliente();
                _cliente.UserName = txtUsername.Text;
                var manager = new ClienteManager();
                manager.GuardarCliente(_cliente, txtPassword.Text);
                user = _cliente;
            }
            else
            {
                _proveedor = ((ProveedorUserControl)proveedorUserControl).GetProveedor();
                _proveedor.UserName = txtUsername.Text;
                var manager = new ProveedorManager();
                manager.GuardarProveedor(_proveedor, txtPassword.Text);
                user = _proveedor; 
            }

            if (OnUserSaved != null)
            {
                OnUserSaved(this, new UserSavedEventArgs() { Username = this.txtUsername.Text, Password = this.txtPassword.Text, User = user });
                this.Close();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
