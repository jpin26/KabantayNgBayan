using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
namespace NotficationService
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {
#if CONSOLE
            BidMonitor monitor = new BidMonitor();
            monitor.StartMonitoring();
            while (Console.ReadLine() != "exit")
            {
                Thread.Sleep(1000);
            }
            monitor.StopMonitoring();

#else
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] 
            { 
                new NotificationService() 
            };
            ServiceBase.Run(ServicesToRun);
#endif
        }
    }
}
