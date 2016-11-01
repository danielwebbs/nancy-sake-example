using Nancy;

namespace nancysake.Modules.NumberModule
{
    public class NumberModule : NancyModule
    {

        //returning a int seems to be conisdered a status code, would need to return a json object
        public NumberModule()
        {
            Get["/number"] = _ => { return Response.AsJson(10); };

            Get["/Nancy"] = _ => "Wrong";

            Get["/"] = _ => "Running Nancy";

            Post["/number/{id}"] = parameters =>
            {
                int id = int.Parse(parameters.id);

                return Response.AsJson(id);
            };
  

        }
    }
}
