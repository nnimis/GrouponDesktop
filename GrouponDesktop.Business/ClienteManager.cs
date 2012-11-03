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
    public class ClienteManager
    {
        /// <summary>
        /// Obtiene el listado de clientes del sistema
        /// </summary>
        /// <returns>Listado de clientes</returns>
        public List<Cliente> ObtenerClientes()
        {
            throw new NotImplementedException();
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
                .And("@Nombre", cliente.Nombre)
                .And("@Apellido", cliente.Apellido)
                .And("@FechaNacimiento", cliente.FechaNacimiento)
                .And("@ID_Detalle", detalleID)
            .Arguments);
        }
    }
}
