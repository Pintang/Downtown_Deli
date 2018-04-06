<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="DowntownDeliProject.Pages.Order" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <div class="row pad-bottom">
                        <div class="col-md-12">
                            <div class="row text-center">
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
                            <asp:ListView runat="server" ID="lvIDs">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" CssClass="label" ID="lbl34" Text='<%# Eval("Customer_ID") %>' />
                                        </div>
                                        <div class="col-md-4">
                                            <asp:Label runat="server" ID="Label2" CssClass="label" Text='<%# Eval("Customer_Name") %>' />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
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
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true" Text="Quantity:" />
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="tbQuantity" runat="server" CssClass="form-control" Width="100%" />
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Add To Order" ID="btnAdd" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <asp:Label ID="CustomerName" runat="server" Visible="false" CssClass="label label-info btn-lg" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:ListView runat="server" ID="lvOrderItems" OnItemDataBound="lvOrderItems_ItemDataBound">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" CssClass="label" ID="lbl34" Text='<%# Eval("Product_Name") %>' />
                                        </div>
                                        <div class="col-md-4">
                                            <asp:Label runat="server" ID="Label1" CssClass="label" Text='<%# "$" + (decimal.Parse(Eval("Price").ToString()) * int.Parse(Eval("Quantity").ToString()) )%>' />
                                        </div>
                                        <div class="col-md-4">
                                            <asp:Label runat="server" ID="Label2" CssClass="label" Text='<%# Eval("Quantity") %>' />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" CssClass="btn btn-success" OnClick="btnSubmitOrder_Click" Text="Submit Order" ID="btnSubmitOrder" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

