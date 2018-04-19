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

        protected List<Product> cart
        {
            get { return (List<Product>)Session["cart"]; }
            set { Session["cart"] = value; }
        }

        protected void Page_Init(Object sender, EventArgs e)
        {
            if (cart == null) cart = new List<Product>();

            using (DowntownDeliEntity dd = new DowntownDeliEntity())
            {
                foreach (Product prod in dd.Products)
                {
                    Menu.Controls.Add(new LiteralControl("<tr><td>"));
                    CheckBox menucheck = new CheckBox();
                    menucheck.ID = prod.Product_ID.ToString();
                    Menu.Controls.Add(menucheck);
                    Menu.Controls.Add(new LiteralControl("</td><td>" + prod.Product_Name + "</td><td>" + prod.Price.ToString("C") + "</td ></tr>"));
                }
            }

            buildCart();
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

                shoppingCart.Text = "<b>" + cart.Count + "</b> items in your cart";

            }
        }

        protected void buildCart()
        {
            shoppingCartContents.Controls.Clear();
            int index = 0;
            foreach (Product prod in cart)
            {
                shoppingCartContents.Controls.Add(new LiteralControl("<tr><td>" + prod.Product_Name + "</td><td>" + prod.Price.ToString("C") + "</td><td>"));
                Button remove = new Button();
                remove.ID = index.ToString();
                remove.Text = "Remove";
                remove.Click += Remove_Click;
                shoppingCartContents.Controls.Add(remove);
                shoppingCartContents.Controls.Add(new LiteralControl("</td></tr>"));
                index++;
            }
        }

        protected void Remove_Click(object sender, EventArgs e)
        {
            int remove = int.Parse(((Button)sender).ID);
            cart.RemoveAt(remove);
            shoppingCart.Text = "<b>" + cart.Count + "</b> items in your cart";
            buildCart();
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dd = new DowntownDeliEntity())
            {
                foreach (Control c in Menu.Controls)
                {
                    if (c is CheckBox && ((CheckBox)c).Checked)
                    {
                        long id = long.Parse(c.ID);
                        cart.Add(dd.Products.First(a => a.Product_ID == id));
                    }
                }
            }
            shoppingCart.Text = "<b>" + cart.Count + "</b> items in your cart";
            buildCart();
        }
    }
}