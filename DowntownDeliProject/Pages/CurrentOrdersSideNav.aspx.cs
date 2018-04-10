using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DowntownDeliProject.Pages
{
    public partial class CurrentOrdersSideNav : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {
                //lvCurrentOrders.DataSource = dde.Orders.ToList();
            }
        }
    }
}