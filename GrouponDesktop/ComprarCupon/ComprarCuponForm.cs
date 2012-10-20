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

namespace GrouponDesktop.ComprarCupon
{
    [PermissionRequired(Functionalities.ComprarCupones)]
    public partial class ComprarCuponForm : Form
    {
        public ComprarCuponForm()
        {
            InitializeComponent();
        }
    }
}
