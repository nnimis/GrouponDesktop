using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;
using GrouponDesktop.Business;
using System.Security.Cryptography;

namespace GrouponDesktop.Login
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            Login(txtUserName.Text, txtPassword.Text);
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            var registroForm = new RegistroForm();
            registroForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(registroForm_OnUserCreated);
            ViewsManager.LoadModal(registroForm);
        }

        private void registroForm_OnUserCreated(object sender, UserSavedEventArgs e)
        {
            Login(e.Username, e.Password);
        }

        private void Login(string userName, string pass)
        {
            var svc = new LoginService();
            var user = svc.Login(userName, pass);

            //Iniciar sesion con el usuario cargado
            Session.StartSession(user);
            ViewsManager.ClearViews();
        }
    }
}
