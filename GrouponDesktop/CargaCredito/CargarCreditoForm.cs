using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;

namespace GrouponDesktop.CargaCredito
{
    [PermissionRequired(Functionalities.CargarCredito)]
    public partial class CargarCreditoForm : Form
    {
        public CargarCreditoForm()
        {
            InitializeComponent();
        }
    }
}
