<%@ Page Language="C#" Title="Report Manager" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="DowntownDeliProject.Pages.Reports" %>

<asp:content id="BodyContent" contentplaceholderid="Body" runat="server">
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
                           <asp:DropDownList runat="server" ToolTip="Select a Report From the list" CssClass="form-control" Width="100%" ID="ddlProducts">
                               <asp:ListItem Text=""></asp:ListItem>
                               <asp:ListItem Text="Inventory"></asp:ListItem>
                               <asp:ListItem Text="Timekeeping"></asp:ListItem>
                               <asp:ListItem Text="Sales"></asp:ListItem>
                               
                            </asp:DropDownList>

                        </div>
                     </div>
                    </div>
                  </div>
             </div>
        </div>
                    
</asp:content>

