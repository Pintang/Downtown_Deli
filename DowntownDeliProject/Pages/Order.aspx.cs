using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject.Pages
{
    public partial class Order : System.Web.UI.Page
    {
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }
        protected List<Product> OrderItems
        {
            get { return (List<Product>)Session["OrderItems"]; }
            set { Session["OrderItems"] = value; }
        }
        protected DowntownDeliEntity dde = new DowntownDeliEntity();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Clear();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx");
            }
            if (!Page.IsPostBack)
            {
                OrderItems = new List<Product>();
            }
            lvOrderItems.DataSource = OrderItems;
            lvOrderItems.DataBind();

            List<Product> prod = dde.Products.OrderBy(t => t.Product_Name).ToList();
            Product initialItem = new Product();
            prod.Insert(0, initialItem);
            ddlProducts.DataSource = prod;
            ddlProducts.DataBind();
        }

        protected void txtCustomer_TextChanged(object sender, EventArgs e)
        {
            if (txtCustomer.Text != "")
            {
                lvIDs.DataSource = dde.Customers.Where(t => t.Customer_ID.ToString().Contains(txtCustomer.Text)).ToList();
                lvIDs.DataBind();
            }
        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {

        }

        protected void lvOrderItems_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
            }
        }
    }
}