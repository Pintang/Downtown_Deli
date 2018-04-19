<%@ Page Language="C#" Title="Time Keeping" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeKeeping.aspx.cs" Inherits="DowntownDeliProject.Pages.TimeKeeping" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">

    <div class="row">
        <asp:Label ID="lblError" ForeColor="Red" Visible="false" runat="server" />
    </div>
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
            <asp:Button runat="server" CssClass="btn btn-primary" OnClick="btnClockIn_Click" Text="Clock in" ID="btnClockIn" />
        </div>
        <div class="col-md-3">
            <asp:Button runat="server" CssClass="btn btn-primary" OnClick="btnClockOut_Click" Text="Clock out" ID="btnClockOut" />
        </div>
        <div class="col-md-3">
            <asp:Button runat="server" CssClass="btn btn-primary" Text="View timesheet" OnClick="btnViewTimesheet_Click" ID="btnViewTimesheet" />
        </div>
    </div>
    <div class="row pad-top">
        <div class="col-md-12">
            <asp:ListView runat="server" ID="lvDisplayTimeSheet">
                <ItemTemplate>
                    <div class="row" style="background-color: #D3D3D3;">
                        <div class="col-md-12">
                            <div class="row pad">
                                <LayoutTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row pad">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" ID="Label1" Font-Bold="true" Text='Date' />
                                                </div>
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" ID="lblPrice" Font-Bold="true" Text='Clock In' />
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblQuantity" Font-Bold="true" Text='Clock Out' />
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
                                <div class="col-md-4">
                                    <asp:Label runat="server"  ID="lblProdName" Text='<%# DateTime.Parse(Eval("Work_Date").ToString()).ToString("MM/dd/yyyy") %>' />
                                </div>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="ClockIn" Text='<%# Eval("Clock_In") %>' />
                                </div>
                                <div class="col-md-2">
                                    <asp:Label runat="server" ID="ClockOut" Text='<%# Eval("Clock_Out") %>' />
                                </div>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <div class="row" style="background-color: white;">
                        <div class="col-md-12">
                            <asp:PlaceHolder runat="server" ID="lvItemPlaceHolder" />
                            <div class="row pad">
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="WorkDate" Text='<%# DateTime.Parse(Eval("Work_Date").ToString()).ToString("MM/dd/yyyy") %>' />
                                </div>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="ClockIn" Text='<%# Eval("Clock_In") %>' />
                                </div>
                                <div class="col-md-2">
                                    <asp:Label runat="server" ID="ClockOut" Text='<%# Eval("Clock_Out") %>' />
                                </div>
                            </div>
                        </div>
                    </div>
                </AlternatingItemTemplate>
            </asp:ListView>
        </div>
    </div>



</asp:Content>
