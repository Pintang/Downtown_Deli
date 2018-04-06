<%@ Page Language="C#" Title="system Admin" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="DowntownDeliProject.Pages.Admin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-3">
            <asp:Button runat="server" CssClass="btn btn-primary" Text="Add/Remove Menu Item" ID="btnAddMenuItem" />
        </div>
        <div class="col-md-3">
            <asp:Button runat="server" CssClass="btn btn-primary" Text="Add/Remove Employee" ID="btnEmployee" />
        </div>
        <div class="col-md-3">
            <asp:Button runat="server" CssClass="btn btn-primary" Text="Add/Remove Inventory" ID="btnInventory" />
        </div>
    </div>
</asp:Content>
