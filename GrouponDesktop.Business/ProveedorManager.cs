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
using System.ComponentModel;

namespace GrouponDesktop.Business
{
    public class ProveedorManager
    {
        private UsersManager _usersManager = new UsersManager();

        public BindingList<Proveedor> GetAll()
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetProveedores");
            var data = new BindingList<Proveedor>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new Proveedor()
                    {
                        UserID = int.Parse(row["ID"].ToString()),
                        UserName = row["UserName"].ToString(),
                        RoleID = int.Parse(row["ID_Rol"].ToString()),
                        RazonSocial = row["RazonSocial"].ToString(),
                        CUIT = row["CUIT"].ToString(),
                        NombreContacto = row["Contacto"].ToString(),
                        Rubro = new Rubro()
                        {
                            ID = int.Parse(row["ID_Rubro"].ToString())
                        },
                        DetalleEntidad = new DetalleEntidad()
                        {
                            Email = row["Email"].ToString(),
                            Direccion = row["Direccion"].ToString(),
                            Telefono = long.Parse(row["Telefono"].ToString()),
                            CP = row["CP"].ToString(),
                            Ciudad = new City()
                            {
                                ID = int.Parse(row["ID_Ciudad"].ToString())
                            }
                        }
                    });
                }
            }
            return data;
        }

        public void GuardarProveedor(Proveedor proveedor, string password)
        {
            var usersManager = new UsersManager();
            var entityDetailManager = new DetalleEntidadManager();
            if (proveedor.UserID == 0)
            {
                proveedor.UserID = usersManager.CreateProfileAccount(proveedor as User, Proveedor.Profile, password);
                var detalleID = entityDetailManager.AddDetalleEntidad(proveedor as User);

                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.InsertProveedor", SqlDataAccessArgs
                    .CreateWith("@RazonSocial", proveedor.RazonSocial)
                    .And("@ID", proveedor.UserID)
                    .And("@ID_Rubro", proveedor.Rubro.ID)
                    .And("@CUIT", proveedor.CUIT)
                    .And("@Contacto", proveedor.NombreContacto)
                .Arguments);
            }
            else
            {
                entityDetailManager.UpdateDetalleEntidad(proveedor as User);
                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.UpdateProveedor", SqlDataAccessArgs
                    .CreateWith("@RazonSocial", proveedor.RazonSocial)
                    .And("@ID", proveedor.UserID)
                    .And("@ID_Rubro", proveedor.Rubro.ID)
                    .And("@CUIT", proveedor.CUIT)
                    .And("@Contacto", proveedor.NombreContacto)
                .Arguments);
            }
        }

        public void Delete(Proveedor proveedor)
        {
            _usersManager.DeleteAccount(proveedor as User);
        }
    }
}
