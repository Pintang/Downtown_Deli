<%@ Page Language="C#" Title="Inventory Management" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="InventoryManagement.aspx.cs" Inherits="DowntownDeliProject.Pages.InventoryManagement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-2">
            <button class="btn btn-primary" onclick="OpenModal('AddNewModal'); return false;">Add New Inventory Item</button>
        </div>
        <div class="col-md-2">
            <button class="btn btn-info" onclick="OpenModal('UpdateModal'); return false;">Modify Quantity</button>
        </div>
        <div class="col-md-2">
            <button class="btn btn-warning" onclick="OpenModal('OrderMoreModal'); return false;">Order More Inventory</button>
        </div>
    </div>
    <div class="row pad-top" style="border: thin">
        <div class="col-md-12" style="border: thin">
            <asp:ListView runat="server" ID="lvInventoryItems" OnItemDataBound="lvInventoryItems_ItemDataBound" OnItemCommand="lvInventoryItems_ItemCommand" OnPagePropertiesChanging="lvCurrentOrders_PagePropertiesChanging" ItemPlaceholderID="lvItemPlaceHolder">
                <LayoutTemplate>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row pad">
                                <div class="col-md-3">
                                    <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" ID="lblQuant" Font-Bold="true" Text='Quantity' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" ID="lblCost" Font-Bold="true" Text='Cost' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" ID="Label1" Font-Bold="true" Text='Exp. Date' />
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
                            <asp:DataPager ID="lvInventoryItemsPager" runat="server" PagedControlID="lvInventoryItems" PageSize="15">
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
                                <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Quantity") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Cost") %>' />
                                </div>
                                <div class="col-md-2">
                                    <asp:Label runat="server" Text='<%# DateTime.Parse(Eval("Experation_Date").ToString()).ToString("MM/dd/yyyy") %>' />
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
                                <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Quantity") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Cost") %>' />
                                </div>
                                <div class="col-md-2">
                                    <asp:Label runat="server" Text='<%# DateTime.Parse(Eval("Experation_Date").ToString()).ToString("MM/dd/yyyy") %>' />
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
    <div class="modal" tabindex="-1" id="UpdateModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Quantity</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <asp:Label ID="lblErrorModify" ForeColor="Red" runat="server" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row pad-top">
                                <div class="col-md-3">
                                    <asp:Label runat="server" Font-Bold="true" Text="Inventory Item:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:DropDownList runat="server" ToolTip="Select an Iventory Item From the list" DataTextField="Item_Name" CssClass="form-control" Width="100%" DataValueField="Item_ID" ID="ddlInventory">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row pad-top">
                                <div class="col-md-3">
                                    <asp:Label runat="server" Font-Bold="true" Text="Quantity:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="tbQuantity" oncopy="return false" oncut="return false" onpaste="return false" onkeypress="return isNumberKey(event);" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button class="btn btn-success" onclick="ValidateModifyInventory(); return false;">Update</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" OnClick="btnUpdate_Click" ID="btnUpdate" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="AddNewModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Inventory Item</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <asp:Label ID="lblErrorAddNewModal" ForeColor="Red" runat="server" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row pad-top">
                                <div class="col-md-4">
                                    <asp:Label runat="server" Font-Bold="true" Text="Inventory Item Name:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="tbItemName" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                            <div class="row pad-top">
                                <div class="col-md-4">
                                    <asp:Label runat="server" Font-Bold="true" Text="Quantity:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="tbNewQuantity" oncopy="return false" oncut="return false" onpaste="return false" onkeypress="return isNumberKey(event);" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                            <div class="row pad-top">
                                <div class="col-md-4">
                                    <asp:Label runat="server" Font-Bold="true" Text="Cost:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="tbCost" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                            <div class="row pad-top">
                                <div class="col-md-4">
                                    <asp:Label runat="server" Font-Bold="true" Text="Expiration Date:" />
                                </div>
                                <div class="col-md-6">
                                    <div class="row pad-top">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <div class='input-group date' id='ExpDateTimePicker'>
                                                    <input type='text' runat="server" id="ExpDateTimePickerInput" class="form-control" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button class="btn btn-success" onclick="ValidateNewInventory(); return false;">Create</button>
                            <asp:Button runat="server" CssClass="hidden" OnClick="btnAddNew_Click" ID="btnAddNew" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="OrderMoreModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Order Inventory</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <asp:Label ID="lblErrorOrderInv" ForeColor="Red" runat="server" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:ListView runat="server" ID="lvOrderInventoryItems" OnPagePropertiesChanging="lvOrderInventoryItems_PagePropertiesChanging" ItemPlaceholderID="lvItemPlaceHolder">
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
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:DataPager ID="lvOrderInventoryItemsPager" runat="server" PagedControlID="lvInventoryItems" PageSize="10">
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
                                                <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                <div class="col-md-3">
                                                    <asp:CheckBox ID="cbAddToOrder" runat="server" CssClass="checkbox-inline" />
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
                                                    <asp:CheckBox ID="cbAddToOrder" runat="server" CssClass="checkbox-inline" />
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
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true" Text="Select a Vendor:" />
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList runat="server" ToolTip="Select a Vendor From the list" DataTextField="Vendor_Name" CssClass="form-control" Width="100%" DataValueField="Vendor_ID" ID="ddlVendors">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Order" OnClick="btnOrder_Click" ID="btnOrder" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="FailureModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Failure!</h5>
                </div>
                <div class="modal-body">
                    <p>The order was not sent because no items where checked.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="SuccessModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Success!</h5>
                </div>
                <div class="modal-body">
                    <p>The order has been proccessed and will be delivered soon. You're inventory was updated.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
