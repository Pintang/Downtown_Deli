<%@ Page Language="C#" Title="Inventory Management" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="InventoryManagement.aspx.cs" Inherits="DowntownDeliProject.Pages.InventoryManagement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-12">

        </div>
    </div>
        <div class="col-md-3">
            <asp:Button runat="server" CssClass="btn btn-primary" OnClick="Generate_Report" Text="Generate Report" ID="GenReport" />
        
                </div>
            
</asp:Content>
