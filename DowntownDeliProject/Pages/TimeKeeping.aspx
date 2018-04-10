<%@ Page Language="C#" Title="Time Keeping" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeKeeping.aspx.cs" Inherits="DowntownDeliProject.Pages.TimeKeeping" %>

<asp:content id="BodyContent" contentplaceholderid="Body" runat="server">
   <div class="row">
    <div class="col-md-3">
        <asp:Button runat="server" CssClass="btn btn-primary" Text="Clock in" ID="btnClockIn" />
    </div>
    <div class="col-md-3">
        <asp:Button runat="server" CssClass="btn btn-primary" Text="Clock out" ID="btnClockOut" />
    </div>
    <div class="col-md-3">
        <asp:Button runat="server" CssClass="btn btn-primary" Text="View timesheet" ID="btnViewTimesheet" />
    </div>
</div>

<div class="row pad-top">
    <div class="col-md-8">
         <asp:Label runat="server" AssociatedControlID="Username" CssClass="col-md-2 control-label">Username</asp:Label>
        <asp:TextBox runat="server" ID="Username" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="Username"
            CssClass="text-danger" ErrorMessage="The Username field is required." />
    </div>
</div>
     <div class="row pad-top">
         <div class="col-md-8">
           <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
             
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
             </div>
                    


    
</asp:content>
