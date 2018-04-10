<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlaceOrder.aspx.cs" Inherits="DowntownDeliProject.Pages.PlaceOrder" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <div class="row pad-bottom">
                        <div class="col-md-12">
                            <div class="row text-center" style="display: none;">
                                <div class="col-md-6">
                                    <asp:CheckBox ID="cbDineIn" Text="Dine-In" runat="server" CssClass="checkbox-inline" />
                                </div>
                                <div class="col-md-6">
                                    <asp:CheckBox ID="cbCarryOut" Text="Carry-Out" runat="server" CssClass="checkbox-inline" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true" Text="Customer ID / Phone Number" />
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" CssClass="form-control" OnTextChanged="txtCustomer_TextChanged" AutoPostBack="true" Width="100%" ID="txtCustomer" />

                        </div>
                    </div>
                    <div class="row pad-top col-md-offset-5">
                        <asp:Label runat="server" ID="lblCustomer" Font-Bold="true" Text="" />
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true" Text="Product Search:" />
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList runat="server" ToolTip="Select a Product From the list" DataTextField="Product_Name" CssClass="form-control" Width="100%" DataValueField="Product_ID" ID="ddlProducts">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-12 col-md-offset-4">
                            <asp:CheckBox ID="cbCombo" Text="Make it a Combo?" runat="server" CssClass="checkbox-inline" />
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true" Text="Quantity:" />
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="tbQuantity" runat="server" CssClass="form-control" Width="100%" />
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Button runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" Text="Add To Order" ID="btnAdd" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true" Text="Add a Promo:" />
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList runat="server" ToolTip="Select a Promo From the list" DataTextField="Discount_Type" CssClass="form-control" Width="100%" DataValueField="Promo_ID" ID="ddlPromos">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row pad-top" style="border: thin">
                        <div class="col-md-12" style="border: thin">
                            <asp:ListView runat="server" ID="lvOrderItems" OnItemDataBound="lvOrderItems_ItemDataBound">
                                <ItemTemplate>
                                    <div class="row" style="background-color: #D3D3D3;">
                                        <div class="col-md-12">
                                            <div class="row pad">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" ID="lblProdName" Text='' />
                                                </div>
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" ID="lblPrice" Text='' />
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblQuantity" Text='' />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </ItemTemplate>
                                <AlternatingItemTemplate>
                                    <div class="row" style="background-color: white;">
                                        <div class="col-md-12">
                                            <div class="row pad">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" ID="lblProdName" Text='' />
                                                </div>
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" ID="lblPrice" Text='' />
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblQuantity" Text='' />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </AlternatingItemTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            <asp:Label runat="server" Text="Subtotal:" />
                        </div>
                        <div class="col-md-4">
                            <asp:Label runat="server" ID="lblSubTotal" Text="" />
                        </div>
                        <div class="col-md-2">
                            <asp:Label runat="server" Text="Total:" />
                        </div>
                        <div class="col-md-4">
                            <asp:Label runat="server" ID="lblTotal" Text="" />
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-12">
                            <asp:Button runat="server" CssClass="btn btn-success" OnClick="btnSubmitOrder_Click" Text="Submit Order" ID="btnSubmitOrder" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

