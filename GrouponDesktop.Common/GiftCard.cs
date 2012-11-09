using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class GiftCard
    {
        public Cliente ClienteOrigen { get; set; }
        public Cliente ClienteDestino { get; set; }
        public DateTime Fecha { get; set; }
        public double Credito { get; set; }
    }
}
