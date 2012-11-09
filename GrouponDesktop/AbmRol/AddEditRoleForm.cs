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
using GrouponDesktop.AbmRol;
using GrouponDesktop.Core;

namespace GrouponDesktop
{
    [NonNavigable]
    public partial class AddEditRoleForm : Form
    {
        public AddEditRoleForm() : this(new Rol()) { }

        public AddEditRoleForm(Rol rol)
        {
            InitializeComponent();
            this.Rol = rol;
        }

        public event EventHandler<RoleUpdatedEventArgs> OnRoleUpdated;

        private Rol Rol { get; set; }

        private void AddEditRoleForm_Load(object sender, EventArgs e)
        {
            ProcessForm();
        }

        private void ProcessForm()
        {
            var mgr = new FunctionalitiesManager();
            var functionalities = mgr.GetAllFunctionalities();
            foreach (var item in functionalities)
            {
                lstFuncionalidades.Items.Add(item, RoleHasFunctionality(item));
            }
            txtNombre.Text = Rol.Nombre;
        }

        private bool RoleHasFunctionality(Functionalities functionality)
        {
            if (Rol == null || Rol.Functionalities == null) return false;
            return Rol.Functionalities.Contains(functionality);
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombre.Text.Trim()))
            {
                MessageBox.Show("El nombre del Rol no puede ser nulo");
                return;
            }

            Rol.Functionalities = new List<Functionalities>();
            foreach (Functionalities item in lstFuncionalidades.CheckedItems)
            {
                Rol.Functionalities.Add(item);
            }
            Rol.Nombre = txtNombre.Text;

            if (OnRoleUpdated != null)
                OnRoleUpdated(this, new RoleUpdatedEventArgs() { Rol = this.Rol });
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
