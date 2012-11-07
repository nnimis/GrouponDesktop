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
            if (result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    clientes.Add(new Cliente()
                    {
                        Apellido = row["Apellido"].ToString(),
                        Nombre = row["Nombre"].ToString(),
                        UserID = int.Parse(row["ID"].ToString()),
                        DNI = long.Parse(row["DNI"].ToString()),
                        DetalleEntidad = new DetalleEntidad()
                        {
                            Email = row["Email"].ToString(),
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
            cliente.UserID = usersManager.CreateProfileAccount(cliente as User, Cliente.Profile, password);
            var entityDetailManager = new DetalleEntidadManager();
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

        public void Delete(Cliente cliente)
        {
            _usersManager.DeleteAccount(cliente as User);
        }
    }
}
