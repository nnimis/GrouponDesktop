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

namespace GrouponDesktop.HistorialCupones
{
    [PermissionRequired(Functionalities.VerHistorialCupones)]
    public partial class HistorialCuponesForm : Form
    {
        public HistorialCuponesForm()
        {
            InitializeComponent();
        }
    }
}
