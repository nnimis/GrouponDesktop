using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class Cliente : User
    {
        public static Profile Profile = Profile.Cliente;

        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public long DNI { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public List<City> Ciudades { get; set; }

        public Cliente()
        {
            Ciudades = new List<City>();
        }
    }
}
