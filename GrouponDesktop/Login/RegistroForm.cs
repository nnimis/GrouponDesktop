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

namespace GrouponDesktop.Login
{
    public partial class RegistroForm : Form
    {
        public event EventHandler<UserCreatedEventArgs> OnUserCreated;
        private List<Profile> Profiles;
        private UserControl clienteUserControl = new ClienteUserControl();
        private UserControl proveedorUserControl = new ProveedorUserControl();
        private Profile _profile
        {
            get
            {
                return (Profile)cbxProfiles.SelectedItem;
            }
        }

        public RegistroForm()
        {
            InitializeComponent();
        }

        private void RegistroForm_Load(object sender, EventArgs e)
        {
            var manager = new ProfileManager();
            Profiles = manager.GetRegistrationProfiles();
            Profiles.ForEach(x => cbxProfiles.Items.Add(x));
            cbxProfiles.SelectedIndex = 0;
        }

        private void cbxProfiles_SelectedIndexChanged(object sender, EventArgs e)
        {
            userPanel.Controls.Clear();
            if (_profile == Profile.Cliente)
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
            try
            {
                if (_profile == Profile.Cliente)
                {
                    var cliente = ((ClienteUserControl)clienteUserControl).GetCliente();
                    cliente.UserName = txtUsername.Text;
                    var manager = new ClienteManager();
                    manager.GuardarCliente(cliente, txtPassword.Text);
                }
                else
                {
                    var proveedor = ((ProveedorUserControl)proveedorUserControl).GetProveedor();
                    proveedor.UserName = txtUsername.Text;
                    var manager = new ProveedorManager();
                    manager.GuardarProveedor(proveedor, txtPassword.Text);
                }

                if (OnUserCreated != null)
                {
                    OnUserCreated(this, new UserCreatedEventArgs() { Username = this.txtUsername.Text, Password = this.txtPassword.Text });
                    this.Close();
                }
            }
            catch
            {
                MessageBox.Show("Por favor, verifique los datos ingresados");
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
