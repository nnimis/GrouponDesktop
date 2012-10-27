using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using Data;
using System.Configuration;
using System.Data;

namespace GrouponDesktop.Business
{
    public class FunctionalitiesManager
    {
        public List<Functionalities> GetAllFunctionalities()
        {
            return Enum.GetValues(typeof(Functionalities)).Cast<Functionalities>().ToList();
        }

        public void DeleteRoleFunctionalities(Rol rol)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.DeleteRoleFunctionalities", SqlDataAccessArgs
                .CreateWith("@Rol_ID", rol.ID)
            .Arguments);
        }

        public void InsertRoleFunctionality(Rol rol, Functionalities functionality)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertRoleFunctionality", SqlDataAccessArgs
                .CreateWith("@Rol_ID", rol.ID)
                .And("@Funcionalidad", functionality.ToString())
            .Arguments);
        }

        public List<Functionalities> GetRoleFunctionalities(int roleId)
        {
            var ret = new List<Functionalities>();
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetRoleFunctionalities", SqlDataAccessArgs
                .CreateWith("@Rol_ID", roleId)
            .Arguments);

            if (result != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    var permission = row["Descripcion"].ToString();
                    var enumItem = (Functionalities)Enum.Parse(typeof(Functionalities), permission);
                    ret.Add(enumItem);
                }
            }

            return ret;
        }
    }
}
