using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Data;
using GrouponDesktop.Common;
using System.Data;

namespace GrouponDesktop.Business
{
    public class CiudadesManager
    {
        public List<City> GetAll()
        {
            var ret = new List<City>();
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetCiudades");

            if (result != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    ret.Add(new City() { ID = int.Parse(row["ID"].ToString()), Name = row["Descripcion"].ToString() });
                }
            }

            return ret;
        }
    }
}
