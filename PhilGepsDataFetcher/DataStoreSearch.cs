using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RestSharp;
using System.Web.Script.Serialization;

namespace PhilGepsDataFetcher
{
    public class DataStoreSearch
    {
        private const string URLBase = "http://philgeps.cloudapp.net:5000/api/action";
        private const string dataStoreSearchParam = "datastore_search?resource_id={0}&limit={1}";
        private const string dataStoreSQLSearchParam = "datastore_search_sql?sql={0}";
        public DataFetchResult GetData(string resourceId, int limit)
        {
            limit = limit <= 0 ? 5 : limit; //set limit to 5 if its less than or =  to 0
            // Add your operation implementation here
            var client = new RestClient(URLBase);
            var request = new RestRequest(string.Format(dataStoreSearchParam, resourceId, limit), Method.GET);
            return ParseResult( client.DownloadData(request));      
        }
        public DataFetchResult GetData(string resourceId, string filter, int limit)
        {
            limit = limit <= 0 ? 5 : limit; //set limit to 5 if its less than or =  to 0
            // Add your operation implementation here
            var client = new RestClient(URLBase);
            var query = string.Format(dataStoreSearchParam, resourceId, limit);
            if (!string.IsNullOrWhiteSpace(filter))
            {
                query += "&q=" + filter;
            }
            var request = new RestRequest(query, Method.GET);
            return ParseResult(client.DownloadData(request));
           
        }
        public DataFetchResult GetDataSql(string sql)
        {
            // Add your operation implementation here
            var client = new RestClient(URLBase);
            var request = new RestRequest(string.Format(dataStoreSQLSearchParam, sql), Method.GET);
            return ParseResult(client.DownloadData(request));
        }

        private static DataFetchResult ParseResult(byte[] data)
        {
            if (data == null)
                return new DataFetchResult
                {
                    help = string.Empty,
                    success = false,
                    result = null
                };

            var serializer = new JavaScriptSerializer();
            serializer.RegisterConverters(new[] { new DynamicJsonSeserializer() });
            var jsondata = UTF8Encoding.UTF8.GetString(data);
            var obj = serializer.Deserialize(jsondata, typeof(IDictionary<string, object>)) as IDictionary<string, object>;
            return new DataFetchResult
            {
                help = obj["help"].ToString(),
                success = bool.Parse(obj["success"].ToString()),
                result = obj["result"]
            }; 
        }
    }
}
