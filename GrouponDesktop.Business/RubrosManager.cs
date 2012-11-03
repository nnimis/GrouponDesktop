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
    public class RubrosManager
    {
        public List<Rubro> GetAll()
        {
            var ret = new List<Rubro>();
            var result = SqlDataAccess.ExecuteDataTableQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "GRUPO_N.GetRubros");

            if (result != null)
            {
                foreach (DataRow row in result.Rows)
                {
                    ret.Add(new Rubro() { ID = int.Parse(row["ID"].ToString()), Name = row["Descripcion"].ToString() });
                }
            }

            return ret;
        }
    }
}
