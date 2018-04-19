using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DowntownDeliProject
{
    public partial class CheckoutComplete : System.Web.UI.Page
    {
        protected Customer customer
        {
            get { return (Customer)Session["cust"]; }
            set { Session["cust"] = value; }
        }

        protected List<Product> cart
        {
            get { return (List<Product>)Session["cart"]; }
            set { Session["cart"] = value; }
        }
        protected bool useRewardPoints
        {
            get { if (Session["usereward"] == null) return false; return (bool)Session["usereward"]; }
            set { Session["usereward"] = value; }
        }

        protected void Page_Init(Object sender, EventArgs e)
        {
            if (cart == null) cart = new List<Product>();

            buildCart();
            cart.Clear();
            shoppingCart.Text = "<b>" + cart.Count + "</b> items in your cart";
        }
        protected void buildCart()
        {
            if (!cart.Any()) return;
            shoppingCartContents.Controls.Clear();
            int index = 0;
            foreach (Product prod in cart)
            {
                shoppingCartContents.Controls.Add(new LiteralControl("<tr><td>" + prod.Product_Name + "</td><td>" + prod.Price.ToString("C") + "</td></tr>"));
                index++;
            }
            using (DowntownDeliEntity dd = new DowntownDeliEntity())
            {
                decimal total = cart.Sum(a => a.Price);
                if (useRewardPoints)
                {
                    total = total - cart.OrderBy(a => a.Price).First().Price;
                    shoppingCartContents.Controls.Add(new LiteralControl("<tr><td>Customer Rewards Discount</td><td>(" + ((decimal)cart.OrderBy(a => a.Price).First().Price).ToString("C") + ")</td><td></td></tr>"));
                }
                DateTime now = DateTime.Now.Date;
                Promotion promo = dd.Promotions.FirstOrDefault(a => a.Begin_Date <= now && a.End_Date >= now && (a.Discount_Type == "Cash Off" || a.Discount_Type == "Percent Off"));
                if (promo != null)
                {
                    if (promo.Discount_Type == "Cash Off")
                    {
                        shoppingCartContents.Controls.Add(new LiteralControl("<tr><td>Promotion</td><td>" + ((decimal)promo.Discount).ToString("C") + "</td></tr>"));
                        total = total + (decimal)promo.Discount;
                    }
                    if (promo.Discount_Type == "Percent Off")
                    {
                        shoppingCartContents.Controls.Add(new LiteralControl("<tr><td>Promotion</td><td>" + ((decimal)promo.Discount).ToString() + "% off</td></tr>"));
                        total = total - (total * ((decimal)promo.Discount / 100));
                    }
                    if (total < 0) total = 0;
                    shoppingCartContents.Controls.Add(new LiteralControl("<tfoot><td>Total</td><td>" + total.ToString("C") + "</td></tfoot>"));
                }
                else
                {
                    if (total < 0) total = 0;
                    shoppingCartContents.Controls.Add(new LiteralControl("<tfoot><td>Total</td><td>" + cart.Sum(a => a.Price).ToString("C") + "</td><td></td></tfoot>"));
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (customer == null) Response.Redirect("default.aspx");

            if (!IsPostBack)
            {
                Name.Text = customer.F_Name + " " + customer.L_Name;
                if (customer.Reward_CardID == null)
                {
                    rewardCard.Text = "<div class='alert alert-danger' role='alert'>You do not have a reward card linked to your account!  Click <a href='UpdateReward.aspx'>here</a> to add one!</div>";
                }
                else
                {
                    rewardCard.Text = "<div class='alert alert-info' role='alert'>You have a reward card linked to your account.  If you would like to update to a new card, click <a href='UpdateReward.aspx'>here</a>.</div>";
                }

                rewardBalance.Text = "<b>" + customer.TotalPoints + "</b> reward points collected!";


            }
        }

        protected void Return_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoggedIn.aspx");
        }
    }
}