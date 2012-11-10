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

namespace GrouponDesktop.PublicarCupon
{
    [PermissionRequired(Functionalities.PublicarCupones)]
    public partial class PublicarCuponForm : Form
    {
        private CuponManager _manager = new CuponManager();

        public PublicarCuponForm()
        {
            InitializeComponent();
        }

        private void PublicarCuponForm_Load(object sender, EventArgs e)
        {
            dataGridView.AutoGenerateColumns = false;
            dataGridView.DataSource = _manager.GetAllToPublish();
        }

        private void btnPublicar_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Confirma que desea publicar los cupones seleccionados?", "Confirmar publicación", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                if (dataGridView.Rows != null && dataGridView.Rows.Count > 0)
                {
                    var dataSource = (BindingList<Cupon>)dataGridView.DataSource;
                    foreach (DataGridViewRow row in dataGridView.Rows)
                    {
                        var cell = row.Cells[Publicar.Name] as DataGridViewCheckBoxCell;
                        Cupon cupon = null;
                        if(Convert.ToBoolean(cell.Value))
                        {
                            cupon = row.DataBoundItem as Cupon;
                            _manager.Publish(cupon);
                            dataSource.Remove(cupon);
                        }
                    }
                    dataGridView.Refresh();
                    MessageBox.Show("Se han publicado los cupones seleccionados");
                }
            }
        }
    }
}
