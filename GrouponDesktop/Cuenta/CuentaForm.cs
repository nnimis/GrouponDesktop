using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Business;
using GrouponDesktop.Core;

namespace GrouponDesktop.Cuenta
{
    public partial class CuentaForm : Form
    {
        public CuentaForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                MessageBox.Show("Las contraseñas no coinciden!");
                return;
            }
            var loginService = new LoginService();
            var success = loginService.UpdateUserPassword(Session.User, txtActual.Text, txtPassword.Text);
            if(success)
                MessageBox.Show("Contraseñas actualizada correctamente!");
            else
                MessageBox.Show("La contraseña actual ingresada no es correcta");
        }

        private void btnEliminarCuenta_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Confirma que desea eliminar la cuenta?", "Confirmar eliminar cuenta", MessageBoxButtons.OKCancel)
                == DialogResult.OK)
            {
                var usersManager = new UsersManager();
                usersManager.DeleteAccount(Session.User);
                MessageBox.Show("Su cuenta ha sido eliminada del sistema!");
            }
            Session.Close();
        }
    }
}
