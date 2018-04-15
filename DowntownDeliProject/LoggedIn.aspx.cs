using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject
{
    public partial class LoggedIn : System.Web.UI.Page
    {
        protected Customer customer
        {
            get { return (Customer)Session["cust"]; }
            set { Session["cust"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (customer == null) Response.Redirect("default.aspx");

            Name.Text = customer.F_Name + " " + customer.L_Name;
            if (customer.Reward_CardID == null)
            {
                rewardCard.Text = "<div class='alert alert-danger' role='alert'>You do not have a reward card linked to your account!  Click <a href='UpdateReward.aspx'>here</a> to add one!</div>";
            }
            else
            {
                rewardCard.Text = "<div class='alert alert-info' role='alert'>You have a reward card linked to your account.  If you would like to update to a new card, click <a href='UpdateReward.aspx'>here</a>.</div>";
            }

            rewardBalance.Text = "<h3>You have <b>" + customer.TotalPoints + "</b> reward points collected!</h3>";
        }
    }
}