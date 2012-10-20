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

namespace GrouponDesktop.RegistroConsumoCupon
{
    [PermissionRequired(Functionalities.RegistrarConsumoCupones)]
    public partial class RegistroConsumoCuponForm : Form
    {
        public RegistroConsumoCuponForm()
        {
            InitializeComponent();
        }
    }
}
