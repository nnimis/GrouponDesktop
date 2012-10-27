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
            var encryptedPassword = ComputeHash(password, new SHA256CryptoServiceProvider());
            DataRow result = SqlDataAccess.ExecuteDataRowQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
            "GRUPO_N.Login", SqlDataAccessArgs
                .CreateWith("@Nombre", userName)
                .And("@Password", encryptedPassword)
            .Arguments);

            if (result == null)
                throw new Exception("Usuario no encontrado");

            var user = new User()
            {
                UserID = int.Parse(result["ID"].ToString()),
                RoleID = int.Parse(result["ID_Rol"].ToString()),
                UserName = result["Nombre"].ToString()
            };

            SetUserFunctionalities(user);

            return user;
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

        public string ComputeHash(string input, HashAlgorithm algorithm)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            Byte[] hashedBytes = algorithm.ComputeHash(inputBytes);
            return BitConverter.ToString(hashedBytes);
        }
    }
}
