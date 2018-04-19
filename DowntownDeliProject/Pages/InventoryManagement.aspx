<%@ Page Language="C#" Title="Inventory Management" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="InventoryManagement.aspx.cs" Inherits="DowntownDeliProject.Pages.InventoryManagement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-2">
            <button class="btn btn-primary" onclick="OpenModal('AddNewModal'); return false;">Add New Inventory Item</button>
        </div>
        <div class="col-md-2">
            <button class="btn btn-info" onclick="OpenModal('UpdateModal'); return false;">Modify Quantity</button>
        </div>
    </div>
    <div class="row pad-top" style="border: thin">
        <div class="col-md-12" style="border: thin">
            <asp:ListView runat="server" ID="lvInventoryItems" OnPagePropertiesChanging="lvCurrentOrders_PagePropertiesChanging" ItemPlaceholderID="lvItemPlaceHolder">
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
                                <asp:Label runat="server" ID="lblItemID" Visible="false" />
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Quantity") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Cost") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# DateTime.Parse(Eval("Experation_Date").ToString()).ToString("MM/dd/yyyy") %>' />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <div class="row" style="background-color: white;">
                        <div class="col-md-12">
                            <div class="row pad">
                                <asp:Label runat="server" ID="lblItemID" Visible="false" />
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Quantity") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# Eval("Cost") %>' />
                                </div>
                                <div class="col-md-3">
                                    <asp:Label runat="server" Text='<%# DateTime.Parse(Eval("Experation_Date").ToString()).ToString("MM/dd/yyyy") %>' />
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
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <div class='input-group date' id='ExpDateTimePicker'>
                                                    <input type='text' class="form-control" />
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
</asp:Content>
