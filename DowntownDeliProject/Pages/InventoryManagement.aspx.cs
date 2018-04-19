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
            if (!Page.IsPostBack)
            {
                using (DowntownDeliEntity dde = new DowntownDeliEntity())
                {
                    lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                    lvInventoryItems.DataBind();
                    ddlInventory.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                    ddlInventory.DataBind();
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
                invItem.Quantity = int.Parse(tbQuantity.Text);
                //invItem.Experation_Date = DateTime.Parse(tbDateTimePicker.Value);
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
    }
}