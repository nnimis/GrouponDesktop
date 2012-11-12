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

namespace GrouponDesktop.ListadoEstadistico
{
    [PermissionRequired(Functionalities.ListarEstadisticas)]
    public partial class ListadoEstadisticoForm : Form
    {
        private ReportManager _reportManager = new ReportManager();

        public ListadoEstadisticoForm()
        {
            InitializeComponent();
        }

        private void ListadoEstadisticoForm_Load(object sender, EventArgs e)
        {
            cbxReportType.DataSource = _reportManager.GetReportTypes();
            cbxReportType.SelectedIndex = 0;
            dtpHasta.Value = DateTime.Now;
            dtpDesde.Value = DateTime.Now.Subtract(TimeSpan.FromDays(180));
        }

        private void btnFiltrar_Click(object sender, EventArgs e)
        {
            if (dtpDesde.Value > dtpHasta.Value)
            {
                MessageBox.Show("La fecha desde debe ser menor o igual que la fecha hasta");
            }
            dataGridView.DataSource = _reportManager.GetReport(cbxReportType.SelectedItem as ReportType, dtpDesde.Value, dtpHasta.Value);
            dataGridView.Refresh();
        }
    }
}
