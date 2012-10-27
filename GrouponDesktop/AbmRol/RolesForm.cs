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

namespace GrouponDesktop.AbmRol
{
    [PermissionRequired(Functionalities.AdministrarRoles)]
    public partial class RolesForm : Form
    {
        private RolesManager rolesManager = new RolesManager();

        public RolesForm()
        {
            InitializeComponent();
        }

        private void RolesForm_Load(object sender, EventArgs e)
        {
            var bindingSource = new BindingSource();
            var rolesTable = rolesManager.GetRoles();
            rolesDataGridView.AutoGenerateColumns = false;
            rolesDataGridView.DataSource = rolesTable;
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var addEditForm = new AddEditRoleForm();
            addEditForm.OnRoleUpdated += new EventHandler<RoleUpdatedEventArgs>(addEditForm_OnRoleUpdated);
            ViewsManager.LoadModal(addEditForm);
        }

        void addEditForm_OnRoleUpdated(object sender, RoleUpdatedEventArgs e)
        {
            try
            {
                var dataSource = rolesDataGridView.DataSource as BindingList<Rol>;
                if (e.Rol.ID == 0)
                {
                    if (dataSource.Where(x => x.Nombre.Trim().ToUpperInvariant() == e.Rol.Nombre.Trim().ToUpperInvariant()).Count() >= 1)
                    {
                        MessageBox.Show("Ya hay un rol con ese nombre, ingrese uno nuevo");
                        return;
                    }
                }

                var manager = new RolesManager();
                manager.SaveRole(e.Rol);
                MessageBox.Show(string.Format("Rol {0} guardado correctamente", e.Rol.Nombre));

                if (dataSource.Contains(e.Rol)) dataSource.Remove(e.Rol);
                dataSource.Add(e.Rol);
                rolesDataGridView.Refresh();
            }
            catch
            {
                MessageBox.Show("Error al guardar el rol");
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (rolesDataGridView.SelectedRows == null || rolesDataGridView.SelectedRows.Count == 0) return;
            var row = rolesDataGridView.SelectedRows[0];
            var rol = row.DataBoundItem as Rol;
            if (rol.ID == Session.DefaultRoleID)
            {
                MessageBox.Show("Rol no editable");
                return;
            }
            if (MessageBox.Show(string.Format("Confirma que desea eliminar el rol {0}?", rol.Nombre)
                , "Eliminar rol", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {
                    rolesManager.DeleteRole(rol);
                    var dataSource = rolesDataGridView.DataSource as BindingList<Rol>;
                    dataSource.Remove(rol);
                    rolesDataGridView.Refresh();
                    MessageBox.Show(string.Format("Rol {0} eliminado", rol.Nombre));
                }
                catch
                {
                    MessageBox.Show("Error al eliminar el rol");
                }
            }
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (rolesDataGridView.SelectedRows == null || rolesDataGridView.SelectedRows.Count == 0) return;
            var row = rolesDataGridView.SelectedRows[0];
            var rol = row.DataBoundItem as Rol;
            if (rol.ID == Session.DefaultRoleID)
            {
                MessageBox.Show("Rol no editable");
                return;
            }
            var addEditForm = new AddEditRoleForm(rol);
            addEditForm.OnRoleUpdated += new EventHandler<RoleUpdatedEventArgs>(addEditForm_OnRoleUpdated);
            ViewsManager.LoadModal(addEditForm);
        }
    }
}
