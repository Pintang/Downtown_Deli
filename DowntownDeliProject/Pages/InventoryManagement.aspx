<%@ Page Language="C#" Title="Inventory Management" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="InventoryManagement.aspx.cs" Inherits="DowntownDeliProject.Pages.InventoryManagement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-2">
            <button class="btn btn-primary" onclick="OpenModal('AddNewModal'); return false;">Add New Inventory Item</button>
        </div>
        <div class="col-md-2">
            <button class="btn btn-info" onclick="OpenModal('UpdateModal'); return false;">Add/Delete From Inventory</button>
        </div>
    </div>
    <div class="row pad-top" style="border: thin">
        <div class="col-md-12" style="border: thin">
            <asp:ListView runat="server" ID="lvInventoryItems" ItemPlaceholderID="lvItemPlaceHolder">
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
                    <h5 class="modal-title">Add/Delete From Inventory</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row pad-top">
                                <div class="col-md-3">
                                    <asp:Label runat="server" Font-Bold="true" Text="Add/Delete From Inventory:" />
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
                                    <asp:TextBox ID="tbQuantity" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-2">
                            <asp:Button runat="server" CssClass="btn btn-success" OnClick="btnUpdate_Click" Text="Submit Order" ID="btnUpdate" />
                        </div>
                        <div class="col-md-2">
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
                        <div class="col-md-12">
                            <div class="row pad-top">
                                <div class="col-md-3">
                                    <asp:Label runat="server" Font-Bold="true" Text="Inventory Item Name:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="tbItemName" runat="server" CssClass="form-control" Width="100%" />

                                </div>
                            </div>
                            <div class="row pad-top">
                                <div class="col-md-3">
                                    <asp:Label runat="server" Font-Bold="true" Text="Quantity:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                            <div class="row pad-top">
                                <div class="col-md-3">
                                    <asp:Label runat="server" Font-Bold="true" Text="Expiration Date:" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Width="100%" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-2">
                            <asp:Button runat="server" CssClass="btn btn-success" OnClick="btnAddNew_Click" Text="Submit Order" ID="btnAddNew" />
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
