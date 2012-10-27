using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data;
using System.Configuration;
using System.Data;
using GrouponDesktop.Common;
using System.ComponentModel;

namespace GrouponDesktop.Business
{
    public class RolesManager
    {
        public BindingList<Rol> GetRoles()
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(
                ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetRoles"
            );
            var roles = new BindingList<Rol>();
            var functionalitiesManager = new FunctionalitiesManager();
            foreach (DataRow row in result.Rows)
            {
                var rol = new Rol()
                {
                    ID = int.Parse(row["ID"].ToString()),
                    Nombre = row["Descripcion"].ToString(),
                    Functionalities = functionalitiesManager.GetRoleFunctionalities(int.Parse(row["ID"].ToString()))
                };
                roles.Add(rol);
            }

            return roles;
        }

        public void DeleteRole(Rol rol)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.DeleteRole", SqlDataAccessArgs
                .CreateWith("@Rol_ID", rol.ID)
            .Arguments);
        }

        public void SaveRole(Rol rol)
        {
            if (rol.ID > 0) UpdateRole(rol);
            else InsertRole(rol);
        }

        private void InsertRole(Rol rol)
        {
            var roleId = SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertRole", SqlDataAccessArgs
                .CreateWith("@Description", rol.Nombre)
            .Arguments);
            rol.ID = roleId;
            UpdateRoleFunctionalities(rol);
        }

        private void UpdateRole(Rol rol)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.UpdateRole", SqlDataAccessArgs
                .CreateWith("@Description", rol.Nombre)
                .And("@ID", rol.ID)
            .Arguments);

            UpdateRoleFunctionalities(rol);
        }

        private void UpdateRoleFunctionalities(Rol rol)
        {
            var manager = new FunctionalitiesManager();
            if(rol.ID > 0)
                manager.DeleteRoleFunctionalities(rol);
            foreach (var functionality in rol.Functionalities)
            {
                manager.InsertRoleFunctionality(rol, functionality);
            }
        }

        public int GetDefaultRoleID()
        {
            return SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetDefaultRoleID");
        }
    }
}
