using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class DetalleEntidad
    {
        public string Email { get; set; }
        public string Direccion { get; set; }
        public long Telefono { get; set; }
        public string CP { get; set; }
        public City Ciudad { get; set; }
    }
}
