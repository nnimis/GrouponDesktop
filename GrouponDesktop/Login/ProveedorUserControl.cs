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
        private Proveedor _proveedor;

        public ProveedorUserControl()
        {
            InitializeComponent();
            _proveedor = new Proveedor();
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

        public Proveedor GetProveedor()
        {
            long telefono = 0;
            if (!long.TryParse(txtTelefono.Text, out telefono))
                throw new Exception("El teléfono debe ser numérico!");
            if (string.IsNullOrEmpty(txtCUIT.Text))
                throw new Exception("El CUIT es obligatorio!");
            if (string.IsNullOrEmpty(txtRazonSocial.Text))
                throw new Exception("La Razón Social es obligatoria!");
            _proveedor.CUIT = txtCUIT.Text;
            _proveedor.NombreContacto = txtContacto.Text;
            _proveedor.RazonSocial = txtRazonSocial.Text;
            _proveedor.Rubro = (Rubro)cbxRubro.SelectedItem;
            _proveedor.DetalleEntidad = new DetalleEntidad()
            {
                Ciudad = (City)cbxCiudad.SelectedItem,
                CP = txtCP.Text,
                Email = txtMail.Text,
                Direccion = txtDireccion.Text,
                Telefono = telefono
            };

            return _proveedor;
        }

        public void SetUser(Proveedor proveedor)
        {
            _proveedor = proveedor;
            txtContacto.Text = proveedor.NombreContacto;
            txtCUIT.Text = proveedor.CUIT;
            txtRazonSocial.Text = proveedor.RazonSocial;
            txtCP.Text = proveedor.DetalleEntidad.CP;
            txtDireccion.Text = proveedor.DetalleEntidad.Direccion;
            txtTelefono.Text = proveedor.DetalleEntidad.Telefono.ToString();
            txtMail.Text = proveedor.DetalleEntidad.Email;
            cbxCiudad.SelectedItem = proveedor.DetalleEntidad.Ciudad;
            cbxRubro.SelectedItem = proveedor.Rubro;
        }

        private void ProveedorUserControl_Load(object sender, EventArgs e)
        {
            
        }
    }
}
