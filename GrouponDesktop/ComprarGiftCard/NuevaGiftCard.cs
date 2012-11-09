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
using GrouponDesktop.Login;
using GrouponDesktop.Common;
using GrouponDesktop.AbmCliente;
using System.Configuration;

namespace GrouponDesktop.ComprarGiftCard
{
    public partial class NuevaGiftCard : Form
    {
        private User _user;
        private ClientesForm _clientesForm;
        public event EventHandler<NewGiftCardEventArgs> OnGiftCardCreated;

        public NuevaGiftCard()
        {
            InitializeComponent();
            var manager = new GiftCardManager();
            cbxMonto.DataSource = manager.GetMontos();
            cbxMonto.SelectedIndex = 0;
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (_user == null)
            {
                MessageBox.Show("Debe seleccionar un usuario");
            }
            if (OnGiftCardCreated != null)
            {
                OnGiftCardCreated(this, new NewGiftCardEventArgs()
                {
                    GiftCard = new GiftCard()
                    {
                        ClienteOrigen = new Cliente() { UserID = Session.User.UserID },
                        ClienteDestino = _user as Cliente,
                        Credito = (double)cbxMonto.SelectedItem,
                        Fecha = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"])
                    }
                });
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            if (_clientesForm == null)
            {
                _clientesForm = new ClientesForm();
                _clientesForm.SetSearchMode();
                _clientesForm.OnUserSelected += new EventHandler<UserSelectedEventArgs>(clientesForm_OnUserSelected);
            }
            ViewsManager.LoadModal(_clientesForm);
        }

        void clientesForm_OnUserSelected(object sender, UserSelectedEventArgs e)
        {
            _user = e.User;
            txtCliente.Text = _user.UserName;
            _clientesForm.Hide();
        }
    }
}
