using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Configuration;
using RestSharp;
using RestSharp.Serializers;
using PhilGepsDataFetcher;

namespace PhilGepsDataProxy
{
    /// <summary>
    /// 
    /// </summary>
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class ProxyService : IProxyService
    {
        public string GetData(string resourceId, string limit)
        {
            Guid tmp;
            if(!Guid.TryParse(resourceId, out tmp)){
                var tmpId = ConfigurationManager.AppSettings[resourceId];
                if (string.IsNullOrWhiteSpace(tmpId) || !Guid.TryParse(tmpId, out tmp))
                {
                    return string.Empty;
                }
                else
                {
                    return GetDataSql(resourceId);
                }
            }
            var fetcher = new DataStoreSearch();
            var result = fetcher.GetData(resourceId, int.Parse(limit));

            return Utilities.ToRecordsJSONString(result.result);
        }

        public string GetDataSql(string sql)
        {
            var fetcher = new DataStoreSearch();
            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsJSONString(result.result);
        }

        public string GetDataRecordsOnly(string resourceId, string limit)
        {
            var fetcher = new DataStoreSearch();
            var result = fetcher.GetData(resourceId, int.Parse(limit));

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }

        public string GetDataSqlRecordsOnly(string sql)
        {
            var fetcher = new DataStoreSearch();
            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }
        // Add more operations here and mark them with [OperationContract]


        public string GetLookupTable(string table)
        {
            var sql = ConfigurationManager.AppSettings[table];
            if (string.IsNullOrWhiteSpace(sql))
                return string.Empty;
            var fetcher = new DataStoreSearch();

            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }

        public string List(string table,string limit)
        {
            var sql = ConfigurationManager.AppSettings[table];
            if (string.IsNullOrWhiteSpace(sql))
                return string.Empty;
            var fetcher = new DataStoreSearch();
             
            sql = Utilities.FormatSQL(string.Format(sql,limit));
            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }



        public string ListByOrgID(string table, string orgid, string limit)
        {
            var sql = ConfigurationManager.AppSettings[table];
            if (string.IsNullOrWhiteSpace(sql))
                return string.Empty; 
            var fetcher = new DataStoreSearch();

            sql = Utilities.FormatSQL(string.Format(sql,orgid,limit));
            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }

        public string ListByOrgIDCategory(string table, string orgid, string cat, string limit)
        {
            var sql = ConfigurationManager.AppSettings[table];
            if (string.IsNullOrWhiteSpace(sql))
                return string.Empty;
            var fetcher = new DataStoreSearch();
            var cats = cat.Split(new char[] { ',' });
            var catString = "array['" + string.Join("','", cats) + "']";

            sql = Utilities.FormatSQL(string.Format(sql, orgid, catString, limit));
            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }



        public string ListByCategory(string table, string cat, string limit)
        {
            var sql = ConfigurationManager.AppSettings[table];
            if (string.IsNullOrWhiteSpace(sql))
                return string.Empty;
            var fetcher = new DataStoreSearch();
            var cats = cat.Split(new char[] { ',' });
            var catString = "array['" + string.Join("','", cats) + "']";

            sql = Utilities.FormatSQL(string.Format(sql, catString, limit));
            var result = fetcher.GetDataSql(sql);

            return Utilities.ToRecordsOnlyJSONString(result.result);
        }
    }
}
