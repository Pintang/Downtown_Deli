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
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }
        protected Order order
        {
            get { return (Order)Session["order"]; }
            set { Session["order"] = value; }
        }
        protected bool ModifyOrder
        {
            get { return (bool)Session["ModifyOrder"]; }
            set { Session["ModifyOrder"] = value; }
        }
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
                if (user != null)
                {
                    Button btnAdmin = (Button)HeadLoginView.FindControl("btnAdmin");
                    Button btnOrder = (Button)HeadLoginView.FindControl("btnOrder");
                    Button btnReports = (Button)HeadLoginView.FindControl("btnReports");
                    Button btnInventory = (Button)HeadLoginView.FindControl("btnInventory");
                    Button btnTimeKeeping = (Button)HeadLoginView.FindControl("btnTimeKeeping");
                    if (user.Job_ID == 2)//cook
                    {
                        btnAdmin.Visible = false;
                        btnOrder.Visible = false;
                        btnReports.Visible = false;
                        btnInventory.Visible = false;
                        btnTimeKeeping.Visible = true;
                    }
                    else if (user.Job_ID == 3)
                    {//cashier
                        btnAdmin.Visible = false;
                        btnOrder.Visible = true;
                        btnReports.Visible = false;
                        btnInventory.Visible = false;
                        btnTimeKeeping.Visible = true;
                    }
                    else if (user.Job_ID == 4)//manager
                    {
                        btnAdmin.Visible = false;
                        btnOrder.Visible = true;
                        btnReports.Visible = true;
                        btnInventory.Visible = true;
                        btnTimeKeeping.Visible = true;
                    }
                    else if (user.Job_ID == 5)// customer.. should never happen but just in case.
                    {
                        btnAdmin.Visible = false;
                        btnOrder.Visible = false;
                        btnReports.Visible = false;
                        btnInventory.Visible = false;
                        btnTimeKeeping.Visible = false;
                    }
                    else
                    {
                        btnAdmin.Visible = true;
                        btnOrder.Visible = true;
                        btnReports.Visible = true;
                        btnInventory.Visible = true;
                        btnTimeKeeping.Visible = true;
                    }


                }


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

        protected void btnInventory_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/InventoryManagement.aspx", false);

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
                    case "Modify":
                        ListViewDataItem item2 = (ListViewDataItem)e.Item;
                        Label lblOrderID2 = (Label)item2.FindControl("lblOrderID");
                        int id2 = int.Parse(lblOrderID2.Text);
                        Order RealOrder2 = dde.Orders.Include("Product_Order").Where(t => t.Order_ID == id2).ToList().Single();
                        order = RealOrder2;
                        ModifyOrder = true;
                        Response.Redirect("~/Pages/PlaceOrder.aspx", false);
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

        protected void lvCurrentOrders_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                if (user != null)
                {
                    if (user.Job_ID != 1 && user.Job_ID != 4 && user.Job_ID != 3)
                    {
                        ListViewDataItem item = (ListViewDataItem)e.Item;
                        Button btnComplete = (Button)item.FindControl("btnComplete");
                        Button btnModify = (Button)item.FindControl("btnModify");
                        btnModify.Visible = false;
                        btnComplete.Visible = false;
                    }
                }

            }
        }
    }

}