using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject.Pages
{
    public partial class PlaceOrder : System.Web.UI.Page
    {
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
                order = new Order();
                List<Product> prod = dde.Products.OrderBy(t => t.Product_Name).ToList();
                Product initialItem = new Product();
                prod.Insert(0, initialItem);
                ddlProducts.DataSource = prod;
                ddlProducts.DataBind();
                List<Promotion> promos = dde.Promotions.OrderBy(t => t.Discount_Type).ToList();
                Promotion initialPromo = new Promotion();
                promos.Insert(0, initialPromo);
                ddlPromos.DataSource = promos;
                ddlPromos.DataBind();

            }
        }

        protected void txtCustomer_TextChanged(object sender, EventArgs e)
        {
            if (txtCustomer.Text != "")
            {
                long id = long.Parse(txtCustomer.Text.ToString().Trim());
                Customer cust = dde.Customers.Find(id);
                lblCustomer.Text = "ID: " + cust.Customer_ID + " Name: " + cust.F_Name + " " + cust.L_Name;
            }
        }
        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            order.Ord_Date = DateTime.Now;
            order.Price = (order.Price + (order.Price * 0.0675M));
            dde.Orders.Add(order);
            dde.SaveChanges();
        }

        protected void lvOrderItems_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                int quantity = 0;
                ListViewDataItem item = (ListViewDataItem)e.Item;
                IGrouping<long?, Product_Order> query = (IGrouping<long?, Product_Order>)item.DataItem;
                Product_Order prodOrder = query
                            .Where(b => b != null)
                            .ToList().FirstOrDefault();
                foreach (Product_Order ProdItem in order.Product_Order)
                {
                    if (prodOrder.Product_ID == ProdItem.Product_ID)
                    {
                        quantity++;
                    }
                }

                Product prod = dde.Products.Find(prodOrder.Product_ID);
                Label lblProdName = e.Item.FindControl("lblProdName") as Label;
                lblProdName.Text = prod.Product_Name;
                Label lblPrice = e.Item.FindControl("lblPrice") as Label;
                lblPrice.Text = "$" + prod.Price.ToString();
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                lblQuantity.Text = quantity.ToString();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            long prodID = long.Parse(ddlProducts.SelectedItem.Value);
            Product prod = dde.Products.Find(prodID);
            long id = long.Parse(txtCustomer.Text.ToString().Trim());
            Customer cust = dde.Customers.Find(id);
            order.Customer_ID = id;
            int quantity = int.Parse(tbQuantity.Text);
            bool combo = cbCombo.Checked;
            bool dinein = cbDineIn.Checked;
            bool carryout = cbCarryOut.Checked;
            int count = quantity;
            while (count != 0)
            {
                Product_Order pOrder = new Product_Order();
                pOrder.Product_ID = prod.Product_ID;
                order.Product_Order.Add(pOrder);
                count--;
            }
            if (combo)
            {
                Product fry = dde.Products.Find(45);
                Product drink = dde.Products.Find(47);
                decimal ComboPrice = fry.Price + drink.Price;
                order.Price += ComboPrice;
            }
            order.Price += prod.Price * quantity;
            lblSubTotal.Text = "$" + order.Price;
            lblTotal.Text = "$" + (order.Price + (order.Price * 0.0675M)).ToString();
            lvOrderItems.DataSource = order.Product_Order.GroupBy(t => t.Product_ID).ToList();
            lvOrderItems.DataBind();

        }
    }
}