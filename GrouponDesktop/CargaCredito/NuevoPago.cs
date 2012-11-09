using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Business;
using GrouponDesktop.Common;
using System.Configuration;
using GrouponDesktop.Core;

namespace GrouponDesktop.CargaCredito
{
    [NonNavigable]
    public partial class NuevoPago : Form
    {
        private PagosManager _manager = new PagosManager();
        public event EventHandler<PagoAddedEventArgs> OnPagoAdded;

        public NuevoPago()
        {
            InitializeComponent();
            foreach (var tipoPago in _manager.GetTipoPagos())
            {
                cbxTipoPago.Items.Add(tipoPago);
            }
            cbxTipoPago.SelectedIndex = 0;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void cbxTipoPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            var enable = ((TipoPago)cbxTipoPago.SelectedItem) == TipoPago.Tarjeta;
            txtBanco.Enabled = enable;
            txtTarjeta.Enabled = enable;
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            double monto = 0;
            var tipoPago = (TipoPago)cbxTipoPago.SelectedItem;
            if (!double.TryParse(txtMonto.Text, out monto))
            {
                MessageBox.Show("El monto debe ser numérico");
                return;
            }
            if (monto <= 15)
            {
                MessageBox.Show("El monto debe ser mayor a $15");
                return;
            }
            if (tipoPago == TipoPago.Tarjeta)
            {
                if (string.IsNullOrEmpty(txtBanco.Text))
                {
                    MessageBox.Show("Debe ingresar un banco");
                    return;
                }
                if (string.IsNullOrEmpty(txtTarjeta.Text))
                {
                    MessageBox.Show("Debe ingresar los datos de la tarjeta");
                    return;
                }
            }
            if (OnPagoAdded != null)
            {
                OnPagoAdded(this, new PagoAddedEventArgs()
                {
                    Pago = new Pago()
                    {
                        Banco = txtBanco.Text,
                        Credito = monto,
                        Tarjeta = txtTarjeta.Text,
                        TipoPago = tipoPago,
                        Fecha = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"])
                    }
                });
            }
        }
    }
}
