using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject
{
    public partial class _Default : Page
    {
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dd = new DowntownDeliEntity())
            {
                foreach (Promotion promo in dd.Promotions.Where(a => a.Begin_Date <= DateTime.Now && a.End_Date >= DateTime.Now))
                {
                    Promotions.Text = Promotions.Text + "<div class='alert alert-success' role='alert'>" + promo.Promo_Description + "</div>";
                }
            }
            if (user != null)
            {
                Page.Title = "Welcome, " + user.F_Name + " " + user.L_Name;
            }
            if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Clear();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx");
            }
        }
    }
}