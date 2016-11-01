using System;
using NUnit.Framework;
using Nancy.Testing;

namespace nancysake.Tests
{
    [TestFixture]
    public class NumberModuleTests
    {
        [Test]
        public void TestNumberModuleGetExists_GivenNothing_ShouldReturnHttpStatusCodeOK()
        {
            var bootstrapper = new Nancy.DefaultNancyBootstrapper();
            var browser = new Browser(bootstrapper);

            var result = browser.Get("/number", with =>
            {
                with.HttpRequest();
            });


            Assert.AreEqual(Nancy.HttpStatusCode.OK, result.StatusCode);
        }

        [Test]
        public void TestNumberModuleGet_GivenNothing_ShouldReturnTheIntergerTen()
        {
            var bootstrapper = new Nancy.DefaultNancyBootstrapper();
            var browser = new Browser(bootstrapper);

            var result = browser.Get("/number", with =>
            {
                with.HttpRequest();
            });

            Assert.AreEqual(10, int.Parse(result.Body.AsString()));
        }

        [Test]
        public void TestNumberModulePost_GivenTheNumberSeven_ShouldReturnTheNumberSeven()
        {
            var bootstrapper = new Nancy.DefaultNancyBootstrapper();
            var browser = new Browser(bootstrapper);

            var result = browser.Post("/number/7", with =>
            {
                with.HttpRequest();
            });

            Assert.AreEqual(7, int.Parse(result.Body.AsString()));
        }
    }
}
