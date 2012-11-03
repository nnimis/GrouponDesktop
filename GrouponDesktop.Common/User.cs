using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    /// <summary>
    /// Representa a un usuario logueado en el sistema
    /// </summary>
    public class User
    {
        /// <summary>
        /// Permisos con los que cuenta el usuario
        /// </summary>
        public List<Functionalities> Permissions { get; private set; }

        /// <summary>
        /// User ID
        /// </summary>
        public int UserID { get; set; }

        /// <summary>
        /// Role ID
        /// </summary>
        public int RoleID { get; set; }

        /// <summary>
        /// Nombre del usuario
        /// </summary>
        public string UserName { get; set; }

        public DetalleEntidad DetalleEntidad { get; set; }

        public User()
        {
            Permissions = new List<Functionalities>();
            DetalleEntidad = new DetalleEntidad();
        }
    }
}
