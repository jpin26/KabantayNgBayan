using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using ZAP_SMSLibrary;

namespace TempService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {
        public string RegisterMerchant(string merchantReferenceNumber, string merchantMobile)
        {
            string activationCode = GenerateActivationCode();

            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("organizationId", merchantReferenceNumber),
                new SqlParameter("mobile", merchantMobile),
                new SqlParameter("activationCode", activationCode)
            };

            SqlHelper.ExecuteQuery("spRegisteredMerchants_Register", parameters);

            var mobileList = new List<string>();
            mobileList.Add(merchantMobile);
            SMSHelper.SendSMS(mobileList, string.Format("Please use the activation code to complete your registration : {0}", activationCode)); ;

            return string.Empty;
        }

        public string ConfirmRegistration(string merchantReferenceNumber, string merchantMobile, string confirmationCode)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("organizationId", merchantReferenceNumber),
                new SqlParameter("mobile", merchantMobile),
                new SqlParameter("activationCode", confirmationCode)
            };

            SqlHelper.ExecuteQuery("spRegisteredMerchants_Activate", parameters);

            return string.Empty;
        }

        private string GenerateActivationCode()
        {
            var rnd = new Random();
            return rnd.Next(10000, 99999).ToString();
        }


        public string GetMerchantIds()
        {

           var list= SqlHelper.ExecuteQueryResult("spGetRegisteredMerchants", null);
           var temp = list.Select(x => x.ToString());
           return string.Join(",", temp.ToArray());
        }

        public string SendSMSNotification(string merchantReferenceNumber, string type, string title)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("organizationId", merchantReferenceNumber)
            };

            SqlHelper.ExecuteQuery("spUpdateLastCheck", parameters);

            return string.Empty;
        }
    }
}
