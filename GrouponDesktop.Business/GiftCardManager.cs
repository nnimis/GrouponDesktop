using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using GrouponDesktop.Common;
using System.Data;
using Data;
using System.Configuration;

namespace GrouponDesktop.Business
{
    public class GiftCardManager
    {
        public BindingList<GiftCard> GetAll(Cliente clienteOrigen)
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetGiftCardCliente", SqlDataAccessArgs
                .CreateWith("@ID_Cliente", clienteOrigen.UserID).Arguments);
            var data = new BindingList<GiftCard>();
            if (result != null && result.Rows != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    data.Add(new GiftCard()
                    {
                        Credito = double.Parse(row["Credito"].ToString()),
                        Fecha = Convert.ToDateTime(row["Fecha"]),
                        ClienteOrigen = new Cliente()
                        {
                            UserName = row["ClienteOrigen"].ToString()
                        },
                        ClienteDestino = new Cliente()
                        {
                            UserName = row["ClienteDestino"].ToString()
                        }
                    });
                }
            }

            return data;
        }

        public int Add(GiftCard giftCard)
        {
            var result = SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertGiftCard", SqlDataAccessArgs
                .CreateWith("@ID_ClienteOrigen", giftCard.ClienteOrigen.UserID)
                .And("@ID_ClienteDestino", giftCard.ClienteDestino.UserID)
                .And("@Credito", giftCard.Credito)
                .And("@Fecha", giftCard.Fecha)
                .Arguments);

            if (result == 0)
            {
                throw new Exception("No tiene saldo suficiente para la GiftCard");
            }
            return result;
        }

        public List<double> GetMontos()
        {
            return new List<double>() { 20, 50, 100 };
        }
    }
}
