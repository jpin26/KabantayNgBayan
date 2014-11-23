using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace NotficationService
{
    public partial class NotificationService : ServiceBase
    {
        BidMonitor monitor;
        public NotificationService()
        {
            InitializeComponent();
            monitor = new BidMonitor();
        }

        protected override void OnStart(string[] args)
        {
            base.OnStart(args);
            monitor.StartMonitoring();
        }

        protected override void OnStop()
        {
            monitor.StopMonitoring();
            base.OnStop();
        }
    }
}
