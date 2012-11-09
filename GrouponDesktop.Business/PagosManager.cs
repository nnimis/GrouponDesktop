using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data;
using GrouponDesktop.Common;
using System.ComponentModel;
using System.Configuration;
using System.Data;

namespace GrouponDesktop.Business
{
    public class PagosManager
    {
        public BindingList<Pago> GetAll(User user)
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetPagosCliente", SqlDataAccessArgs
                .CreateWith("@ID_Cliente", user.UserID).Arguments);
            var pagos = new BindingList<Pago>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    pagos.Add(new Pago()
                    {
                        Credito = double.Parse(row["Credito"].ToString()),
                        Fecha = Convert.ToDateTime(row["Fecha"]), 
                        ID = int.Parse(row["ID"].ToString()),
                        TipoPago = (TipoPago)int.Parse(row["ID_TipoPago"].ToString()),
                        Banco = row["Banco"].ToString(),
                        Tarjeta = row["Numero"].ToString(),
                    });
                }
            }

            return pagos;
        }

        public List<TipoPago> GetTipoPagos()
        {
            return Enum.GetValues(typeof(TipoPago)).Cast<TipoPago>().ToList();
        }

        public void Add(Pago pago, User user)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertPago", SqlDataAccessArgs
                .CreateWith("@ID_Cliente", user.UserID)
                .And("@Credito", pago.Credito)
                .And("@Fecha", pago.Fecha)
                .And("@ID_TipoPago", (int)pago.TipoPago)
                .And("@Tarjeta", pago.Tarjeta)
                .And("@Banco", pago.Banco)
            .Arguments);
        }
    }
}
