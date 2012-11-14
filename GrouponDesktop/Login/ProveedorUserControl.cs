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
            if (string.IsNullOrEmpty(txtCUIT.Text.Trim()))
                throw new Exception("El CUIT es obligatorio!");
            if (string.IsNullOrEmpty(txtRazonSocial.Text.Trim()))
                throw new Exception("La Razón Social es obligatoria!");
            _proveedor.CUIT = txtCUIT.Text.Trim();
            _proveedor.NombreContacto = txtContacto.Text.Trim();
            _proveedor.RazonSocial = txtRazonSocial.Text.Trim();
            _proveedor.Rubro = (Rubro)cbxRubro.SelectedItem;
            _proveedor.DetalleEntidad = new DetalleEntidad()
            {
                Ciudad = (City)cbxCiudad.SelectedItem,
                CP = txtCP.Text.Trim(),
                Email = txtMail.Text.Trim(),
                Direccion = txtDireccion.Text.Trim(),
                Telefono = telefono
            };

            return _proveedor;
        }

        public void SetUser(Proveedor proveedor)
        {
            _proveedor = proveedor;
            txtContacto.Text = proveedor.NombreContacto.Trim();
            txtCUIT.Text = proveedor.CUIT.Trim();
            txtRazonSocial.Text = proveedor.RazonSocial.Trim();
            txtCP.Text = proveedor.DetalleEntidad.CP.Trim();
            txtDireccion.Text = proveedor.DetalleEntidad.Direccion.Trim();
            txtTelefono.Text = proveedor.DetalleEntidad.Telefono.ToString();
            txtMail.Text = proveedor.DetalleEntidad.Email.Trim();
            cbxCiudad.SelectedItem = proveedor.DetalleEntidad.Ciudad;
            cbxRubro.SelectedItem = proveedor.Rubro;
        }

        private void ProveedorUserControl_Load(object sender, EventArgs e)
        {
            
        }
    }
}
