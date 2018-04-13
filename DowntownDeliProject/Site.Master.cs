using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.Linq;

namespace DowntownDeliProject
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.User != null && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (DowntownDeliEntity dde = new DowntownDeliEntity())
                {
                    ListView lvCurrentOrders = (ListView)HeadLoginView.FindControl("lvCurrentOrders");
                    lvCurrentOrders.DataSource = dde.Orders.Include("Customer").Where(t => t.Complete == false || t.Complete == null).ToList();
                    lvCurrentOrders.DataBind();
                }
            }
            else
            {
                FormsAuthentication.SignOut();
            }
        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/PlaceOrder.aspx", false);
        }

        protected void btnReports_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Reports.aspx", false);
        }

        protected void btnTimeKeeping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/TimeKeeping.aspx", false);
        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Admin.aspx", false);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Home.aspx", false);
        }

        protected void lvCurrentOrders_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {
                switch (e.CommandName)
                {
                    case "Complete":
                        ListViewDataItem item = (ListViewDataItem)e.Item;
                        Label lblOrderID = (Label)item.FindControl("lblOrderID");
                        int id = int.Parse(lblOrderID.Text);
                        Order RealOrder = dde.Orders.Find(id);
                        RealOrder.Complete = true;
                        dde.SaveChanges();
                        ListView lvCurrentOrders = (ListView)HeadLoginView.FindControl("lvCurrentOrders");
                        lvCurrentOrders.DataSource = dde.Orders.Include("Customer").Where(t => t.Complete == false || t.Complete == null).ToList();
                        lvCurrentOrders.DataBind();
                        break;
                }
            }
        }

        protected void lvCurrentOrders_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {

                ListView lvCurrentOrders = (ListView)HeadLoginView.FindControl("lvCurrentOrders");
                DataPager lvCurrentOrdersPager = lvCurrentOrders.FindControl("lvCurrentOrdersPager") as DataPager;
                int CurrentPage = ((lvCurrentOrdersPager.StartRowIndex) / lvCurrentOrdersPager.MaximumRows) + 1;
                lvCurrentOrdersPager.SetPageProperties(lvCurrentOrdersPager.StartRowIndex, lvCurrentOrdersPager.MaximumRows, false);
                lvCurrentOrders.DataSource = dde.Orders.Include("Customer").Where(t => t.Complete == false || t.Complete == null).ToList();
                lvCurrentOrders.DataBind();
            }
        }
    }

}