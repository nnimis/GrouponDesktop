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
using System.Reflection;
using GrouponDesktop.Login;
using GrouponDesktop.Core;

namespace GrouponDesktop
{
    public partial class MainView : Form
    {
        public MainView()
        {
            InitializeComponent();
        }

        private void MainView_Load(object sender, EventArgs e)
        {
            //Setear a esta ventana como la principal del sistema
            ViewsManager.SetMainWindow(this);

            //Mostrar Login
            ViewsManager.LoadView(new LoginForm());
        }
    }
}
