﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;

namespace DowntownDeliProject.Pages
{
    public partial class Reports : System.Web.UI.Page
    {
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    Response.Clear();
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/Login.aspx");
                }
            }
        }
        protected void Generate_Report(object sender, EventArgs e)
        {
        }

        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProducts.SelectedItem.Text == "Sales" || ddlProducts.SelectedItem.Text == "Timekeeping") {
                DivDatePicker1.Visible = true;
            }
            else DivDatePicker1.Visible = false;

            if (ddlProducts.SelectedItem.Text == "Sales" || ddlProducts.SelectedItem.Text == "Timekeeping")
            {
                DivDatePicker2.Visible = true;
            }
            else DivDatePicker2.Visible = false;
        }
    }
}