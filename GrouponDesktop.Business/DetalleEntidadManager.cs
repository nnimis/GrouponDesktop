using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GrouponDesktop.Business
{
    public class DetalleEntidadManager
    {
        public int AddDetalleEntidad(User user)
        {
            var transaction = SessionData.Contains("Transaction") ? SessionData.Get<SqlTransaction>("Transaction") : null;
            if (transaction != null)
            {
                return SqlDataAccess.ExecuteScalarQuery<int>(
                    "GRUPO_N.InsertDetalleEntidad", SqlDataAccessArgs
                    .CreateWith("@Telefono", user.DetalleEntidad.Telefono)
                    .And("@Email", user.DetalleEntidad.Email)
                    .And("@ID_Usuario", user.UserID)
                    .And("@Direccion", user.DetalleEntidad.Direccion)
                    .And("@ID_Ciudad", user.DetalleEntidad.Ciudad.ID)
                    .And("@CP", user.DetalleEntidad.CP)
                    .Arguments,
                    transaction);
            }
            return SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertDetalleEntidad", SqlDataAccessArgs
                .CreateWith("@Telefono", user.DetalleEntidad.Telefono)
                .And("@Email", user.DetalleEntidad.Email)
                .And("@ID_Usuario", user.UserID)
                .And("@Direccion", user.DetalleEntidad.Direccion)
                .And("@ID_Ciudad", user.DetalleEntidad.Ciudad.ID)
                .And("@CP", user.DetalleEntidad.CP)
            .Arguments);
        }

        internal void UpdateDetalleEntidad(User user)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.UpdateDetalleEntidad", SqlDataAccessArgs
                .CreateWith("@Telefono", user.DetalleEntidad.Telefono)
                .And("@Email", user.DetalleEntidad.Email)
                .And("@ID_Usuario", user.UserID)
                .And("@Direccion", user.DetalleEntidad.Direccion)
                .And("@ID_Ciudad", user.DetalleEntidad.Ciudad.ID)
                .And("@CP", user.DetalleEntidad.CP)
            .Arguments);
        }
    }
}
