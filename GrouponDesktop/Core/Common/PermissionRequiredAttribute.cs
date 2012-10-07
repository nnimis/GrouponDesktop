using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Core
{
    /// <summary>
    /// Representa los atributos aplicables a los formularios para determinar los permisos
    /// necesarios para poder navegar sobre cada uno. En base a estos permisos es que
    /// se muestran o no los formularios en el menu
    /// </summary>
    class PermissionRequiredAttribute : Attribute
    {
        /// <summary>
        /// Permisos requeridos para poder navegar el formulario
        /// </summary>
        public Functionalities[] Permissions { get; set; }

        /// <summary>
        /// Crea una nueva instancia del atributo
        /// </summary>
        /// <param name="permissions">Permisos requeridos para poder navegar el formulario</param>
        public PermissionRequiredAttribute(params Functionalities[] permissions)
        {
            Permissions = permissions;
        }
    }
}
