using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.Login
{
    public class UserSavedEventArgs : EventArgs
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public User User { get; set; }
    }
}
