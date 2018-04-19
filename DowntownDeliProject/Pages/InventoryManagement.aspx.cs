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
        DowntownDeliEntity dde = new DowntownDeliEntity();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lvInventoryItems.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                lvInventoryItems.DataBind();
                ddlInventory.DataSource = dde.Inventories.OrderBy(t => t.Item_Name).ToList();
                ddlInventory.DataBind();
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
            Inventory invItem = new Inventory();
            invItem.Item_Name = tbItemName.Text;
            invItem.Quantity = int.Parse(tbQuantity.Text);
            //invItem.Experation_Date = DateTime.Parse(tbDateTimePicker.Value);
            dde.Inventories.Add(invItem);
            dde.SaveChanges();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Inventory invItem = dde.Inventories.Find(int.Parse(ddlInventory.SelectedValue));
            if (invItem != null)
            {
                invItem.Quantity = invItem.Quantity +  int.Parse(tbQuantity.Text);
                dde.SaveChanges();
            }
        }
    }
}