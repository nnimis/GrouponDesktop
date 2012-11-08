using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    public class Pago
    {
        public int ID { get; set; }
        public double Credito { get; set; }
        public DateTime Fecha { get; set; }
        public TipoPago TipoPago { get; set; }
        public string Banco { get; set; }
        public string Tarjeta { get; set; }
    }
}
