using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject.Pages
{
    public partial class TimeKeeping : System.Web.UI.Page
    {
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Clear();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx");
            }
            
    }
        protected DowntownDeliEntity dde = new DowntownDeliEntity();

        protected void btnClockIn_Click(object sender, EventArgs e)
        {
            Empworktime ClockInTime = new Empworktime();
            ClockInTime.Clock_In = TimeSpan.Parse(DateTime.Now.ToString());
            Employee emp = dde.Employees.Where(t => t.Emp_User_Name == Username.Text).ToList().FirstOrDefault();
            Empworktime EmpChk = dde.Empworktimes.Where(t => t.Emp_ID == emp.Emp_ID && t.Clock_In != null && t.Clock_Out == null).ToList().FirstOrDefault(); //set error lbl if this returns a value//
            ClockInTime.Emp_ID = emp.Emp_ID;
            ClockInTime.Work_Date = DateTime.Now;
            dde.Empworktimes.Add(ClockInTime);
            dde.SaveChanges();
        }
        protected void btnClockOut_Click(object sender, EventArgs e)
        {
            Empworktime ClocKOutTime = new Empworktime();
            ClocKOutTime.Clock_Out = TimeSpan.Parse(DateTime.Now.ToString());
            Employee emp = dde.Employees.Where(t => t.Emp_User_Name == Username.Text).ToList().FirstOrDefault();
            ClocKOutTime.Emp_ID = emp.Emp_ID;
            ClocKOutTime.Work_Date = DateTime.Now;
            dde.Empworktimes.Add(ClocKOutTime);
            dde.SaveChanges();
        }
        protected void btnViewTimesheet_Click(object sender, EventArgs e)
        {

        }
    }
}