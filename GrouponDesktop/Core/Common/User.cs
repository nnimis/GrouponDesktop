using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Core
{
    /// <summary>
    /// Representa a un usuario logueado en el sistema
    /// </summary>
    class User
    {
        /// <summary>
        /// Permisos con los que cuenta el usuario
        /// </summary>
        public List<Functionalities> Permissions { get; private set; }

        public User()
        {
            Permissions = new List<Functionalities>();
        }
    }
}
