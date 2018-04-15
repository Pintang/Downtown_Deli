<%@ Page Language="C#" Title="Report Manager" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="DowntownDeliProject.Pages.Reports" %>

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
                                <asp:ListItem Text="Inventory"></asp:ListItem>
                                <asp:ListItem Text="Timekeeping"></asp:ListItem>
                                <asp:ListItem Text="Sales"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row pad-top" runat="server" id="DivDatePicker" visible="false">
                        <div class="col-md-8">
                            <div class="input-group date" data-provide="datepicker">
                                <input type="text" class="form-control">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row pad-top">
                <div class="col-md-8">
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Generate Report" ID="Button1" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>

