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
            var svc = new LoginService();
            var user = svc.Login(txtUserName.Text, txtPassword.Text);
            
            //Iniciar sesion con el usuario cargado
            Session.StartSession(user);
            ViewsManager.ClearViews();
        }
    }
}
