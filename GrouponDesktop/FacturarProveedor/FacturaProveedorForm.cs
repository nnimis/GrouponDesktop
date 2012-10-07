using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;

namespace GrouponDesktop.FacturarProveedor
{
    [PermissionRequired(Functionalities.Facturar)]
    public partial class FacturaProveedorForm : Form
    {
        public FacturaProveedorForm()
        {
            InitializeComponent();
        }
    }
}
