using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class Proveedor : User
    {
        public static Profile Profile = Profile.Proveedor;

        public string RazonSocial { get; set; }
        public string CUIT { get; set; }
        public string NombreContacto { get; set; }
        public Rubro Rubro { get; set; }
    }
}
