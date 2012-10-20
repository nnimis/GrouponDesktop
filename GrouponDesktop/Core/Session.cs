﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

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
            ViewsManager.LoadMenu();
        }
    }
}
