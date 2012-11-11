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
    public class FacturaManager
    {
        public int GenerarFactura(Proveedor proveedor, BindingList<CompraCupon> compras, DateTime fecha)
        {
            var result = SqlDataAccess.ExecuteDataRowQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertFactura", SqlDataAccessArgs
                .CreateWith("@Fecha", fecha)
                .And("@ID_Proveedor", proveedor.UserID)
                .Arguments);

            var nroFactura = int.Parse(result["NroFactura"].ToString());
            var idFactura = int.Parse(result["ID_Factura"].ToString());

            foreach (var compra in compras)
            {
                AddCompraFactura(compra, idFactura);
            }

            return nroFactura;
        }

        private void AddCompraFactura(CompraCupon compra, int idFactura)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.InsertFacturaCanjeCupon", SqlDataAccessArgs
                .CreateWith("@ID_Factura", idFactura)
                .And("@ID_CanjeCupon", compra.ID)
                .Arguments);
        }
    }
}
