using System;
using Nancy;
using nancysake.Services;

namespace nancysake.Modules.NumberModule
{
    public class NumberModule : NancyModule
    {

        //returning a int seems to be conisdered a status code, would need to return a json object
        public NumberModule()
        {
            Get["/number"] = _ => { return Response.AsJson(10); };

            Get["/version"] = parameters => {
                var buildVersionService = new BuildVersionService();
                var buildVersion = buildVersionService.GetBuildVersionNumber();
                return new
                {
                    buildversion = buildVersion
                };
            };

            Get["/"] = _ => "Running Nancy";

            Post["/number/{id}"] = parameters =>
            {
                int id = int.Parse(parameters.id);

                return Response.AsJson(id);
            };
  

        }

    }
}
