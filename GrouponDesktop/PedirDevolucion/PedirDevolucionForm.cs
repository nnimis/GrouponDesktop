using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;
using GrouponDesktop.Common;

namespace GrouponDesktop.PedirDevolucion
{
    [PermissionRequired(Functionalities.PedirDevoluciones)]
    [NonNavigable]
    public partial class PedirDevolucionForm : Form
    {
        public event EventHandler<CuponDevueltoEventArgs> OnCuponDevuelto;
        private CompraCupon _compraCupon;

        public PedirDevolucionForm(CompraCupon compraCupon)
        {
            InitializeComponent();
            _compraCupon = compraCupon;
            txtCodigo.Text = compraCupon.Codigo;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (OnCuponDevuelto != null)
            {
                OnCuponDevuelto(this, new CuponDevueltoEventArgs()
                {
                    Mensaje = txtMensaje.Text,
                    CompraCupon = _compraCupon
                });
            }
        }
    }
}
