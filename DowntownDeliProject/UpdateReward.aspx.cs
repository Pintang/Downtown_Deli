using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DowntownDeliProject
{
    public partial class UpdateReward : System.Web.UI.Page
    {
        protected Customer customer
        {
            get { return (Customer)Session["cust"]; }
            set { Session["cust"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (customer == null) Response.Redirect("default.aspx");

            if (customer.Reward_CardID != null) reward.Text = customer.Reward_CardID;
        }

        protected void UpdateReward_Click(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dd = new DowntownDeliEntity())
            {
                Customer cust = dd.Customers.First(a => a.Customer_ID == customer.Customer_ID);
                cust.Reward_CardID = reward.Text;
                dd.SaveChanges();
            }
            customer.Reward_CardID = reward.Text;
            Response.Redirect("LoggedIn.aspx");
        }
    }
}