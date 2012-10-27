using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.AbmRol
{
    public class RoleUpdatedEventArgs : EventArgs
    {
        public Rol Rol { get; set; }
    }
}
