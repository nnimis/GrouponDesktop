using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class Rol
    {
        public int ID { get; set; }

        public string Nombre { get; set; }

        public List<Functionalities> Functionalities { get; set; }

        public Rol()
        {
            Functionalities = new List<Functionalities>();
        }

        public override bool Equals(object obj)
        {
            if (!(obj is Rol)) return false;
            return ((Rol)obj).ID == this.ID;
        }

        public override int GetHashCode()
        {
            return ID.GetHashCode();
        }
    }
}
