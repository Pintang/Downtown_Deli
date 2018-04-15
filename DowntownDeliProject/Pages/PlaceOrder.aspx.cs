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
        protected bool ModifyOrder
        {
            get { return (bool)Session["ModifyOrder"]; }
            set { Session["ModifyOrder"] = value; }
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
                if (order != null)
                {
                    Customer cust = dde.Customers.Find(order.Customer_ID);
                    if (cust != null)
                    {
                        lblCustomer.Text = "ID: " + cust.Customer_ID + " Name: " + cust.F_Name + " " + cust.L_Name;
                    }
                    else
                    {
                        lblCustomer.Text = "Customer not Found. Try again.";
                    }
                    lblSubTotal.Text = "$" + order.Price;
                    lblTotal.Text = "$" + (order.Price + (order.Price * 0.0675M)).ToString();
                    lvOrderItems.DataSource = dde.Product_Order.Where(t => t.Order_ID == order.Order_ID).GroupBy(t => t.Product_ID).ToList();
                    lvOrderItems.DataBind();
                }
                else
                {
                    order = new Order();
                }

            }
        }

        protected void txtCustomer_TextChanged(object sender, EventArgs e)
        {

            if (txtCustomer.Text != "")
            {
                long id = long.Parse(txtCustomer.Text.ToString().Trim());
                Customer cust = dde.Customers.Find(id);
                if (cust != null)
                {
                    lblCustomer.Text = "ID: " + cust.Customer_ID + " Name: " + cust.F_Name + " " + cust.L_Name;
                }
                else
                {
                    lblCustomer.Text = "Customer not Found. Try again.";
                }
            }
        }
        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            bool valid = false;
            if (ddlPromos.SelectedItem.Value != "0")
            {
                long PromoID = long.Parse(ddlPromos.SelectedItem.Value);
                Promotion promo = dde.Promotions.Find(PromoID);
                if (promo != null)
                {

                    if (promo.Discount_Type == "Percent Off")
                    {
                        if (promo.Discount != null)
                        {
                            order.Ord_Date = DateTime.Now;
                            order.Price = ((order.Price + (order.Price * ((Decimal)promo.Discount / 100))) + (order.Price * 0.0675M));
                            dde.Orders.Add(order);
                            dde.SaveChanges();
                            valid = true;
                        }
                    }
                    else if (promo.Discount_Type == "Cash Off")
                    {
                        if (promo.Discount != null)
                        {
                            order.Ord_Date = DateTime.Now;
                            order.Price = ((order.Price + (Decimal)promo.Discount) + (order.Price * 0.0675M));
                            dde.Orders.Add(order);
                            dde.SaveChanges();
                            valid = true;

                        }
                    }
                    else
                    {
                        Product_Order cheapestProd = order.Product_Order.Where(t => t.Product.Price > 0).OrderBy(t => t.Product.Price).FirstOrDefault();
                        if (cheapestProd != null)
                        {
                            order.Ord_Date = DateTime.Now;
                            order.Price = ((order.Price - cheapestProd.Product.Price) + (order.Price * 0.0675M));
                            dde.Orders.Add(order);
                            dde.SaveChanges();
                            valid = true;

                        }
                    }
                }
            }
            else
            {
                order.Ord_Date = DateTime.Now;
                order.Price = (order.Price + (order.Price * 0.0675M));
                dde.Orders.Add(order);
                dde.SaveChanges();
                valid = true;

            }
            if (valid)
            {
                foreach (Product_Order prodOrder in order.Product_Order)
                {
                    Product prods = dde.Products.Find(prodOrder.Product_ID);
                    foreach (Product_Inventory prodInv in prods.Product_Inventory)
                    {
                        Inventory inv = dde.Inventories.Find(prodInv.Item_ID);
                        inv.Quantity -= 1;
                        dde.SaveChanges();
                    }
                }
                submitSide.Visible = false;
                ddlProducts.ClearSelection();
                ddlPromos.ClearSelection();
                tbQuantity.Text = "";
                txtCustomer.Text = "";
                lblCustomer.Text = "";
                order = new Order();
                valid = true;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "OpenModal('SuccessModal')", true);
            }
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
            bool valid = false;
            if (ddlProducts.SelectedItem.Value != "0")
            {
                long prodID = long.Parse(ddlProducts.SelectedItem.Value);
                Product prod = dde.Products.Find(prodID);
                bool Invent = true;
                foreach (Product_Inventory inv in prod.Product_Inventory)
                {
                    Inventory i = dde.Inventories.Find(inv.Item_ID);
                    if (i.Quantity == 0)
                    {
                        Invent = false;
                    }
                }
                if (Invent)
                {
                    if (!cbGuest.Checked)
                    {
                        Customer cust = new Customer();
                        if (txtCustomer.Text.ToString().Trim() != "")
                        {
                            long id = long.Parse(txtCustomer.Text.ToString().Trim());
                            cust = dde.Customers.Find(id);
                            if (cust == null)
                            {
                                cust = dde.Customers.Where(t => t.Phone == id.ToString()).FirstOrDefault();
                                if (cust == null)
                                {
                                    cust = dde.Customers.Where(t => t.Reward_CardID == id.ToString()).FirstOrDefault();
                                }
                            }
                            order.Customer_ID = id;
                            if (tbQuantity.Text != "")
                            {
                                lblError.Text = "";
                                int quantity = int.Parse(tbQuantity.Text);
                                if (quantity > 0)
                                {
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
                                    valid = true;
                                }
                                else
                                {
                                    lblError.Text = "Quantity must be greater than 0.";

                                }
                            }
                            else
                            {
                                lblError.Text = "Please select a quantity before trying to add to order.";
                            }
                        }
                        else
                        {
                            lblError.Text = "You must enter a customer or select guest.";
                        }

                    }
                    else
                    {
                        if (tbQuantity.Text != "")
                        {
                            lblError.Text = "";
                            int quantity = int.Parse(tbQuantity.Text);
                            if (quantity > 0)
                            {
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
                                valid = true;
                            }
                            else
                            {
                                lblError.Text = "Quantity must be greater than 0.";

                            }
                        }
                        else
                        {
                            lblError.Text = "Please select a quantity before trying to add to order.";
                        }
                    }
                }
            }
            else
            {
                lblError.Text = "Please select a product before trying to add to order.";
            }
            if (valid)
            {
                submitSide.Visible = true;
            }
                
        }
    }
}