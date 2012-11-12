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
using GrouponDesktop.PedirDevolucion;

namespace GrouponDesktop.HistorialCupones
{
    [PermissionRequired(Functionalities.VerHistorialCupones)]
    public partial class HistorialCuponesForm : Form
    {
        private CompraCuponManager _manager = new CompraCuponManager();

        public HistorialCuponesForm()
        {
            InitializeComponent();
        }

        private void HistorialCuponesForm_Load(object sender, EventArgs e)
        {
            dataGridView.AutoGenerateColumns = false;
            GetList();
        }

        private void btnRestablecer_Click(object sender, EventArgs e)
        {
            GetList();
        }

        private void GetList()
        {
            dataGridView.DataSource = _manager.GetAll(new Cliente() { UserID = Session.User.UserID }, Convert.ToDateTime("2000-01-01"), DateTime.Now);
            dataGridView.Refresh();
        }

        private void btnFiltrar_Click(object sender, EventArgs e)
        {
            if (dtpDesde.Value > dtpHasta.Value)
            {
                MessageBox.Show("La fecha desde debe ser menor o igual que la fecha hasta");
            }
            dataGridView.DataSource = _manager.GetAll(new Cliente() { UserID = Session.User.UserID }, dtpDesde.Value, dtpHasta.Value);
            dataGridView.Refresh();
        }

        private void btnPedirDevolucion_Click(object sender, EventArgs e)
        {
            if (dataGridView.SelectedRows == null || dataGridView.SelectedRows.Count == 0) return;
            var row = dataGridView.SelectedRows[0];
            var compraCupon = row.DataBoundItem as CompraCupon;
            var fechaVencimiento = new DateTime(compraCupon.FechaVencimiento.Year, compraCupon.FechaVencimiento.Month, compraCupon.FechaVencimiento.Day, 23, 59, 59);
            if (fechaVencimiento < DateTime.Now)
            {
                MessageBox.Show("La fecha límite de devolución de la compra ha expirado");
                return;
            }
            var frm = new PedirDevolucionForm(compraCupon);
            frm.OnCuponDevuelto += new EventHandler<CuponDevueltoEventArgs>(frm_OnCuponDevuelto);
            ViewsManager.LoadModal(frm);
        }

        void frm_OnCuponDevuelto(object sender, CuponDevueltoEventArgs e)
        {
            var compraCupon = e.CompraCupon;
            _manager.DevolverCompra(new Cliente() { UserID = Session.User.UserID }, compraCupon, e.Mensaje);
            var index = ((BindingList<CompraCupon>)dataGridView.DataSource).IndexOf(compraCupon);
            compraCupon.Estado = "Devuelto";
            ((BindingList<CompraCupon>)dataGridView.DataSource)[index] = compraCupon;
            dataGridView.Refresh();
            ((PedirDevolucionForm)sender).Close();
            MessageBox.Show("Se ha devuelto la compra");
        }
    }
}
