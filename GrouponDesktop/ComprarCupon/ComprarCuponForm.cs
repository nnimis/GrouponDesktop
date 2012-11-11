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
using GrouponDesktop.Business;

namespace GrouponDesktop.ComprarCupon
{
    [PermissionRequired(Functionalities.ComprarCupones)]
    public partial class ComprarCuponForm : Form
    {
        private CuponManager _manager = new CuponManager();

        public ComprarCuponForm()
        {
            InitializeComponent();
        }

        private void ComprarCuponForm_Load(object sender, EventArgs e)
        {
            dataGridView.AutoGenerateColumns = false;
            dataGridView.DataSource = _manager.GetAll(new Cliente() { UserID = Session.User.UserID });
        }

        private void btnComprar_Click(object sender, EventArgs e)
        {
            if (dataGridView.SelectedRows == null || dataGridView.SelectedRows.Count == 0) return;
            var row = dataGridView.SelectedRows[0];
            var cupon = row.DataBoundItem as Cupon;
            if(MessageBox.Show(string.Format("Desea comprar la oferta '{0}'?", cupon.Descripcion), "Confirmar compra", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                var nroCupon = _manager.ComprarCupon(cupon, new Cliente() { UserID = Session.User.UserID });
                MessageBox.Show(string.Format("Ha comprado la oferta! el código es '{0}{1}'", cupon.Codigo, nroCupon));
            }
        }
    }
}
