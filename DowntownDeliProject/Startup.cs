using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DowntownDeliProject.Startup))]
namespace DowntownDeliProject
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
