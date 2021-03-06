﻿using System;
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
        protected List<Product_Order> deletedProducts
        {
            get { return (List<Product_Order>)Session["deletedProducts"]; }
            set { Session["deletedProducts"] = value; }
        }
        protected bool ModifyOrder
        {
            get { return (bool)Session["ModifyOrder"]; }
            set { Session["ModifyOrder"] = value; }
        }
        protected DowntownDeliEntity dde = new DowntownDeliEntity();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (user != null)
            {
                if (user.Job_ID != 1 && user.Job_ID != 4 && user.Job_ID != 3)
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
            if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Clear();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx");
            }
            if (!Page.IsPostBack)
            {
                deletedProducts = new List<Product_Order>();
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
                    if (ModifyOrder)
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
                        order = dde.Orders.Find(order.Order_ID);
                        lblSubTotal.Text = string.Format("{0:C}", order.Price.ToString("0.00"));
                        lblTotal.Text = string.Format("{0:C}", (order.Price + (order.Price * 0.0675M)).ToString("0.00"));
                        lvOrderItems.DataSource = order.Product_Order.GroupBy(t => t.Product_ID).ToList();
                        lvOrderItems.DataBind();
                        submitSide.Visible = true;
                    }
                }
                else
                {
                    order = new Order();
                    ModifyOrder = false;
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
            if (ModifyOrder) {
                order = dde.Orders.Find(order.Order_ID);
            }
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
                            if (!ModifyOrder)
                            {
                                dde.Orders.Add(order);
                            }
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
                            if (!ModifyOrder)
                            {
                                dde.Orders.Add(order);
                            }
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
                            if (!ModifyOrder)
                            {
                                dde.Orders.Add(order);
                            }
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
                if (!ModifyOrder)
                {
                    dde.Orders.Add(order);
                }
                dde.SaveChanges();
                valid = true;
            }
            if (valid)
            {
                if (!ModifyOrder)
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
                }
                else
                {
                    foreach (Product_Order prodOrder in deletedProducts)
                    {
                        Product prods = dde.Products.Find(prodOrder.Product_ID);
                        foreach (Product_Inventory prodInv in prods.Product_Inventory)
                        {
                            Inventory inv = dde.Inventories.Where(t => t.Item_ID == prodInv.Item_ID).Single();
                            inv.Quantity += 1;
                            dde.SaveChanges();
                        }
                    }
                }
                submitSide.Visible = false;
                ddlProducts.ClearSelection();
                ddlPromos.ClearSelection();
                lvOrderItems.DataSource = null;
                lvOrderItems.DataBind();
                tbQuantity.Text = "";
                txtCustomer.Text = "";
                lblCustomer.Text = "";
                order = new Order();
                ModifyOrder = false;
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
                lblPrice.Text = String.Format("{0:C}", prod.Price);
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                lblQuantity.Text = quantity.ToString();
                Label lblProductID = (Label)e.Item.FindControl("lblProductID");
                lblProductID.Text = prod.Product_ID.ToString();

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
                                    order.Price += prod.Price * quantity;
                                    lblSubTotal.Text = String.Format("{0:C}", order.Price);
                                    lblTotal.Text = String.Format("{0:C}", order.Price + (order.Price * 0.0675M));
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
                                order.Price += prod.Price * quantity;
                                lblSubTotal.Text = String.Format("{0:C}", order.Price);
                                lblTotal.Text = String.Format("{0:C}", order.Price + (order.Price * 0.0675M));
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

        protected void lvOrderItems_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblProductID = (Label)item.FindControl("lblProductID");
                    int id = int.Parse(lblProductID.Text);
                    Product prod = dde.Products.Find(id);
                    List<Product_Order> prodOrders = order.Product_Order.Where(t => t.Order_ID == order.Order_ID && t.Product_ID == prod.Product_ID).ToList();
                    foreach (Product_Order ord in prodOrders)
                    {
                        deletedProducts.Add(ord);
                        order.Product_Order.Remove(ord);
                    }
                    order.Price = 0;
                    foreach (Product_Order ord in order.Product_Order)
                    {
                        Product prod2 = dde.Products.Find(ord.Product_ID);
                        order.Price += prod2.Price;
                    }
                    lblSubTotal.Text = String.Format("{0:C}", order.Price);
                    lblTotal.Text = String.Format("{0:C}", order.Price + (order.Price * 0.0675M));
                    lvOrderItems.DataSource = order.Product_Order.GroupBy(t => t.Product_ID).ToList();
                    lvOrderItems.DataBind();
                    break;
            }
        }
    }
}