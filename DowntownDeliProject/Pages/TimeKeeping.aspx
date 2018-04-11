<%@ Page Language="C#" Title="Time Keeping" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeKeeping.aspx.cs" Inherits="DowntownDeliProject.Pages.TimeKeeping" %>

<asp:content id="BodyContent" contentplaceholderid="Body" runat="server">
  

<div class="row pad-top">
    <div class="col-md-8">
         <asp:Label runat="server" AssociatedControlID="Username" CssClass="col-md-2 control-label">Username</asp:Label>
        <asp:TextBox runat="server" ID="Username" CssClass="form-control" />
          
    </div>
</div>
     <div class="row pad-top">
         <div class="col-md-8">
           <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
             
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                        </div>
             </div>
              <div class="row pad-top">
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
      <div class="row pad-top" style="border: thin">
                        <div class="col-md-12" style="border: thin">
                            <asp:ListView runat="server" ID="DisplayTimeSheet">
                                <ItemTemplate>
                                    <div class="row" style="background-color: #D3D3D3;">
                                        <div class="col-md-12">
                                            <div class="row pad">   
                                                 List<Empworktime>                                   
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                              
                            </asp:ListView>
                        </div>
                    </div>

    
</asp:content>
