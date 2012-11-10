using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.ArmarCupon
{
    public class CuponSavedEventArgs : EventArgs
    {
        public Cupon Cupon { get; set; }
    }
}
