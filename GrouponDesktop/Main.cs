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

namespace GrouponDesktop
{
    public partial class Main : Form
    {
        public Main()
        {
            InitializeComponent();
        }

        private List<Cliente> Clientes { get; set; }

        private void button1_Click(object sender, EventArgs e)
        {
            ClienteManager mgr = new ClienteManager();
            
            dataGridView1.DataSource = mgr.ObtenerClientes();
        }
    }
}
