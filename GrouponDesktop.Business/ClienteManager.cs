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
    /// <summary>
    /// Gestiona las instancias de la clase Cliente en el sistema
    /// </summary>
    public class ClienteManager
    {
        private UsersManager _usersManager = new UsersManager();

        /// <summary>
        /// Obtiene el listado de clientes del sistema
        /// </summary>
        /// <returns>Listado de clientes</returns>
        public BindingList<Cliente> GetAll()
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetClientes");
            var clientes = new BindingList<Cliente>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    clientes.Add(new Cliente()
                    {
                        Apellido = row["Apellido"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        UserID = int.Parse(row["ID"].ToString()),
                        UserName = row["UserName"].ToString(),
                        RoleID = int.Parse(row["ID_Rol"].ToString()),
                        FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"]),
                        DNI = long.Parse(row["DNI"].ToString()),
                        Ciudades = GetCiudades(int.Parse(row["ID"].ToString())),
                        DetalleEntidad = new DetalleEntidad()
                        {
                            Email = row["Email"].ToString(),
                            Direccion = row["Direccion"].ToString(),
                            CP = row["CP"].ToString(),
                            Telefono = long.Parse(row["Telefono"].ToString()),
                            Ciudad = new City()
                            {
                                ID = int.Parse(row["ID_Ciudad"].ToString())
                            }
                        }
                    });
                }
            }

            return clientes;
        }

        /// <summary>
        /// Guarda un cliente en la base de datos
        /// </summary>
        public void GuardarCliente(Cliente cliente, string password)
        {
            var usersManager = new UsersManager();
            var entityDetailManager = new DetalleEntidadManager();
            if (cliente.UserID == 0)
            {
                cliente.UserID = usersManager.CreateProfileAccount(cliente as User, Cliente.Profile, password);
                var detalleID = entityDetailManager.AddDetalleEntidad(cliente as User);
                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.InsertCliente", SqlDataAccessArgs
                    .CreateWith("@DNI", cliente.DNI)
                    .And("@ID", cliente.UserID)
                    .And("@Nombre", cliente.Nombre)
                    .And("@Apellido", cliente.Apellido)
                    .And("@FechaNacimiento", cliente.FechaNacimiento)
                .Arguments);
            }
            else
            {
                entityDetailManager.UpdateDetalleEntidad(cliente as User);
                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.UpdateCliente", SqlDataAccessArgs
                    .CreateWith("@DNI", cliente.DNI)
                    .And("@ID", cliente.UserID)
                    .And("@Nombre", cliente.Nombre)
                    .And("@Apellido", cliente.Apellido)
                    .And("@FechaNacimiento", cliente.FechaNacimiento)
                .Arguments);
            }
            AddCiudades(cliente);
        }

        private void AddCiudades(Cliente cliente)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.DeleteCiudadesCliente", SqlDataAccessArgs
                    .CreateWith("@ID_Cliente", cliente.UserID).Arguments);

            foreach (var city in cliente.Ciudades)
            {
                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.InsertCiudadCliente", SqlDataAccessArgs
                    .CreateWith("@ID_Cliente", cliente.UserID)
                    .And("@ID_Ciudad", city.ID)
                .Arguments);
            }
        }

        private List<City> GetCiudades(int id)
        {
            var ret = new List<City>();
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCiudadesCliente", SqlDataAccessArgs
                    .CreateWith("@ID_Cliente", id).Arguments);
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    ret.Add(new City()
                    {
                        ID = int.Parse(row["ID_Ciudad"].ToString())
                    });
                }
            }

            return ret;
        }

        public void Delete(Cliente cliente)
        {
            _usersManager.DeleteAccount(cliente as User);
        }
    }
}
