using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace nancysake.Repository
{
    public class NancyRepo: IDisposable
    {
        public void Dispose()
        {
           
        }

        public string GetCurrentBuildVersion()
        {
            return "1.1";
        }
    }
}