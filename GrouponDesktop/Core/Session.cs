using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using GrouponDesktop.Business;

namespace GrouponDesktop.Core
{
    /// <summary>
    /// Mantiene los datos de la sesion actual
    /// </summary>
    class Session
    {
        /// <summary>
        /// Obtiene la instancia del usuario logueado actualmente en el sistema
        /// </summary>
        public static User User { get; private set; }

        /// <summary>
        /// Inicia una sesion para un usuario en particular
        /// </summary>
        /// <param name="user">Usuario que se esta logueando</param>
        public static void StartSession(User user)
        {
            User = user;
            if(user.Permissions.Contains(Functionalities.AdministrarRoles))
            {
                var manager = new RolesManager();
                DefaultRoleID = manager.GetDefaultRoleID();
            }
            ViewsManager.LoadMenu();
        }

        /// <summary>
        /// Cierra la sesion actual
        /// </summary>
        public static void Close()
        {
            User = null;
            ViewsManager.Reset();
        }

        public static int DefaultRoleID { get; private set; }
    }
}
