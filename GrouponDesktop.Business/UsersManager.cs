using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using Data;
using System.Configuration;

namespace GrouponDesktop.Business
{
    public class UsersManager
    {
        public void DeleteAccount(User user)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.DeleteUser", SqlDataAccessArgs
                .CreateWith("@User_ID", user.UserID)
            .Arguments);
        }
    }
}
