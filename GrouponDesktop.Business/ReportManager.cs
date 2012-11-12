using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Data;
using GrouponDesktop.Common;
using Data;
using System.Configuration;

namespace GrouponDesktop.Business
{
    public class ReportManager
    {
        public DataTable GetReport(ReportType reportType, DateTime fechaInicio, DateTime fechaFin)
        {
            return SqlDataAccess.ExecuteDataTableQuery
            (
                ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                reportType.StoredProcedure, SqlDataAccessArgs
                .CreateWith("@fecha_inicio", fechaInicio)
                .And("@fecha_fin", fechaFin)
                .Arguments
            );
        }

        public BindingList<ReportType> GetReportTypes()
        {
            return new BindingList<ReportType>()
            {
                { new ReportType("GRUPO_N.Get_TOPDevoluciones", "Top 5 porcentaje de devolución de los cupones, por proveedor por semestre")},
                { new ReportType("GRUPO_N.Get_TOPGiftCard", "Top 5 por usuario a los cuales se le acreditó GiftCards por semestre")}
            };
        }
    }
}
