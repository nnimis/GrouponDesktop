using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;

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
            throw new Exception("Usuario no encontrado");
            //TODO: levantar este usuario de la DB, validar user y pass
            var user = new User();
            user.Permissions.Add(Functionalities.AdministrarClientes);
            user.Permissions.Add(Functionalities.AdministrarProveedores);
            user.Permissions.Add(Functionalities.PublicarCupones);

            //Iniciar sesion con el usuario cargado
            Session.StartSession(user);
            ViewsManager.ClearViews();
        }
    }
}
