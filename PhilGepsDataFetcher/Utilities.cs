using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;


namespace PhilGepsDataFetcher
{
    public sealed class Utilities
    {
        public static string ToRecordsJSONString(dynamic obj)
        {
            var sb = new StringBuilder();

            var records = obj["records"];
            var links = obj["_links"];
            var limit = obj["limit"];
            var total = obj["total"];
            sb.Append("{\"records\":[");
            if(records is List<object>)
            {
                var recs = records as List<object>;
                sb.Append(string.Join(",",recs.ToArray().Select(x => x.ToString()).ToArray<string>()));               
            }
            sb.Append("],");
            sb.Append("\"links\":");
            sb.Append(links==null?"null":links.ToString());
            sb.Append(",\"limit\":");
            sb.Append(limit==null?"null":limit.ToString());
            sb.Append(",\"total\":");
            sb.Append(total==null?"null":total.ToString());
            sb.Append("}");

            return sb.ToString();
        }

        public static string ToRecordsOnlyJSONString(dynamic obj)
        {
            var sb = new StringBuilder();

            var records = obj["records"];
            sb.Append("{[");
            if (records is List<object>)
            {
                var recs = records as List<object>;
                sb.Append(string.Join(",", recs.ToArray().Select(x => x.ToString()).ToArray<string>()));
            }
            sb.Append("]");           
            sb.Append("}");

            return sb.ToString();
        }
        public static string FormatSQL(string sql)
        {
            var result = sql.Replace("'", "%27").Replace(" ", "%20");
            return result;
        }

        public static string ToJSONString(dynamic obj)
        {
            var sb = new StringBuilder();

            var records = obj["records"];
            var links = obj["_links"];
            var limit = obj["limit"];
            var total = obj["total"];
            sb.Append("{records:[");
            if (records is List<object>)
            {
                var recs = records as List<object>;
                sb.Append(string.Join(",", recs.ToArray().Select(x => x.ToString()).ToArray<string>()));
            }
            sb.Append("],");
            sb.Append("links:");
            sb.Append(links == null ? "null" : links.ToString());
            sb.Append(",limit:");
            sb.Append(limit == null ? "null" : limit.ToString());
            sb.Append(",total:");
            sb.Append(total == null ? "null" : total.ToString());
            sb.Append("}");

            return sb.ToString();
        }
    }
}
