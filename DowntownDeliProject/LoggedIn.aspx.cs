using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            Name.Text = customer.F_Name + " " + customer.L_Name;
        }
    }
}