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

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (OnUserCreated != null)
                OnUserCreated(this, new UserCreatedEventArgs() { Username = this.txtUsername.Text, Password = this.txtPassword.Text });
        }
    }
}
