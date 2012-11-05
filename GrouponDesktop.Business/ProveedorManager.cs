using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using System.Data;
using System.Data.SqlClient;
using Data;
using System.Configuration;
using GrouponDesktop.Common.Exceptions;

namespace GrouponDesktop.Business
{
    /// <summary>
    /// Gestiona las instancias de la clase Cliente en el sistema
    /// </summary>
    public class ProveedorManager
    {
        public List<Proveedor> ObtenerProveedores()
        {
            throw new NotImplementedException();
        }

        public void GuardarProveedor(Proveedor proveedor, string password)
        {
            var usersManager = new UsersManager();
            proveedor.UserID = usersManager.CreateProfileAccount(proveedor as User, Proveedor.Profile, password);
            var entityDetailManager = new DetalleEntidadManager();
            var detalleID = entityDetailManager.AddDetalleEntidad(proveedor as User);

            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertProveedor", SqlDataAccessArgs
                .CreateWith("@RazonSocial", proveedor.RazonSocial)
                .And("@ID_Rubro", proveedor.Rubro.ID)
                .And("@CUIT", proveedor.CUIT)
                .And("@ID_Detalle", detalleID)
            .Arguments);
        }
    }
}
