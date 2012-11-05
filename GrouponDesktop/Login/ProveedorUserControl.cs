using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Business;
using GrouponDesktop.Common;

namespace GrouponDesktop.Login
{
    public partial class ProveedorUserControl : UserControl
    {
        public ProveedorUserControl()
        {
            InitializeComponent();
        }

        public Proveedor GetProveedor()
        {
            return new Proveedor()
            {
                CUIT = txtCUIT.Text,
                NombreContacto = txtContacto.Text,
                RazonSocial = txtRazonSocial.Text,
                Rubro = (Rubro)cbxRubro.SelectedItem,
                DetalleEntidad = new DetalleEntidad()
                {
                    Ciudad = (City)cbxCiudad.SelectedItem,
                    CP = txtCP.Text,
                    Email = txtMail.Text,
                    Direccion = txtDireccion.Text,
                    Telefono = long.Parse(txtTelefono.Text)
                }
            };
        }

        private void ProveedorUserControl_Load(object sender, EventArgs e)
        {
            var citiesManager = new CiudadesManager();
            var cities = citiesManager.GetAll();
            var rubrosManager = new RubrosManager();
            cbxRubro.DataSource = rubrosManager.GetAll();
            cbxRubro.DisplayMember = "Name";
            cbxRubro.SelectedIndex = 0;
            cbxCiudad.DataSource = cities;
            cbxCiudad.DisplayMember = "Name";
            cbxCiudad.SelectedIndex = 0;
        }
    }
}
