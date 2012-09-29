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
        /// <param name="cliente">Instancia de la clase <seealso cref="GrouponDesktop.Common.Cliente">Cliente</seealso> a guardar en la DB</param>
        /// <exception cref="GrouponDesktop.Common.Exceptions.ClienteDuplicadoException">En caso de cliente duplicado, tira una ClienteDuplicadoException</exception>
        public void GuardarCliente(Cliente cliente)
        {
            try
            {
                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GuardarCliente", SqlDataAccessArgs
                    .CreateWith("@Nombre", cliente.Nombre)
                    .And("@Apellido", cliente.Apellido)
                    .And("@DNI", cliente.DNI)
                .Arguments);
            }
            catch (SqlException exc)
            {
                throw new ClienteDuplicadoException();
            }
            catch (Exception exc)
            {

            }
        }
    }
}
