﻿<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="DowntownDeliProject.Pages.Order" %>

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
                        <div class="col-md-3">
                            <asp:Label runat="server" Font-Bold="true" Text="Customer ID" />
                        </div>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" CssClass="form-control" OnTextChanged="txtCustomer_TextChanged" Width="100%" ID="txtCustomer" />
                        </div>
                    </div>
                    <div class="row pad-top">
                        <div class="col-md-4">
                            <asp:Label runat="server" Font-Bold="true"  Text="Product Search:" />
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtSearchProduct" Width="100%" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:ListView runat="server" ID="lvOrderItems">
                                
                            </asp:ListView>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Order" ID="btnSubmitOrder" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
