<%@ Page Language="C#" Title="System Admin" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="DowntownDeliProject.Pages.Admin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-primary" Width="100%" OnClick="btnMenuItems_Click" Text="Menu Items" ID="btnMenuItems" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-success" Width="100%" OnClick="btnEmployees_Click" Text="Employees" ID="btnEmployees" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-danger" Width="100%" OnClick="btnPromotions_Click" Text="Promotions" ID="btnPromotions" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-info" Width="100%" OnClick="btnVendors_Click" Text="Vendors" ID="btnVendors" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-default" Width="100%" OnClick="btnJobs_Click" Text="Jobs" ID="btnJobs" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-warning" Width="100%" OnClick="btnSchedule_Click" Text="Schedule" ID="btnSchedule" />
                </div>
            </div>
            <div runat="server" visible="false" id="MenuDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewMenuItemModal'); return false;">Add New Menu Item</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdateMenuItemModal'); return false;">Modify Menu Item</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvMenuItems" OnItemCommand="lvMenuItems_ItemCommand" OnPagePropertiesChanging="lvMenuItems_PagePropertiesChanging" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblCost" Font-Bold="true" Text='Cost' />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:PlaceHolder runat="server" ID="lvItemPlaceHolder" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:DataPager ID="lvMenuItemsPager" runat="server" PagedControlID="lvMenuItems" PageSize="15">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn" FirstPageText="Prev" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                                    ShowNextPageButton="false" />
                                                <asp:NumericPagerField ButtonType="Button" />
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn" FirstPageText="Next" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton="false" />
                                            </Fields>
                                        </asp:DataPager>
                                    </div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Product_ID") %>' Visible="false" />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Product_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Price") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Product_ID") %>' Visible="false" />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Product_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Price") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
            <div runat="server" visible="false" id="EmployeeDiv" class="row pad-top">
            </div>
            <div runat="server" visible="false" id="PromoDiv" class="row pad-top">
            </div>
            <div runat="server" visible="false" id="VendorDiv" class="row pad-top">
            </div>
            <div runat="server" visible="false" id="JobsDiv" class="row pad-top">
            </div>
            <div runat="server" visible="false" id="ScheduleDiv" class="row pad-top">
            </div>
        </div>
    </div>
    <%-- Modals --%>
    <div class="modal" tabindex="-1" id="AddNewMenuItemModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Menu Item</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="Label1" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Product Name:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbMenuItemNameNew" />
                                        </div>
                                    </div>
                                    <div runat="server" id="Div1" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Price:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbNewMenuPrice" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <asp:ListView runat="server" ID="lvNewInventory" ItemPlaceholderID="lvItemPlaceHolder">
                                                        <LayoutTemplate>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="Label2" Font-Bold="true" Text='Include in Order' />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <asp:PlaceHolder runat="server" ID="lvItemPlaceHolder" />
                                                                </div>
                                                            </div>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <div class="row" style="background-color: #D3D3D3;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <div class="row" style="background-color: white;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </AlternatingItemTemplate>
                                                    </asp:ListView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Add" OnClick="btnAddNewMenuItem_Click" ID="btnAddNewMenuItem" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdateMenuItemModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Menu Item</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblErrorOrderInv" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Product:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select a Product From the list" OnSelectedIndexChanged="ddlMenuItemProducts_SelectedIndexChanged" AutoPostBack="true" DataTextField="Product_Name" CssClass="form-control" Width="100%" DataValueField="Product_ID" ID="ddlMenuItemProducts">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="MenuItemUpdateDiv" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Price:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtMenuItemPrice" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <asp:ListView runat="server" ID="lvInventoryItems" OnItemDataBound="lvInventoryItems_ItemDataBound" ItemPlaceholderID="lvItemPlaceHolder">
                                                        <LayoutTemplate>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="Label2" Font-Bold="true" Text='Include in Order' />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <asp:PlaceHolder runat="server" ID="lvItemPlaceHolder" />
                                                                </div>
                                                            </div>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <div class="row" style="background-color: #D3D3D3;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <div class="row" style="background-color: white;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </AlternatingItemTemplate>
                                                    </asp:ListView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdateMenuItem_Click" ID="btnUpdateMenuItem" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
