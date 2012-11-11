using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.PedirDevolucion
{
    public class CuponDevueltoEventArgs : EventArgs
    {
        public string Mensaje { get; set; }
        public CompraCupon CompraCupon { get; set; }
    }
}
