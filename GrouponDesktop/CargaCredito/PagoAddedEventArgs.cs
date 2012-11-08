using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.CargaCredito
{
    public class PagoAddedEventArgs : EventArgs
    {
        public Pago Pago { get; set; }
    }
}
