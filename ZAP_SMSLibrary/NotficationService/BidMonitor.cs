using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using RestSharp;

namespace NotficationService
{
    internal class BidMonitor
    {
        private Timer timerMonitor;
        private readonly object tasklock =new object(); 
        internal BidMonitor()
        {
            timerMonitor = new Timer(new TimerCallback(RunScheduledTask));
            timerMonitor.Change(Timeout.Infinite, Timeout.Infinite);
           
        }
        internal void StartMonitoring()
        {
            if (timerMonitor != null)
            {
                timerMonitor.Change(0, 360000);
            }
        }

        internal void StopMonitoring(){
            lock (tasklock)
            {
                if (timerMonitor != null)
                {
                    timerMonitor.Change(Timeout.Infinite, Timeout.Infinite);
                    timerMonitor.Dispose();
                }
            }
        }
        private void RunScheduledTask(object o)
        {
            lock (tasklock)
            {

               var client = new RestClient("http://localhost:52416/Service1.svc/GetMerchantsIds");
                RestRequest req = new RestRequest();
                var data = client.DownloadData(req);
                if (data != null)
                {
                    var jsondata = UTF8Encoding.UTF8.GetString(data);
                   
                    //this should query philgeps data through philgepsdatafetcher but 
                    //the data was already old so no latest bid will get displayed
                    //and the selected category of merchants in the iphone app was not yet 
                    //connected to philgeps and our local database so :("


                }

            }
           
        }

    }
}
