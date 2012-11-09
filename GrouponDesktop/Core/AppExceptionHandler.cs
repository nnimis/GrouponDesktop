using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Data.SqlClient;

namespace GrouponDesktop.Core
{
    /// <summary>
    /// Maneja las excepciones no controladas de la aplicacion
    /// </summary>
    class AppExceptionHandler
    {
        /// <summary>
        /// Metodo invocado al detectarse una excepcion no controlada en la aplicacion
        /// </summary>
        /// <param name="sender">Objeto que dispara la excepcion</param>
        /// <param name="e">Argumentos de la excepcion</param>
        public static void Invoke(object sender, ThreadExceptionEventArgs e)
        {
            if (e.Exception is SqlException)
            {
                SqlExceptionHandler.Handle(e.Exception as SqlException);
            }
            else
            {
                ViewsManager.Alert(e.Exception.Message);
            }
        }
    }
}
