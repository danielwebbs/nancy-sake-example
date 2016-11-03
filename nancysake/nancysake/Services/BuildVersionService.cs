using nancysake.Repository;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace nancysake.Services
{
    public class BuildVersionService
    {

        public BuildVersionService()
        {

        }

        public string GetBuildVersionNumber()
        {
            using (NancyRepo nancyRepo = new NancyRepo())
            {
                return nancyRepo.GetCurrentBuildVersion();
            }
        }
    }
}