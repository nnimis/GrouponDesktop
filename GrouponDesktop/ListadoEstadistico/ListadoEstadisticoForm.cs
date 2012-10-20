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

namespace GrouponDesktop.ListadoEstadistico
{
    [PermissionRequired(Functionalities.ListarEstadisticas)]
    public partial class ListadoEstadisticoForm : Form
    {
        public ListadoEstadisticoForm()
        {
            InitializeComponent();
        }
    }
}
