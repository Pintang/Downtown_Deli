using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace DowntownDeliProject
{
    public class Global : HttpApplication
    {
        protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            // This is the page
            string cTheFile = HttpContext.Current.Request.Path;

            // Check if I am all ready on login page to avoid crash
            if (!cTheFile.EndsWith("default.aspx"))
            {
                // Extract the form's authentication cookie
                string cookieName = FormsAuthentication.FormsCookieName;
                HttpCookie authCookie = Context.Request.Cookies[cookieName];

                if (HttpContext.Current.User == null || HttpContext.Current.User.Identity == null || !HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    Response.Redirect("~/default.aspx", true);
                    Response.End();
                    return;
                }
            }
        }

        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}