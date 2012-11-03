using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Common;
using GrouponDesktop.Business;

namespace GrouponDesktop.Login
{
    public partial class ClienteUserControl : UserControl
    {
        public Cliente GetCliente()
        {
            var ciudades = clbCiudades.CheckedItems.Cast<City>().ToList();
            return new Cliente()
            {
                Apellido = txtApellido.Text,
                Nombre = txtNombre.Text,
                DNI = long.Parse(txtDNI.Text),
                FechaNacimiento = dtFechaNacimiento.Value,
                Ciudades = ciudades,
                DetalleEntidad = new DetalleEntidad()
                {
                    CP = txtCP.Text,
                    Direccion = txtDireccion.Text,
                    Telefono = long.Parse(txtTelefono.Text.Trim().Replace("-", "")),
                    Email = txtMail.Text,
                    Ciudad = (City)cbxCiudad.SelectedItem
                }
            };
        }

        public ClienteUserControl()
        {
            InitializeComponent();
        }

        private void ClienteUserControl_Load(object sender, EventArgs e)
        {
            var manager = new CiudadesManager();
            var cities = manager.GetAll();
            clbCiudades.DisplayMember = "Name";
            cbxCiudad.DisplayMember = "Name";
            cities.ForEach(x => clbCiudades.Items.Add(x, true));
            cities.ForEach(x => cbxCiudad.Items.Add(x));
            cbxCiudad.SelectedIndex = 0;
        }
    }
}
