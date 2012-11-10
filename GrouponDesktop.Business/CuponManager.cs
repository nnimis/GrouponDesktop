using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using GrouponDesktop.Common;
using Data;
using System.Configuration;
using System.Data;

namespace GrouponDesktop.Business
{
    public class CuponManager
    {
        public BindingList<Cupon> GetAll(Proveedor proveedor)
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCuponesProveedor", SqlDataAccessArgs
                .CreateWith("@ID_Proveedor", proveedor.UserID).Arguments);
            var data = new BindingList<Cupon>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new Cupon()
                    {
                        ID = int.Parse(row["ID"].ToString()),
                        Precio = double.Parse(row["Precio"].ToString()),
                        PrecioOriginal = double.Parse(row["PrecioOriginal"].ToString()),
                        FechaPublicacion = Convert.ToDateTime(row["FechaPublicacion"]),
                        FechaVencimientoConsumo = Convert.ToDateTime(row["FechaVencimiento"]),
                        FechaVencimientoOferta = Convert.ToDateTime(row["FechaVigencia"]),
                        Cantidad = int.Parse(row["Stock"].ToString()),
                        CantidadPorUsuario = int.Parse(row["CantidadPorUsuario"].ToString()),
                        Descripcion = row["Descripcion"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Proveedor = proveedor,
                        Ciudades = GetCiudades(int.Parse(row["ID"].ToString())),
                        Publicado = Convert.ToBoolean(row["Publicado"])
                    });
                }
            }

            return data;
        }

        public BindingList<Cupon> GetAll(Cliente cliente)
        {
            var date = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCuponesCliente", SqlDataAccessArgs
                .CreateWith("@ID_Cliente", cliente.UserID)
                .And("@Fecha_Publicacion", new DateTime(date.Year, date.Month, date.Day, 23, 59, 59))
                .Arguments);
            var data = new BindingList<Cupon>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    if (int.Parse(row["Stock"].ToString()) == 0) continue;
                    data.Add(new Cupon()
                    {
                        ID = int.Parse(row["ID"].ToString()),
                        Precio = double.Parse(row["Precio"].ToString()),
                        PrecioOriginal = double.Parse(row["PrecioOriginal"].ToString()),
                        FechaPublicacion = Convert.ToDateTime(row["FechaPublicacion"]),
                        FechaVencimientoConsumo = Convert.ToDateTime(row["FechaVencimiento"]),
                        FechaVencimientoOferta = Convert.ToDateTime(row["FechaVigencia"]),
                        Cantidad = int.Parse(row["Stock"].ToString()),
                        CantidadPorUsuario = int.Parse(row["CantidadPorUsuario"].ToString()),
                        Descripcion = row["Descripcion"].ToString(),
                        Codigo = row["Codigo"].ToString()
                    });
                }
            }

            return data;
        }

        public BindingList<Cupon> GetAllToPublish()
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCuponesParaPublicar", SqlDataAccessArgs
                .CreateWith("@Fecha_Publicacion", Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]))
                .Arguments);
            var data = new BindingList<Cupon>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new Cupon()
                    {
                        ID = int.Parse(row["ID"].ToString()),
                        FechaVencimientoOferta = Convert.ToDateTime(row["FechaVigencia"]),
                        Descripcion = row["Descripcion"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Proveedor = new Proveedor()
                        {
                            UserID = int.Parse(row["ID_Proveedor"].ToString()),
                            RazonSocial = row["RazonSocial"].ToString()
                        },
                    });
                }
            }

            return data;
        }

        public int Add(Cupon cupon)
        {
            var id = SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertCupon", SqlDataAccessArgs
                .CreateWith("@Precio", cupon.Precio)
                .And("@PrecioOriginal", cupon.PrecioOriginal)
                .And("@FechaPublicacion", cupon.FechaPublicacion)
                .And("@FechaVigencia", cupon.FechaVencimientoOferta)
                .And("@FechaVencimiento", cupon.FechaVencimientoConsumo)
                .And("@Stock", cupon.Cantidad)
                .And("@Descripcion", cupon.Descripcion)
                .And("@ID_Proveedor", cupon.Proveedor.UserID)
                .And("@CantidadPorUsuario", cupon.CantidadPorUsuario)
                .And("@Publicado", 0)
                .And("@Codigo", cupon.Codigo)
            .Arguments);

            foreach (var city in cupon.Ciudades)
            {
                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                    "GRUPO_N.InsertCuponCiudad", SqlDataAccessArgs
                    .CreateWith("@ID_Cupon", id)
                    .And("@ID_Ciudad", city.ID)
                    .Arguments);
            }

            return id;
        }

        public void Publish(Cupon cupon)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.PublicarCupon", SqlDataAccessArgs
                .CreateWith("@ID", cupon.ID)
                .Arguments);
        }

        public static string GetCodigo()
        {
            string codigo = string.Empty;
            bool exists;
            do
            {
                const int codeLength = 10;
                const string allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                char[] chars = new char[codeLength];
                var rd = new Random();

                for (int i = 0; i < codeLength; i++)
                {
                    chars[i] = allowedChars[rd.Next(0, allowedChars.Length)];
                }

                codigo = new string(chars);
                exists = CodigoExists(codigo);
            }
            while (exists);
            return codigo;
        }

        public int ComprarCupon(Cupon cupon, Cliente cliente)
        {
            var id = SqlDataAccess.ExecuteScalarQuery<object>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.ComprarCuponCliente", SqlDataAccessArgs
                .CreateWith("@ID_Cupon", cupon.ID)
                .And("@ID_Cliente", cliente.UserID)
                .And("@Fecha", DateTime.Now)
                .Arguments);

            if (id == null)
                throw new Exception("Ha superado la cantidad de cupones permitidos por persona");

            return int.Parse(id.ToString());
        }

        #region  Private Methods

        private static bool CodigoExists(string codigo)
        {
            var result = SqlDataAccess.ExecuteScalarQuery<object>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCodigoCuponExists", SqlDataAccessArgs
                    .CreateWith("@Codigo", codigo).Arguments);
            return result != null;
        }

        private List<City> GetCiudades(int id)
        {
            var ret = new List<City>();
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCiudadesCupon", SqlDataAccessArgs
                    .CreateWith("@ID_Cupon", id).Arguments);
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    ret.Add(new City()
                    {
                        ID = int.Parse(row["ID"].ToString()),
                        Name = row["Descripcion"].ToString()
                    });
                }
            }

            return ret;
        }

        #endregion
    }
}
