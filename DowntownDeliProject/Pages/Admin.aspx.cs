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
        }

        protected void btnPromotions_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = true;
            VendorDiv.Visible = false;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = false;
        }

        protected void btnVendors_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = true;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = false;
        }

        protected void btnJobs_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = false;
            JobsDiv.Visible = true;
            ScheduleDiv.Visible = false;
        }

        protected void btnSchedule_Click(object sender, EventArgs e)
        {

            MenuDiv.Visible = false;
            EmployeeDiv.Visible = false;
            PromoDiv.Visible = false;
            VendorDiv.Visible = false;
            JobsDiv.Visible = false;
            ScheduleDiv.Visible = true;
        }

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
                    int id2= int.Parse(lblItemID.Text);
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
            txtMenuItemPrice.Text = prod.Price.ToString();
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
    }
}