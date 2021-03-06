﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {
                    DateTime now = DateTime.Now.Date;
                    foreach (Promotion promo in dd.Promotions.Where(a => a.Begin_Date <= now && a.End_Date >= now && (a.Discount_Type == "Cash Off" || a.Discount_Type == "Percent Off")))
                    {
                        Promotions.Text = Promotions.Text + "<div class='alert alert-success' role='alert'>" + promo.Promo_Description + "</div>";
                        return;
                    }
                }
            }
        }

        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }

        protected Customer customer
        {
            get { return (Customer)Session["cust"]; }
            set { Session["cust"] = value; }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {
                    Employee emp = dd.Employees.Where(t => t.Emp_User_Name.ToUpper().Equals(Username.Text.ToUpper()) && t.Emp_Password.Equals(Password.Text)).FirstOrDefault();
                    if (emp != null)
                    {
                        user = emp;
                        FormsAuthentication.RedirectFromLoginPage(Username.Text, true);
                        return;
                    }
                    Customer cust = dd.Customers.Where(t => t.Email.ToUpper().Equals(Username.Text.ToUpper()) && t.Cust_Password == Password.Text).FirstOrDefault();
                    if (cust != null)
                    {
                        customer = cust;
                        FormsAuthentication.RedirectFromLoginPage(Username.Text, true);
                        Response.Redirect("LoggedIn.aspx");
                        return;
                    }

                    FailureText.Text = "Username or Password is incorrect.";
                    ErrorMessage.Visible = true;
                }
            }
        }

        protected void Register(object sender, EventArgs e)
        {
            Server.Transfer("Register.aspx");
        }

    }
}