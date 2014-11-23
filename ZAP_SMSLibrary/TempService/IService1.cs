using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.IO;
using System.Drawing;

namespace TempService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        [WebGet(UriTemplate = "RegisterMerchant/{merchantReferenceNumber}/{merchantMobile}", ResponseFormat = WebMessageFormat.Json)]
        string RegisterMerchant(string merchantReferenceNumber, string merchantMobile);

        [OperationContract]
        [WebGet(UriTemplate = "ConfirmRegistration/{merchantReferenceNumber}/{merchantMobile}/{confirmationCode}", ResponseFormat = WebMessageFormat.Json)]
        string ConfirmRegistration(string merchantReferenceNumber, string merchantMobile, string confirmationCode);

        [OperationContract]
        [WebGet(UriTemplate = "GetMerchantsIds/", ResponseFormat = WebMessageFormat.Json)]
        string GetMerchantIds();

        [OperationContract]
        [WebGet(UriTemplate = "SendSMSNotification/{merchantReferenceNumber}/{type}/{title}", ResponseFormat = WebMessageFormat.Json)]
        string SendSMSNotification(string merchantReferenceNumber, string type, string title);


    }
}
