using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using Data;
using System.Configuration;

namespace GrouponDesktop.Business
{
    public class DetalleEntidadManager
    {
        public int AddDetalleEntidad(User user)
        {
            return SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertDetalleEntidad", SqlDataAccessArgs
                .CreateWith("@Telefono", user.DetalleEntidad.Telefono)
                .And("@Email", user.DetalleEntidad.Email)
                .And("@ID_Usuario", user.UserID)
                .And("@Direccion", user.DetalleEntidad.Direccion)
                .And("@ID_Ciudad", user.DetalleEntidad.Ciudad.ID)
            .Arguments);
        }
    }
}
