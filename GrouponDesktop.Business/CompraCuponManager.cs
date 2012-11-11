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
    public class CompraCuponManager
    {
        public BindingList<CompraCupon> GetAll(Cliente cliente, DateTime fechaDesde, DateTime fechaHasta)
        {
            var desde = new DateTime(fechaDesde.Year, fechaDesde.Month, fechaDesde.Day, 0, 0, 0);
            var hasta = new DateTime(fechaHasta.Year, fechaHasta.Month, fechaHasta.Day, 23, 59, 59);
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetComprasCliente", SqlDataAccessArgs
                .CreateWith("@ID_Cliente", cliente.UserID)
                .And("@FechaDesde", desde)
                .And("@FechaHasta", hasta)
                .Arguments);
            var data = new BindingList<CompraCupon>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new CompraCupon()
                    {
                        ID = int.Parse(row["ID"].ToString()),
                        Precio = double.Parse(row["Precio"].ToString()),
                        Fecha = Convert.ToDateTime(row["Fecha"]),
                        FechaVencimiento = Convert.ToDateTime(row["FechaVencimiento"]),
                        Descripcion = row["Descripcion"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Estado = GetEstado(row["ID_Devolucion"], row["ID_Canje"])
                    });
                }
            }

            return data;
        }

        public BindingList<CompraCupon> GetParaFacturar(Proveedor proveedor, DateTime fechaDesde, DateTime fechaHasta)
        {
            var desde = new DateTime(fechaDesde.Year, fechaDesde.Month, fechaDesde.Day, 0, 0, 0);
            var hasta = new DateTime(fechaHasta.Year, fechaHasta.Month, fechaHasta.Day, 23, 59, 59);
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetComprasParaFacturar", SqlDataAccessArgs
                .CreateWith("@ID_Proveedor", proveedor.UserID)
                .And("@FechaDesde", desde)
                .And("@FechaHasta", hasta)
                .Arguments);
            var data = new BindingList<CompraCupon>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new CompraCupon()
                    {
                        ID = int.Parse(row["ID_Canje"].ToString()),
                        Precio = double.Parse(row["Precio"].ToString()),
                        Fecha = Convert.ToDateTime(row["Fecha"]),
                        Descripcion = row["Descripcion"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                    });
                }
            }

            return data;
        }

        public BindingList<CompraCupon> GetAll(Proveedor proveedor)
        {
            var fechaVencimiento = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 23, 59, 59);
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetComprasProveedor", SqlDataAccessArgs
                .CreateWith("@ID_Proveedor", proveedor.UserID)
                .And("@FechaVencimiento", fechaVencimiento)
                .Arguments);
            var data = new BindingList<CompraCupon>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new CompraCupon()
                    {
                        ID = int.Parse(row["ID"].ToString()),
                        Precio = double.Parse(row["Precio"].ToString()),
                        Fecha = Convert.ToDateTime(row["Fecha"]),
                        Descripcion = row["Descripcion"].ToString(),
                        Codigo = row["Codigo"].ToString(),
                        Cliente = row["Cliente"].ToString(),
                    });
                }
            }

            return data;
        }

        private string GetEstado(object idDevolucion, object idCanje)
        {
            if (idDevolucion != null && !(idDevolucion is DBNull))
                return "Devuelto";
            if (idCanje != null && !(idCanje is DBNull))
                return "Consumido";
            return "Comprado";
        }

        public void DevolverCompra(Cliente cliente, CompraCupon compraCupon, string motivo)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertDevolucionCompra", SqlDataAccessArgs
                .CreateWith("@ID_Cliente", cliente.UserID)
                .And("@ID_CompraCupon", compraCupon.ID)
                .And("@Fecha", DateTime.Now)
                .And("@Motivo", motivo)
                .Arguments);
        }

        public void ConsumirCompra(CompraCupon compraCupon)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertCanjeCupon", SqlDataAccessArgs
                .CreateWith("@ID_CompraCupon", compraCupon.ID)
                .And("@Fecha", DateTime.Now)
                .Arguments);
        }
    }
}
