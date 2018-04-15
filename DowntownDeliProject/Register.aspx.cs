using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DowntownDeliProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register_Click(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dd = new DowntownDeliEntity())
            {
                Customer cust = dd.Customers.FirstOrDefault(a => a.Phone == Phone.Text);
                if (cust != null)
                {
                    phoneUsed.Style["display"] = "block";
                    return;
                }
                cust = dd.Customers.FirstOrDefault(a => a.Email == Username.Text);
                if (cust != null)
                {
                    usernameUsed.Style["display"] = "block";
                    return;
                }
                cust = new Customer();
                cust.Cust_Password = Password.Text;
                cust.Email = Username.Text;
                cust.F_Name = FirstName.Text;
                cust.L_Name = LastName.Text;
                cust.Phone = Phone.Text;
                dd.Customers.Add(cust);
                dd.SaveChanges();
                Server.Transfer("RegistrationComplete.aspx");
            }
        }
        protected void Phone_TextChanged(object sender, EventArgs e)
        {
            if (Phone.Text != "")
            {
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {
                    Customer cust = dd.Customers.FirstOrDefault(a => a.Phone == Phone.Text);
                    if (cust != null)
                    {
                        phoneUsed.Style["display"] = "block";
                    }
                    else
                    {
                        phoneUsed.Style["display"] = "none";
                    }
                }
            }
            else
            {
                phoneUsed.Style["display"] = "none";
            }
        }

        protected void Username_TextChanged(object sender, EventArgs e)
        {
            if (Username.Text != "")
            {
                using (DowntownDeliEntity dd = new DowntownDeliEntity())
                {
                    Customer cust = dd.Customers.FirstOrDefault(a => a.Email == Username.Text);
                    if (cust != null)
                    {
                        usernameUsed.Style["display"] = "block";
                    }
                    else
                    {
                        usernameUsed.Style["display"] = "none";
                    }
                }
            }
            else
            {
                usernameUsed.Style["display"] = "none";
            }
        }
    }
}