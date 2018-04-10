<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="CurrentOrdersSideNav.aspx.cs" Inherits="DowntownDeliProject.Pages.CurrentOrdersSideNav" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="sideNav" runat="server">
    <div class="row">
        <asp:ListView runat="server" ID="lvCurrentOrders">
            <ItemTemplate>
                <div class="row" style="background-color: #D3D3D3;">
                    <div class="col-md-12">
                        <div class="row pad">
                            <div class="col-md-4">
                                <asp:Label runat="server" ID="lblOrderID" Text='<%# Bind("Order_ID") %>' />
                            </div>
                            <div class="col-md-4">
                                <asp:Label runat="server" ID="lblCustomer" Text='<%# Bind("Order.Customers.FName") + " " +  Bind("Order.Customers.LName") %>' />
                            </div>
                            <div class="col-md-2">
                                <asp:Label runat="server" ID="lblPrice" Text='<%# Bind("Price") %>' />
                            </div>
                            <div class="col-md-2">
                                <asp:Label runat="server" ID="lblOrderDate" Text='<%# Bind("Ord_Date") %>' />
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
                                <asp:Label runat="server" ID="lblOrderID" Text='<%# Bind("Order_ID") %>' />
                            </div>
                            <div class="col-md-4">
                                <asp:Label runat="server" ID="lblCustomer" Text='<%# Bind("Order.Customers.FName") + " " +  Bind("Order.Customers.LName") %>' />
                            </div>
                            <div class="col-md-2">
                                <asp:Label runat="server" ID="lblPrice" Text='<%# Bind("Price") %>' />
                            </div>
                            <div class="col-md-2">
                                <asp:Label runat="server" ID="lblOrderDate" Text='<%# Bind("Ord_Date") %>' />
                            </div>
                        </div>
                    </div>
                </div>
            </AlternatingItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
