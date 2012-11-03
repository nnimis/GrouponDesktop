using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.Business
{
    public class ProfileManager
    {
        public List<Profile> GetAllProfiles()
        {
            return Enum.GetValues(typeof(Profile)).Cast<Profile>().ToList();
        }

        public List<Profile> GetRegistrationProfiles()
        {
            var items = Enum.GetValues(typeof(Profile)).Cast<Profile>().ToList();
            items.Remove(Profile.Administrador);
            return items;
        }
    }
}
