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
using GrouponDesktop.Common;
using GrouponDesktop.Login;
using System.Configuration;

namespace GrouponDesktop.ArmarCupon
{
    [NonNavigable]
    public partial class NuevoCupon : Form
    {
        private double _precio;
        private double _precioFicticio;
        private int _cantidad;
        private int _cantidadPorUsuario;
        public event EventHandler<CuponSavedEventArgs> OnCuponSaved;

        public NuevoCupon()
        {
            InitializeComponent();
            var manager = new CiudadesManager();
            var cities = manager.GetAll();
            cities.ForEach(x => clbCiudades.Items.Add(x, false));
            clbCiudades.DisplayMember = "Name";
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void NuevoCupon_Load(object sender, EventArgs e)
        {
            txtCodigo.Text = CuponManager.GetCodigo();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!Validate()) return;
            var cupon = new Cupon()
            {
                Cantidad = _cantidad,
                CantidadPorUsuario = _cantidadPorUsuario,
                Ciudades = clbCiudades.CheckedItems.OfType<City>().ToList(),
                Codigo = txtCodigo.Text,
                Descripcion = txtDescripcion.Text,
                FechaPublicacion = dtpFechaPublicacion.Value,
                FechaVencimientoConsumo = dtpFechaVencimiento.Value,
                FechaVencimientoOferta = dtpFechaVigencia.Value,
                Precio = _precio,
                PrecioOriginal = _precioFicticio,
                Proveedor = new Proveedor() { UserID = Session.User.UserID, UserName = Session.User.UserName },
                Publicado = false
            };
            if (OnCuponSaved != null)
            {
                OnCuponSaved(this, new CuponSavedEventArgs()
                {
                    Cupon = cupon
                });
            }
        }

        private bool Validate()
        {
            var sysDate = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
            if (dtpFechaPublicacion.Value < sysDate)
            {
                MessageBox.Show(string.Format("La fecha de publicación no puede ser menor a ", sysDate.ToShortDateString()));
                return false;
            }
            if (dtpFechaVigencia.Value < dtpFechaPublicacion.Value)
            {
                MessageBox.Show("La fecha de vigencia no puede ser menor a la fecha de publicación");
                return false;
            }
            if (dtpFechaVencimiento.Value < dtpFechaVigencia.Value)
            {
                MessageBox.Show("La fecha de vencimiento no puede ser menor a la fecha de vigencia");
                return false;
            }
            if(!double.TryParse(txtPrecio.Text, out _precio))
            {
                MessageBox.Show("El precio real debe ser numérico");
                return false;
            }
            if (!double.TryParse(txtPrecioOriginal.Text, out _precioFicticio))
            {
                MessageBox.Show("El precio ficticio debe ser numérico");
                return false;
            }
            if (!int.TryParse(txtCantidad.Text, out _cantidad))
            {
                MessageBox.Show("La cantidad de cupones disponibles debe ser numérica");
                return false;
            }
            if (!int.TryParse(txtCantidadPorUsuario.Text, out _cantidadPorUsuario))
            {
                MessageBox.Show("La cantidad de cupones por usuario debe ser numérica");
                return false;
            }
            if (clbCiudades.CheckedItems.Count == 0)
            {
                MessageBox.Show("Debe seleccionar al menos una ciudad");
                return false;
            }

            return true;
        }
    }
}
