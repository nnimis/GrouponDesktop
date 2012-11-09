using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.Login
{
    public class UserSelectedEventArgs : EventArgs
    {
        public User User { get; set; }
    }
}
