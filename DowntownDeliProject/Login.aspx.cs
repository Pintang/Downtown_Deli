using System;
using System.Web;
using System.Linq;
using System.Web.Security;

namespace DowntownDeliProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
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
                    }else
                    {
                        FailureText.Text = "Username or Password is incorrect.";
                        ErrorMessage.Visible = true;
                    }
                }
            }
        }
    }
}