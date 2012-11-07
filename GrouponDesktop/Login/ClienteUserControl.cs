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
        private Cliente _cliente;

        public Cliente GetCliente()
        {
            var ciudades = clbCiudades.CheckedItems.Cast<City>().ToList();
            _cliente.Apellido = txtApellido.Text;
            _cliente.Nombre = txtNombre.Text;
            _cliente.DNI = long.Parse(txtDNI.Text);
            _cliente.FechaNacimiento = dtFechaNacimiento.Value;
            _cliente.Ciudades = ciudades;
            _cliente.DetalleEntidad.CP = txtCP.Text;
            _cliente.DetalleEntidad.Direccion = txtDireccion.Text;
            _cliente.DetalleEntidad.Telefono = long.Parse(txtTelefono.Text.Trim().Replace("-", ""));
            _cliente.DetalleEntidad.Email = txtMail.Text;
            _cliente.DetalleEntidad.Ciudad = (City)cbxCiudad.SelectedItem;

            return _cliente;
        }

        public void SetUser(Cliente cliente)
        {
            _cliente = cliente;
            txtApellido.Text = cliente.Apellido;
            txtNombre.Text = cliente.Nombre;
            txtDNI.Text = cliente.DNI.ToString();
            dtFechaNacimiento.Value = cliente.FechaNacimiento;
            txtCP.Text = cliente.DetalleEntidad.CP;
            txtDireccion.Text = cliente.DetalleEntidad.Direccion;
            txtTelefono.Text = cliente.DetalleEntidad.Telefono.ToString();
            txtMail.Text = cliente.DetalleEntidad.Email;
            cbxCiudad.SelectedItem = cliente.DetalleEntidad.Ciudad;
            foreach (var ciudad in cliente.Ciudades)
            {
                clbCiudades.SetItemChecked(clbCiudades.Items.IndexOf(ciudad), true);
            }
        }

        public ClienteUserControl()
        {
            InitializeComponent();
            _cliente = new Cliente();
            var manager = new CiudadesManager();
            var cities = manager.GetAll();
            clbCiudades.DisplayMember = "Name";
            cbxCiudad.DisplayMember = "Name";
            cities.ForEach(x => clbCiudades.Items.Add(x, false));
            cities.ForEach(x => cbxCiudad.Items.Add(x));
            cbxCiudad.SelectedIndex = 0;
        }

        private void ClienteUserControl_Load(object sender, EventArgs e)
        {
            
        }
    }
}
