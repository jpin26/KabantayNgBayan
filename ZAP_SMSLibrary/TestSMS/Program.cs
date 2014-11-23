using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestSMS
{
    class Program
    {
        static void Main(string[] args)
        {
            var mobileList = new List<string>();
            mobileList.Add("");
            ZAP_SMSLibrary.SMSHelper.SendSMS(mobileList, "");
        }
    }
}
