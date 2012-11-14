using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;
using Data;
using System.Configuration;
using System.Security.Cryptography;
using System.Data.SqlClient;

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

        public int CreateAccount(User user, string password)
        {
            var service = new LoginService();
            var encryptedPass = service.ComputeHash(password, new SHA256CryptoServiceProvider());
            var result = SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertUser", SqlDataAccessArgs
                .CreateWith("@UserName", user.UserName)
                .And("@Password", encryptedPass)
                .And("@ID_Rol", user.RoleID)
            .Arguments);

            return result;
        }

        public int CreateProfileAccount(User user, Profile profile, string password)
        {
            var transaction = SessionData.Contains("Transaction") ? SessionData.Get<SqlTransaction>("Transaction") : null;
            var service = new LoginService();
            var encryptedPass = service.ComputeHash(password, new SHA256CryptoServiceProvider());
            int result = 0;
            if (transaction != null)
            {
                result = SqlDataAccess.ExecuteScalarQuery<int>(
                    "GRUPO_N.InsertProfileUser", SqlDataAccessArgs
                    .CreateWith("@UserName", user.UserName)
                    .And("@Password", encryptedPass)
                    .And("@ProfileName", profile.ToString())
                .Arguments, transaction);
            }
            else
            {
                result = SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.InsertProfileUser", SqlDataAccessArgs
                    .CreateWith("@UserName", user.UserName)
                    .And("@Password", encryptedPass)
                    .And("@ProfileName", profile.ToString())
                .Arguments);
            }

            return result;
        }
    }
}
