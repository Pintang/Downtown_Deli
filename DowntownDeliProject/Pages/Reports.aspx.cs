using System;
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
            DateTime start = DateTime.Parse(StartDateDatePickerReportsInput.Value);
            DateTime end = DateTime.Parse(StopDateDatePickerReportsInput.Value);
            if (ddlProducts.SelectedItem.Text == "Timekeeping")
            {
                Data.Text = "<table class='table'><thead><th>Name</th><th>Date</th><th>Hours</th></thead>";
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {
                    foreach (Empworktime work in dd.Empworktimes.Where(a => a.Work_Date >= start && a.Work_Date <= end).OrderBy(a => a.Work_Date))
                    {
                        Data.Text = Data.Text + "<tr><td>" + work.Employee.F_Name + " " + work.Employee.L_Name + "</td><td>" + work.Work_Date + "</td><td>" + (work.Clock_Out - work.Clock_In).TotalHours + " hours</td></tr>";
                    }
                }
                Data.Text = Data.Text + "</table>";
            }
            if (ddlProducts.SelectedItem.Text == "Sales")
            {
                Data.Text = "<table class='table'><thead><th>Date</th><th>Total Sales</th></thead>";
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {

                    foreach (DateTime date in dd.Orders.Where(a => a.Ord_Date >= start && a.Ord_Date <= end).Select(a => a.Ord_Date).Distinct())
                    {
                        Decimal profit = dd.Orders.Where(a => a.Ord_Date == date).Sum(a => a.Price);
                        Data.Text = Data.Text + "<tr><td>" + date.ToShortDateString() + "</td><td>" + profit.ToString("C") + "</td></tr>";
                    }
                }
                Data.Text = Data.Text + "</table>";
            }
            if (ddlProducts.SelectedItem.Text == "Top Selling Item")
            {
                Data.Text = "<table class='table'><thead><th>Date</th><th>Total Sales</th></thead>";
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {

                    foreach (DateTime date in dd.Orders.Where(a => a.Ord_Date >= start && a.Ord_Date <= end).Select(a => a.Ord_Date).Distinct())
                    {
                        Dictionary<long, int> prod = new Dictionary<long, int>();
                        foreach (Order ord in dd.Orders.Where(a => a.Ord_Date == date))
                        {
                            foreach (Product_Order pord in ord.Product_Order)
                            {
                                if (!prod.ContainsKey((long)pord.Product_ID))
                                { prod[(long)pord.Product_ID] = 1; }
                                else
                                { prod[(long)pord.Product_ID]++; }
                            }
                        }
                        if (!prod.Any()) break;
                        long id = prod.OrderByDescending(x => x.Value).ToDictionary(a => a.Key, a => a.Value).First().Key;
                        Product product = dd.Products.FirstOrDefault(a => a.Product_ID == id);
                        Data.Text = Data.Text + "<tr><td>" + date.ToShortDateString() + "</td><td>" + product.Product_Name + "</td></tr>";
                    }
                }
                Data.Text = Data.Text + "</table>";
            }
            
        }

        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProducts.SelectedItem.Text != "")
            {
                DivDatePicker1.Visible = true;
            }
            else
            {
                DivDatePicker1.Visible = false;
                Data.Text = "";
            }

            if (ddlProducts.SelectedItem.Text != "")
            {
                DivDatePicker2.Visible = true;
            }
            else
            {
                DivDatePicker2.Visible = false;
                Data.Text = "";
            }
        }
    }
}