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
            dataGridView.DataSource = _manager.GetAll(new Cliente() { UserID = Session.User.UserID }, dtpDesde.Value, dtpHasta.Value);
            dataGridView.Refresh();
        }

        private void btnPedirDevolucion_Click(object sender, EventArgs e)
        {
            var frm = new PedirDevolucion.PedirDevolucionForm();
            ViewsManager.LoadModal(frm);
        }
    }
}
