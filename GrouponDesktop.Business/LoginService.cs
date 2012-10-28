using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using GrouponDesktop.Common;
using System.Data;

namespace GrouponDesktop.Business
{
    public class LoginService
    {
        /// <summary>
        /// Valida contra la DB los datos del usuario
        /// </summary>
        /// <param name="user">User name</param>
        /// <param name="password">Password</param>
        /// <returns>ID del usuario en caso de login correcto, si no tira una Exception</returns>
        public User Login(string userName, string password)
        {
            this.ValidateLockedUser(userName);

            var encryptedPassword = ComputeHash(password, new SHA256CryptoServiceProvider());
            DataRow result = SqlDataAccess.ExecuteDataRowQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.Login", SqlDataAccessArgs
                .CreateWith("@Nombre", userName)
                .And("@Password", encryptedPassword)
            .Arguments);

            if (result == null)
                throw new Exception("Usuario o contraseña inválidos");

            var user = new User()
            {
                UserID = int.Parse(result["ID"].ToString()),
                RoleID = int.Parse(result["ID_Rol"].ToString()),
                UserName = result["Nombre"].ToString()
            };

            SetUserFunctionalities(user);

            return user;
        }

        public bool UpdateUserPassword(User user, string oldPassword, string newPassword)
        {
            var encryptedOldPassword = ComputeHash(oldPassword, new SHA256CryptoServiceProvider());
            var encryptedNewPassword = ComputeHash(newPassword, new SHA256CryptoServiceProvider());
            var result = SqlDataAccess.ExecuteScalarQuery<object>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.UpdateUserPassword", SqlDataAccessArgs
                .CreateWith("@ID_Usuario", user.UserID)
                .And("@OldPassword", encryptedOldPassword)
                .And("@NewPassword", encryptedNewPassword)
            .Arguments);

            return (result != null);
        }

        public string ComputeHash(string input, HashAlgorithm algorithm)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            Byte[] hashedBytes = algorithm.ComputeHash(inputBytes);
            return BitConverter.ToString(hashedBytes);
        }

        #region Private Methods

        private void ValidateLockedUser(string userName)
        {
            var result = SqlDataAccess.ExecuteScalarQuery<object>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetUserLoginAttempts", SqlDataAccessArgs
                .CreateWith("@Nombre", userName)
            .Arguments);

            if (result == null)
                throw new Exception("Usuario o contraseña inválidos");

            if (int.Parse(result.ToString()) == 3)
                throw new Exception("Usuario Bloqueado, contacte al administrador del sistema");
        }

        private void SetUserFunctionalities(User user)
        {
            var manager = new FunctionalitiesManager();
            var functionalities = manager.GetRoleFunctionalities(user.RoleID);

            foreach (var functionality in functionalities)
            {
                user.Permissions.Add(functionality);
            }
        }

        #endregion
    }
}
