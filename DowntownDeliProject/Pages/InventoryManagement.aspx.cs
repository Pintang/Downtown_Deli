using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DowntownDeliProject.Pages
{
    public partial class InventoryManagement : System.Web.UI.Page
    {
        protected Employee user
        {
            get { return (Employee)Session["user"]; }
            set { Session["user"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (user != null)
            {
                if (user.Job_ID != 1 && user.Job_ID != 4)
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
            if (!Page.IsPostBack)
            {
                using (DowntownDeliEntity dde = new DowntownDeliEntity())
                {
                    lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                    lvInventoryItems.DataBind();
                    ddlInventory.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                    ddlInventory.DataBind();
                    lvOrderInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).Where(t => t.Quantity <= 25).ToList();
                    lvOrderInventoryItems.DataBind();
                    ddlVendors.DataSource = dde.Vendors.OrderBy(t => t.Vendor_Name).ToList();
                    ddlVendors.DataBind();
                }
            }
            if (System.Web.HttpContext.Current.User == null || !System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Clear();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx");
            }
        }
        protected void lvCurrentOrders_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {

                DataPager lvInventoryItemsPager = lvInventoryItems.FindControl("lvInventoryItemsPager") as DataPager;
                int CurrentPage = ((lvInventoryItemsPager.StartRowIndex) / lvInventoryItemsPager.MaximumRows) + 1;
                lvInventoryItemsPager.SetPageProperties(lvInventoryItemsPager.StartRowIndex, lvInventoryItemsPager.MaximumRows, false);
                lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                lvInventoryItems.DataBind();
            }
        }
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {
                Inventory invItem = new Inventory();
                invItem.Item_Name = tbItemName.Text;
                invItem.Quantity = int.Parse(tbNewQuantity.Text);
                invItem.Cost = decimal.Parse(tbCost.Text);
                invItem.Experation_Date = DateTime.Parse(ExpDateTimePickerInput.Value);
                dde.Inventories.Add(invItem);
                dde.SaveChanges();
                lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                lvInventoryItems.DataBind();
                ddlInventory.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                ddlInventory.DataBind();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {
                int item = int.Parse(ddlInventory.SelectedValue);
                int quantity = int.Parse(tbQuantity.Text);
                Inventory invItem = dde.Inventories.FirstOrDefault(a => a.Item_ID == item);
                if (invItem != null)
                {
                    invItem.Quantity = quantity;
                    dde.SaveChanges();
                }
                lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                lvInventoryItems.DataBind();
                ddlInventory.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                ddlInventory.DataBind();

            }

        }

        protected void lvInventoryItems_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item is ListViewDataItem)
            {
                using (DowntownDeliEntity dde = new DowntownDeliEntity())
                {
                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    Inventory invItem = (Inventory)item.DataItem;
                    Button btnDelete = (Button)item.FindControl("btnDelete");
                    if (invItem.Product_Inventory.Count > 0)
                    {
                        btnDelete.Visible = false;
                    }
                }
            }
        }

        protected void lvInventoryItems_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "DeleteCommand":
                    using (DowntownDeliEntity dde = new DowntownDeliEntity())
                    {
                        ListViewDataItem item = (ListViewDataItem)e.Item;
                        Label lblItemID = (Label)item.FindControl("lblItemID");
                        int id = int.Parse(lblItemID.Text);
                        Inventory invItem = dde.Inventories.Find(id);
                        dde.Inventories.Remove(invItem);
                        dde.SaveChanges();
                        lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                        lvInventoryItems.DataBind();
                    }
                    break;
            }
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {
                List<Inventory> listofItems = new List<Inventory>();
                foreach (ListViewDataItem item in lvOrderInventoryItems.Items)
                {
                    CheckBox cbAddToOrder = (CheckBox)item.FindControl("cbAddToOrder");
                    if (cbAddToOrder.Checked)
                    {
                        Label lblItemID = (Label)item.FindControl("lblItemID");
                        int id = int.Parse(lblItemID.Text);
                        Inventory invItem = dde.Inventories.Find(id);
                        if (invItem != null)
                        {
                            listofItems.Add(invItem);
                        }
                    }

                }
                if (listofItems.Count > 0)
                {
                    foreach (Inventory inv in listofItems)
                    {
                        Inventory_Order invOrder = new Inventory_Order();
                        invOrder.Item_ID = inv.Item_ID;
                        invOrder.Vendor_ID = int.Parse(ddlVendors.SelectedValue);
                        invOrder.Quantity = 50;
                        invOrder.Total_Cost = (inv.Cost * 50) + ((inv.Cost * 50) * .0675M);
                        invOrder.Purchase_Date = DateTime.Now;
                        invOrder.Delivery_Date = DateTime.Now.AddDays(5);
                        dde.Inventory_Order.Add(invOrder);
                        Inventory invItem = dde.Inventories.Find(inv.Item_ID);
                        invItem.Quantity += 50;
                        dde.SaveChanges();
                        lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                        lvInventoryItems.DataBind();
                        lvOrderInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).Where(t => t.Quantity <= 25).ToList();
                        lvOrderInventoryItems.DataBind();

                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "OpenModal('SuccessModal')", true);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "OpenModal('FailureModal')", true);
                }
            }
        }

        protected void lvOrderInventoryItems_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            using (DowntownDeliEntity dde = new DowntownDeliEntity())
            {

                DataPager lvOrderInventoryItemsPager = lvInventoryItems.FindControl("lvOrderInventoryItemsPager") as DataPager;
                int CurrentPage = ((lvOrderInventoryItemsPager.StartRowIndex) / lvOrderInventoryItemsPager.MaximumRows) + 1;
                lvOrderInventoryItemsPager.SetPageProperties(lvOrderInventoryItemsPager.StartRowIndex, lvOrderInventoryItemsPager.MaximumRows, false);
                lvOrderInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).Where(t => t.Quantity <= 25).ToList();
                lvOrderInventoryItems.DataBind();
            }
        }
    }
}