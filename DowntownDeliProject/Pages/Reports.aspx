﻿<%@ Page Language="C#" Title="Report Manager" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="DowntownDeliProject.Pages.Reports" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <div class="row pad-bottom">
                        <div class="col-md-12">
                            <div class="row text-center">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <asp:Label runat="server" Font-Bold="true" Text="Please select a report option from the dropdown menu" />
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-8">
                            <asp:DropDownList OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged" runat="server" AutoPostBack="true" ToolTip="Select a Report From the list" CssClass="form-control" Width="100%" ID="ddlProducts">
                                <asp:ListItem Text=""></asp:ListItem>
                                <asp:ListItem Text="Timekeeping"></asp:ListItem>
                                <asp:ListItem Text="Sales"></asp:ListItem>
                                <asp:ListItem Text="Top Selling Item"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row pad-top" runat="server" id="DivDatePicker1" visible="false">
                        <%-- Start Date --%>
                        <div class="col-md-8">
                            <asp:Label runat="server" Font-Bold="true" Text="Please select a Start Date" />
                            <div class="form-group">
                                <div class='input-group date' id='StartDateDatePickerReports'>
                                    <input type='text' runat="server" id="StartDateDatePickerReportsInput" class="form-control" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row pad-top" runat="server" id="DivDatePicker2" visible="false">
                        <%-- End Date --%>
                        <div class="col-md-8">
                            <asp:Label runat="server" Font-Bold="true" Text="Please select an End Date" />
                            <div class="form-group">
                                <div class='input-group date' id='StopDateDatePickerReports'>
                                    <input type='text' runat="server" id="StopDateDatePickerReportsInput" class="form-control" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row pad-top">
                            <div class="col-md-3">
                                <asp:Button runat="server" CssClass="btn btn-primary" OnClick="Generate_Report" Text="Generate Report" ID="GenReport" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <asp:Literal ID="Data" runat="server"></asp:Literal>
    </div>
</asp:Content>

