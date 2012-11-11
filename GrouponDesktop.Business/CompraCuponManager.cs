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
                        Estado = GetEstado(row["ID_Devolucion"])
                    });
                }
            }

            return data;
        }

        private string GetEstado(object value)
        {
            if (value == null || value is DBNull)
                return "Comprado";
            return "Devuelto";
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
    }
}
