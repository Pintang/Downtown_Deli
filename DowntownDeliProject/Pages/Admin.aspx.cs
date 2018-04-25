using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject.Pages
{
    public partial class Admin : System.Web.UI.Page
    {
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }
        protected Product prod
        {
            get { return (Product)Session["prod"]; }
            set { Session["prod"] = value; }
        }
        protected DowntownDeliEntity dde = new DowntownDeliEntity();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Clear();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx");
            }
        }
        #region btn


        protected void btnMenuItems_Click(object sender, EventArgs e)
        {
            lvMenuItems.DataSource = dde.Products.OrderBy(t => t.Product_Name).ToList();
            lvMenuItems.DataBind();
            List<Product> prods = dde.Products.OrderBy(t => t.Product_Name).ToList();
            Product initialprods = new Product();
            prods.Insert(0, initialprods);
            ddlMenuItemProducts.DataSource = prods;
            ddlMenuItemProducts.DataBind();
            lvNewInventory.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
            lvNewInventory.DataBind();
            MenuDiv.Visible = true;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = false;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = false;
        }

        protected void btnEmployees_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = true;
            PromoDiv.Visible = false;
            VendorDiv.Visible = false;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = false;
            lvEmployees.DataSource = dde.Employees.OrderBy(t => t.L_Name).ToList();
            lvEmployees.DataBind();
            ddlScheduleEmpModify.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            ddlScheduleEmpModify.DataBind();
            ddlScheduleNew.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            ddlScheduleNew.DataBind();
            ddlJobEmpModify.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            ddlJobEmpModify.DataBind();
            ddlJobEmpNew.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            ddlJobEmpNew.DataBind();
            ddlEmployeeModify.DataSource = dde.Employees.OrderBy(t => t.L_Name).ToList();
            ddlEmployeeModify.DataBind();

        }

        protected void btnPromotions_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = true;
            VendorDiv.Visible = false;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = false;
            lvPromos.DataSource = dde.Promotions.OrderBy(t => t.Promo_Description).Where(t => t.Discount_Type != "Reward Claim").ToList();
            lvPromos.DataBind();
            ddlPromoModify.DataSource = dde.Promotions.OrderBy(t => t.Promo_Description).ToList();
            ddlPromoModify.DataBind();
        }

        protected void btnVendors_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = true;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = false;
            lvVendors.DataSource = dde.Vendors.OrderBy(t => t.Vendor_Name).ToList();
            lvVendors.DataBind();
            ddlVendorModify.DataSource = dde.Vendors.OrderBy(t => t.Vendor_Name).ToList();
            ddlVendorModify.DataBind();
        }

        protected void btnJobs_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = false;
            JobsDiv.Visible = true;
            ScheduleDiv.Visible = false;
            lvJobs.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            lvJobs.DataBind();
            ddlJobsModify.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            ddlJobsModify.DataBind();
        }

        protected void btnSchedule_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = false;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = true;
            lvSchedule.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            lvSchedule.DataBind();
            ddlScheduleModify.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            ddlScheduleModify.DataBind();
        }
        #endregion

        #region Menu Items

        protected void btnUpdateMenuItem_Click(object sender, EventArgs e)
        {
            long id = long.Parse(ddlMenuItemProducts.SelectedValue);
            prod = dde.Products.Find(id);
            prod.Price = decimal.Parse(txtMenuItemPrice.Text);
            dde.SaveChanges();
            List<Inventory> listofItems = new List<Inventory>();
            foreach (ListViewDataItem item in lvInventoryItems.Items)
            {
                CheckBox cbProductInvItem = (CheckBox)item.FindControl("cbProductInvItem");
                if (cbProductInvItem.Checked)
                {
                    Label lblItemID = (Label)item.FindControl("lblItemID");
                    int id2 = int.Parse(lblItemID.Text);
                    Inventory invItem = dde.Inventories.Find(id2);
                    if (invItem != null)
                    {
                        listofItems.Add(invItem);
                    }
                }
            }
            foreach (Inventory inv in listofItems)
            {
                Product_Inventory prodInv = dde.Product_Inventory.Where(t => t.Item_ID == inv.Item_ID && prod.Product_ID == t.Product_ID).ToList().FirstOrDefault();
                if (prodInv == null)
                {
                    Product_Inventory NewprodInv = new Product_Inventory();
                    NewprodInv.Item_ID = inv.Item_ID;
                    NewprodInv.Product_ID = prod.Product_ID;
                    dde.Product_Inventory.Add(NewprodInv);
                    dde.SaveChanges();
                }

            }
            foreach (Product_Inventory prodInv in prod.Product_Inventory.ToList())
            {
                if (!listofItems.Contains(prodInv.Inventory))
                {
                    Product_Inventory prodInv2 = dde.Product_Inventory.Find(prodInv.Prod_Inv_ID);
                    dde.Product_Inventory.Remove(prodInv2);
                    dde.SaveChanges();
                }

            }
            prod = new Product();
        }

        protected void ddlMenuItemProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            long id = long.Parse(ddlMenuItemProducts.SelectedValue);
            prod = dde.Products.Find(id);
            MenuItemUpdateDiv.Visible = true;
            lvInventoryItems.DataSource = dde.Inventories.ToList();
            lvInventoryItems.DataBind();
            txtMenuItemPrice.Text = prod.Price.ToString("0.00");
        }

        protected void lvInventoryItems_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                Inventory inv = (Inventory)item.DataItem;
                if (prod != null)
                {
                    Product_Inventory prodInv = dde.Product_Inventory.Where(t => t.Item_ID == inv.Item_ID && t.Product_ID == prod.Product_ID).ToList().FirstOrDefault();
                    if (prodInv != null)
                    {
                        CheckBox cbProductInvItem = (CheckBox)item.FindControl("cbProductInvItem");
                        cbProductInvItem.Checked = true;
                    }
                }
            }
        }

        protected void btnAddNewMenuItem_Click(object sender, EventArgs e)
        {
            Product Newprod = new Product();
            Newprod.Product_Name = tbMenuItemNameNew.Text;
            Newprod.Price = decimal.Parse(tbNewMenuPrice.Text);
            dde.Products.Add(Newprod);
            dde.SaveChanges();
            List<Inventory> listofItems = new List<Inventory>();
            foreach (ListViewDataItem item in lvNewInventory.Items)
            {
                CheckBox cbProductInvItem = (CheckBox)item.FindControl("cbProductInvItem");
                if (cbProductInvItem.Checked)
                {
                    Label lblItemID = (Label)item.FindControl("lblItemID");
                    int id2 = int.Parse(lblItemID.Text);
                    Inventory invItem = dde.Inventories.Find(id2);
                    if (invItem != null)
                    {
                        listofItems.Add(invItem);
                    }
                }
            }
            foreach (Inventory inv in listofItems)
            {
                Product_Inventory NewprodInv = new Product_Inventory();
                NewprodInv.Item_ID = inv.Item_ID;
                NewprodInv.Product_ID = Newprod.Product_ID;
                dde.Product_Inventory.Add(NewprodInv);
                dde.SaveChanges();
            }
        }
        protected void lvMenuItems_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblItemID = (Label)item.FindControl("lblItemID");
                    int id = int.Parse(lblItemID.Text);
                    Product prodDelete = dde.Products.Find(id);
                    foreach (Product_Inventory prodInv in prodDelete.Product_Inventory.ToList())
                    {
                        dde.Product_Inventory.Remove(prodInv);
                        dde.SaveChanges();
                    }
                    dde.Products.Remove(prodDelete);
                    dde.SaveChanges();
                    lvMenuItems.DataSource = dde.Products.OrderBy(t => t.Product_Name).ToList();
                    lvMenuItems.DataBind();
                    break;
            }
        }

        protected void lvMenuItems_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {
                DataPager lvMenuItemsPager = lvMenuItems.FindControl("lvMenuItemsPager") as DataPager;
                int CurrentPage = ((lvMenuItemsPager.StartRowIndex) / lvMenuItemsPager.MaximumRows) + 1;
                lvMenuItemsPager.SetPageProperties(lvMenuItemsPager.StartRowIndex, lvMenuItemsPager.MaximumRows, false);
                lvMenuItems.DataSource = dde.Products.OrderBy(t => t.Product_Name).ToList();
                lvMenuItems.DataBind();
            }
        }
        #endregion

        #region Employees

        protected void lvEmployees_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblEmpID = (Label)item.FindControl("lblEmpID");
                    int id = int.Parse(lblEmpID.Text);
                    Employee emp = dde.Employees.Find(id);
                    dde.Employees.Remove(emp);
                    dde.SaveChanges();
                    lvEmployees.DataSource = dde.Employees.OrderBy(t => t.L_Name).ToList();
                    lvEmployees.DataBind();
                    break;
            }
        }

        protected void ddlEmployeeModify_SelectedIndexChanged(object sender, EventArgs e)
        {
            long id = long.Parse(ddlEmployeeModify.SelectedValue);
            Employee emp = dde.Employees.Find(id);
            divEmployeeModify.Visible = true;
            ddlJobEmpModify.SelectedValue = emp.Job_ID.ToString();
            ddlScheduleEmpModify.SelectedValue = emp.Schedule_ID.ToString();
            txtFirstnameModify.Text = emp.F_Name;
            txtLastnameModify.Text = emp.L_Name;
            txtPayModify.Text = emp.Pay_Rate.ToString("#.##");
            txtPhoneModify.Text = emp.Phone;
            txtEmailModify.Text = emp.Email;
            txtAddressModify.Text = emp.Emp_Address;
            txtUsername.Text = emp.Emp_User_Name;
            txtPassword.Text = emp.Emp_Password;


        }

        protected void btnUpdateEmployee_Click(object sender, EventArgs e)
        {
            long id = long.Parse(ddlEmployeeModify.SelectedValue);
            Employee emp = dde.Employees.Find(id);
            emp.Job_ID = int.Parse(ddlJobEmpModify.SelectedValue);
            emp.Schedule_ID = int.Parse(ddlScheduleEmpModify.SelectedValue);
            emp.F_Name = txtFirstnameModify.Text;
            emp.L_Name = txtLastnameModify.Text;
            emp.Pay_Rate = decimal.Parse(txtPayModify.Text);
            emp.Phone = txtPhoneModify.Text;
            emp.Email = txtEmailModify.Text;
            emp.Emp_Address = txtAddressModify.Text;
            emp.Emp_User_Name = txtUsername.Text;
            if (txtPassword.Text != "")
            {
                emp.Emp_Password = txtPassword.Text;
            }
            dde.SaveChanges();
            lvEmployees.DataSource = dde.Employees.OrderBy(t => t.L_Name).ToList();
            lvEmployees.DataBind();
        }

        protected void btnNewEmployee_Click(object sender, EventArgs e)
        {
            Employee emp = new Employee();
            emp.Job_ID = int.Parse(ddlJobEmpNew.SelectedValue);
            emp.Schedule_ID = int.Parse(ddlScheduleNew.SelectedValue);
            emp.F_Name = txtFirstNameNew.Text;
            emp.L_Name = txtlastNameNew.Text;
            emp.Pay_Rate = decimal.Parse(txtPayNew.Text);
            emp.Phone = txtPhoneNew.Text;
            emp.Email = txtEmailNew.Text;
            emp.Emp_Address = txtAddressNew.Text;
            emp.Emp_User_Name = txtUsernameNew.Text;
            emp.Emp_Password = txtPasswordNew.Text;
            dde.Employees.Add(emp);
            dde.SaveChanges();
            lvEmployees.DataSource = dde.Employees.OrderBy(t => t.L_Name).ToList();
            lvEmployees.DataBind();
        }
        #endregion

        #region Promotions


        protected void lvPromos_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblPromo_ID = (Label)item.FindControl("lblPromo_ID");
                    int id = int.Parse(lblPromo_ID.Text);
                    Promotion emp = dde.Promotions.Find(id);
                    dde.Promotions.Remove(emp);
                    dde.SaveChanges();
                    lvPromos.DataSource = dde.Promotions.OrderBy(t => t.Promo_Description).Where(t => t.Discount_Type != "Reward Claim").ToList();
                    lvPromos.DataBind();
                    break;
            }
        }
        protected void lvPromos_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                Promotion vend = (Promotion)item.DataItem;
                if (vend != null)
                {
                    List<Order> prodInv = dde.Orders.Where(t => t.Promo_ID == vend.Promo_ID).ToList();
                    if (prodInv.Count > 0)
                    {
                        Button btnDelete = (Button)item.FindControl("btnDelete");
                        btnDelete.Visible = false;
                    }
                }
            }
        }
        protected void ddlPromoModify_SelectedIndexChanged(object sender, EventArgs e)
        {
            divPromoModify.Visible = true;
            long id = long.Parse(ddlPromoModify.SelectedValue);
            Promotion promo = dde.Promotions.Find(id);
            tbDiscountModify.Text = promo.Discount.ToString();
            dpBeginDatePickerModifyInput.Value = promo.Begin_Date.ToString();
            dpEndDatePickerModifyInput.Value = promo.End_Date.ToString();
            tbPromDescModify.Text = promo.Promo_Description;

        }

        protected void btnUpdatePromo_Click(object sender, EventArgs e)
        {
            long id = long.Parse(ddlPromoModify.SelectedValue);
            Promotion promo = dde.Promotions.Find(id);
            promo.Discount = decimal.Parse(tbDiscountModify.Text);
            promo.Begin_Date = DateTime.Parse(dpBeginDatePickerModifyInput.Value);
            promo.End_Date = DateTime.Parse(dpEndDatePickerModifyInput.Value);
            promo.Promo_Description = tbPromDescModify.Text;
            dde.SaveChanges();
            lvPromos.DataSource = dde.Promotions.OrderBy(t => t.Promo_Description).Where(t => t.Discount_Type != "Reward Claim").ToList();
            lvPromos.DataBind();
        }

        protected void btnNewPromo_Click(object sender, EventArgs e)
        {
            Promotion promo = new Promotion();
            promo.Discount = decimal.Parse(tbDicountNew.Text);
            promo.Begin_Date = DateTime.Parse(dpBeginDatePickerNewInput.Value).Date;
            promo.End_Date = DateTime.Parse(dpEndDatePickerNewInput.Value).Date;
            promo.Promo_Description = tbPromoDescNew.Text;
            promo.Discount_Type = ddlDiscountTypeNew.SelectedItem.Text;
            dde.Promotions.Add(promo);
            dde.SaveChanges();
            lvPromos.DataSource = dde.Promotions.OrderBy(t => t.Promo_Description).Where(t => t.Discount_Type != "Reward Claim").ToList();
            lvPromos.DataBind();
        }
        #endregion

        #region Vendors

        protected void lvVendors_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblPromo_ID = (Label)item.FindControl("lblPromo_ID");
                    int id = int.Parse(lblPromo_ID.Text);
                    Vendor emp = dde.Vendors.Find(id);
                    dde.Vendors.Remove(emp);
                    dde.SaveChanges();
                    lvVendors.DataSource = dde.Vendors.OrderBy(t => t.Vendor_Name).ToList();
                    lvVendors.DataBind();
                    break;
            }
        }

        protected void btnUpdateVendor_Click(object sender, EventArgs e)
        {
            long id = long.Parse(ddlPromoModify.SelectedValue);
            Vendor vendor = dde.Vendors.Find(id);
            vendor.Vendor_Name = txtVendorNameModify.Text;
            if (txtDiscountVendorModify.Text != "")
            {
                vendor.Discount = decimal.Parse(txtDiscountVendorModify.Text);
            }
            vendor.Vend_Address = txtVendorAddress.Text;
            dde.SaveChanges();
            lvVendors.DataSource = dde.Vendors.OrderBy(t => t.Vendor_Name).ToList();
            lvVendors.DataBind();
        }

        protected void btnAddVendor_Click(object sender, EventArgs e)
        {
            Vendor vendor = new Vendor();
            vendor.Vendor_Name = txtVendorNameNew.Text;
            if (txtVendorDiscountNew.Text != "")
            {
                vendor.Discount = decimal.Parse(txtVendorDiscountNew.Text);
            }
            vendor.Vend_Address = txtVendorAddressNew.Text;
            dde.Vendors.Add(vendor);
            dde.SaveChanges();
            lvVendors.DataSource = dde.Vendors.OrderBy(t => t.Vendor_Name).ToList();
            lvVendors.DataBind();
        }

        protected void ddlVendorModify_SelectedIndexChanged(object sender, EventArgs e)
        {
            divVendorModify.Visible = true;
            long id = long.Parse(ddlPromoModify.SelectedValue);
            Vendor vendor = dde.Vendors.Find(id);
            txtVendorNameModify.Text = vendor.Vendor_Name;
            txtDiscountVendorModify.Text = vendor.Discount.ToString();
            txtVendorAddress.Text = vendor.Vend_Address;
        }

        protected void lvVendors_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                Vendor vend = (Vendor)item.DataItem;
                if (vend != null)
                {
                    List<Inventory_Order> prodInv = dde.Inventory_Order.Where(t => t.Vendor_ID == vend.Vendor_ID).ToList();
                    if (prodInv.Count > 0)
                    {
                        Button btnDelete = (Button)item.FindControl("btnDelete");
                        btnDelete.Visible = false;
                    }
                }
            }
        }




        #endregion

        #region Jobs

        protected void lvJobs_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblPromo_ID = (Label)item.FindControl("lblPromo_ID");
                    int id = int.Parse(lblPromo_ID.Text);
                    Job emp = dde.Jobs.Find(id);
                    dde.Jobs.Remove(emp);
                    dde.SaveChanges();
                    lvJobs.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
                    lvJobs.DataBind();
                    ddlJobsModify.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
                    ddlJobsModify.DataBind();
                    break;
            }
        }

        protected void lvJobs_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                Job vend = (Job)item.DataItem;
                if (vend != null)
                {
                    List<Employee> prodInv = dde.Employees.Where(t => t.Job_ID == vend.Job_ID).ToList();
                    if (prodInv.Count > 0)
                    {
                        Button btnDelete = (Button)item.FindControl("btnDelete");
                        btnDelete.Visible = false;
                    }
                }
            }
        }

        protected void btnAddNewJob_Click(object sender, EventArgs e)
        {
            Job vendor = new Job();
            vendor.Job_Name = tbJobNameNew.Text;
            vendor.Duties = txtJobDutiesNew.Text;
            dde.Jobs.Add(vendor);
            dde.SaveChanges();
            lvJobs.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            lvJobs.DataBind();
            ddlJobsModify.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            ddlJobsModify.DataBind();

        }

        protected void ddlJobsModify_SelectedIndexChanged(object sender, EventArgs e)
        {
            divJobModify.Visible = true;
            long id = long.Parse(ddlJobsModify.SelectedValue);
            Job vendor = dde.Jobs.Find(id);
            txtJobNameModify.Text = vendor.Job_Name;
            txtJobDutiesModify.Text = vendor.Duties;
        }

        protected void btnJobpdate_Click(object sender, EventArgs e)
        {
            long id = long.Parse(ddlJobsModify.SelectedValue);
            Job vendor = dde.Jobs.Find(id);
            vendor.Job_Name = txtJobNameModify.Text;
            vendor.Duties = txtJobDutiesModify.Text;
            dde.SaveChanges();
            lvJobs.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            lvJobs.DataBind();
            ddlJobsModify.DataSource = dde.Jobs.OrderBy(t => t.Job_Name).ToList();
            ddlJobsModify.DataBind();
        }

        #endregion

        #region Schedule
        protected void lvSchedule_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Label lblPromo_ID = (Label)item.FindControl("lblPromo_ID");
                    int id = int.Parse(lblPromo_ID.Text);
                    Schedule emp = dde.Schedules.Find(id);
                    dde.Schedules.Remove(emp);
                    dde.SaveChanges();
                    lvSchedule.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
                    lvSchedule.DataBind();
                    ddlScheduleModify.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
                    ddlScheduleModify.DataBind();
                    break;
            }
        }

        protected void lvSchedule_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                Schedule vend = (Schedule)item.DataItem;
                if (vend != null)
                {
                    List<Employee> prodInv = dde.Employees.Where(t => t.Schedule_ID == vend.Schedule_ID).ToList();
                    if (prodInv.Count > 0)
                    {
                        Button btnDelete = (Button)item.FindControl("btnDelete");
                        btnDelete.Visible = false;
                    }
                }
            }
        }

        protected void btnAddNewSchedule_Click(object sender, EventArgs e)
        {
            Schedule sched = new Schedule();
            sched.Shift_Start = TimeSpan.Parse(txtShiftStartNew.Text);
            sched.Shift_End = TimeSpan.Parse(txtShiftEndNew.Text);
            sched.Monday = cbMondayNew.Checked;
            sched.Tuesday = cbTuesdayNew.Checked;
            sched.Wednesday = cbWednesdayNew.Checked;
            sched.Thursday = cbThursdayNew.Checked;
            sched.Friday = cbFridayNew.Checked;
            sched.Saturday = cbSaturdayNew.Checked;
            sched.Sunday = cbSundayNew.Checked;
            sched.Schedule_Description = txtDescriptionNew.Text;
            dde.Schedules.Add(sched);
            dde.SaveChanges();
            lvSchedule.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            lvSchedule.DataBind();
            ddlScheduleModify.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            ddlScheduleModify.DataBind();
        }

        protected void btnUpdateSchedule_Click(object sender, EventArgs e)
        {
            long id = long.Parse(ddlScheduleModify.SelectedValue);
            Schedule sched = dde.Schedules.Find(id);
            sched.Shift_Start = TimeSpan.Parse(txtShiftStartModify.Text);
            sched.Shift_End = TimeSpan.Parse(txtShiftEndModify.Text);
            sched.Monday = cbMondayModify.Checked;
            sched.Tuesday = cbTuesdayModify.Checked;
            sched.Wednesday = cbWednesdayModify.Checked;
            sched.Thursday = cbThursdayModify.Checked;
            sched.Friday = cbFridayModify.Checked;
            sched.Saturday = cbSaturdayModify.Checked;
            sched.Sunday = cbSundayModify.Checked;
            sched.Schedule_Description = txtDescriptionModify.Text;
            dde.SaveChanges();
            lvSchedule.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            lvSchedule.DataBind();
            ddlScheduleModify.DataSource = dde.Schedules.OrderBy(t => t.Schedule_Description).ToList();
            ddlScheduleModify.DataBind();
        }

        protected void ddlScheduleModify_SelectedIndexChanged(object sender, EventArgs e)
        {
            divScheduleModify.Visible = true;
            long id = long.Parse(ddlScheduleModify.SelectedValue);
            Schedule sched = dde.Schedules.Find(id);
            txtShiftStartModify.Text = sched.Shift_Start.ToString();
            txtShiftEndModify.Text = sched.Shift_End.ToString();
            cbMondayModify.Checked = sched.Monday;
            cbTuesdayModify.Checked = sched.Tuesday;
            cbWednesdayModify.Checked = sched.Wednesday;
            cbThursdayModify.Checked = sched.Thursday;
            cbFridayModify.Checked = sched.Friday;
            cbSaturdayModify.Checked = sched.Saturday;
            cbSundayModify.Checked = sched.Sunday;
            txtDescriptionModify.Text = sched.Schedule_Description;
        }

        #endregion


    }
}