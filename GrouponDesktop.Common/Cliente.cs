using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class Cliente
    {
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string DNI { get; set; }
        public string Direccion { get; set; }
        public string CP { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public List<City> Ciudades { get; set; }
    }
}
