using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GlobeLabsApi;

namespace ZAP_SMSLibrary
{
    public static class SMSHelper
    {
        private static GlobeLabs _api;
        private static void InitializeToken()
        {
            // Fetch ApplicationId and ApplicationSecret in your config file
            string applicationId = "gzn9Ux5X4XH9dcM7y9TXAeH4EzEdUXbr";
            string applicationSecret = "82e34f183ed3bc931063d56b2c44502f5f32c8f0e1981bdb257115d001369980";

            _api = new GlobeLabs(applicationId, applicationSecret);

            string code = "xafzAXo7U5KAreHKgqbBCqk5XqH5oMMeSBpeAotoMGRbHr5KR7t6zRE9IGdRjrFMbEMrhX6XaAIzBdR8SK6akGFL7nzrIAgRgMIzoLkXFEGMBrfLkB7ofXKa8RfA7cxog6Ta6zfazBg6fxkMRjfqKLjoFboR74Izpnd4Iz8ar8FyndKySdyXM9I4KE5Eh58RqzFyXRaLIo4K69tnkGxbHzaeagtnXMpeSLy5AoHeEqr6CpLA45H9oXdgUzKXBqfq";

            // 1. Retrieve AccessToken based on Code.
            var result = _api.Authorize(code); // AuthResponse object
        }

        public static void SendSMS(List<string> recipients, string content)
        {
            InitializeToken();
            var payload = new SmsPayload
            {
                Message = content,
                Numbers = recipients
            };
            _api.PushSms("21588175", payload);
        }
    }
}
