using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace PhilGepsDataProxy
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IProxyService
    {
        
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "data/{resourceId}/{limit}")]
        string GetData(string resourceId, string limit);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "sql/{sql}")]
        string GetDataSql(string sql);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "record/{resourceId}/{limit}")]
        string GetDataRecordsOnly(string resourceId, string limit);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "sqlrecord/{sql}")]
        string GetDataSqlRecordsOnly(string sql);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "lookup/{table}")]
        string GetLookupTable(string table);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "list/{table}/{limit}")]
        string List(string table, string limit);


        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "list_by_org_id/{table}/{orgid}/{limit}")]
        string ListByOrgID(string table, string orgid, string limit);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "list_by_org_id_category/{table}/{orgid}/{cat}/{limit}")]
        string ListByOrgIDCategory(string table, string orgid,string cat, string limit);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json, UriTemplate = "list_by_category/{table}/{cat}/{limit}")]
        string ListByCategory(string table, string cat, string limit);
    }
}
