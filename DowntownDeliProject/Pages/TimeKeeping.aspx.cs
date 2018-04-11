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
            Employee emp = dde.Employees.Where(t => t.Emp_User_Name.ToUpper().Equals(Username.Text.ToUpper()) && t.Emp_Password.Equals(Password.Text)).FirstOrDefault();
            if (emp != null)
            {
                TimeSpan span = TimeSpan.Parse("00:00:00.0000000");
                Empworktime EmpChk = dde.Empworktimes.Where(t => t.Emp_ID == emp.Emp_ID && t.Clock_In != span && t.Clock_Out == span).ToList().FirstOrDefault();
                if (EmpChk == null)
                {
                    Empworktime ClockInTime = new Empworktime();
                    ClockInTime.Clock_In = DateTime.Now.TimeOfDay;
                    ClockInTime.Emp_ID = emp.Emp_ID;
                    ClockInTime.Work_Date = DateTime.Now;
                    dde.Empworktimes.Add(ClockInTime);
                    dde.SaveChanges();
                    lblError.Text = "";
                }
                else
                {
                    lblError.Text = "User has already clocked in.";
                    lblError.Visible = true;
                }
            }
            else
            {
                lblError.Text = "Username or Password is incorrect.";
                lblError.Visible = true;
            }

        }
        protected void btnClockOut_Click(object sender, EventArgs e)
        {
            TimeSpan span = TimeSpan.Parse("00:00:00.0000000");
            Employee emp = dde.Employees.Where(t => t.Emp_User_Name.ToUpper().Equals(Username.Text.ToUpper()) && t.Emp_Password.Equals(Password.Text)).FirstOrDefault();
            if (emp != null)
            {
                Empworktime EmpChk = dde.Empworktimes.Where(t => t.Emp_ID == emp.Emp_ID && t.Clock_In != span && t.Clock_Out == span).ToList().FirstOrDefault();
                if (EmpChk != null)
                {
                    EmpChk.Clock_Out = DateTime.Now.TimeOfDay;
                    EmpChk.Emp_ID = emp.Emp_ID;
                    EmpChk.Work_Date = DateTime.Now;
                    dde.SaveChanges();
                    lblError.Text = "";
                }
                else
                {
                    lblError.Text = "User has not clocked in yet.";
                    lblError.Visible = true;
                }
            }
            else
            {
                lblError.Text = "Username or Password is incorrect.";
                lblError.Visible = true;
            }
        }
        protected void btnViewTimesheet_Click(object sender, EventArgs e)
        {
            Employee emp = dde.Employees.Where(t => t.Emp_User_Name.ToUpper().Equals(Username.Text.ToUpper()) && t.Emp_Password.Equals(Password.Text)).FirstOrDefault();
            if (emp != null)
            {
                Empworktime Timesheet = new Empworktime();
                List<Empworktime> WorkTimes = dde.Empworktimes.Where(t => t.Emp_ID == emp.Emp_ID).ToList();
                lvDisplayTimeSheet.DataSource = WorkTimes;
                lvDisplayTimeSheet.DataBind();
                lblError.Text = "";
            }
            else
            {
                lblError.Text = "Username or Password is incorrect.";
                lblError.Visible = true;
            }
        }

    }
}