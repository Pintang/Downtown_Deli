﻿<%@ Page Language="C#" Title="System Admin" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="DowntownDeliProject.Pages.Admin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-primary" Width="100%" OnClick="btnMenuItems_Click" Text="Menu Items" ID="btnMenuItems" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-success" Width="100%" OnClick="btnEmployees_Click" Text="Employees" ID="btnEmployees" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-danger" Width="100%" OnClick="btnPromotions_Click" Text="Promotions" ID="btnPromotions" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-info" Width="100%" OnClick="btnVendors_Click" Text="Vendors" ID="btnVendors" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-default" Width="100%" OnClick="btnJobs_Click" Text="Jobs" ID="btnJobs" />
                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" CssClass="btn btn-warning" Width="100%" OnClick="btnSchedule_Click" Text="Schedule" ID="btnSchedule" />
                </div>
            </div>
            <div runat="server" visible="false" id="MenuDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewMenuItemModal'); return false;">Add New Menu Item</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdateMenuItemModal'); return false;">Modify Menu Item</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvMenuItems" OnItemCommand="lvMenuItems_ItemCommand" OnPagePropertiesChanging="lvMenuItems_PagePropertiesChanging" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblCost" Font-Bold="true" Text='Cost' />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:PlaceHolder runat="server" ID="lvItemPlaceHolder" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:DataPager ID="lvMenuItemsPager" runat="server" PagedControlID="lvMenuItems" PageSize="15">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn" FirstPageText="Prev" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                                    ShowNextPageButton="false" />
                                                <asp:NumericPagerField ButtonType="Button" />
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn" FirstPageText="Next" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton="false" />
                                            </Fields>
                                        </asp:DataPager>
                                    </div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Product_ID") %>' Visible="false" />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Product_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# decimal.Parse(Eval("Price").ToString()).ToString("0.00") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Product_ID") %>' Visible="false" />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Product_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# decimal.Parse(Eval("Price").ToString()).ToString("0.00") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
            <div runat="server" visible="false" id="EmployeeDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewEmployeeModal'); return false;">Add New Employee</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdateEmployeeModal'); return false;">Modify Employee</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvEmployees" OnItemCommand="lvEmployees_ItemCommand" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="Label3" Font-Bold="true" Text='Employee ID' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Employee Name' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblCost" Font-Bold="true" Text='Username' />
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
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Emp_ID") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("F_Name") + " " + Eval("L_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Emp_User_Name") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Emp_ID") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("F_Name") + " " + Eval("L_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Emp_User_Name") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
            <div runat="server" visible="false" id="PromoDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewPromoModal'); return false;">Add New Promo</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdatePromoModal'); return false;">Modify Promo</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvPromos" OnItemCommand="lvPromos_ItemCommand" OnItemDataBound="lvPromos_ItemDataBound" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="Label3" Font-Bold="true" Text='Promo' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Discount' />
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
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Promo_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Promo_Description") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Discount") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Promo_Description") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Discount") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
            <div runat="server" visible="false" id="VendorDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewVendorModal'); return false;">Add New Vendor</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdateVendorModal'); return false;">Modify Vendor</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvVendors" OnItemCommand="lvVendors_ItemCommand" OnItemDataBound="lvVendors_ItemDataBound" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="Label3" Font-Bold="true" Text='Vendor' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Address' />
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
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Vendor_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Vendor_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Vend_Address") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Vendor_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Vendor_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Vend_Address") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
            <div runat="server" visible="false" id="JobsDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewJobModal'); return false;">Add New Job</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdateJobModal'); return false;">Modify Job</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvJobs" OnItemCommand="lvJobs_ItemCommand" OnItemDataBound="lvJobs_ItemDataBound" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="Label3" Font-Bold="true" Text='Job' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Duties' />
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
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Job_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Job_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Duties") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Job_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Job_Name") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Duties") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
            <div runat="server" visible="false" id="ScheduleDiv" class="row pad-top">
                <div class="row">
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="OpenModal('AddNewScheduleModal'); return false;">Add New Schedule</button>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-info" onclick="OpenModal('UpdateScheduleModal'); return false;">Modify Schedule</button>
                    </div>
                </div>
                <div class="row pad-top" style="border: thin">
                    <div class="col-md-12" style="border: thin">
                        <asp:ListView runat="server" ID="lvSchedule" OnItemCommand="lvSchedule_ItemCommand" OnItemDataBound="lvSchedule_ItemDataBound" ItemPlaceholderID="lvItemPlaceHolder">
                            <LayoutTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="Label3" Font-Bold="true" Text='Schedule Id' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Description' />
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
                            <ItemTemplate>
                                <div class="row" style="background-color: #D3D3D3;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Schedule_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Schedule_ID") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Schedule_Description") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <div class="row" style="background-color: white;">
                                    <div class="col-md-12">
                                        <div class="row pad">
                                            <asp:Label runat="server" ID="lblPromo_ID" Visible="false" Text='<%# Eval("Schedule_ID") %>' />
                                            <div class="col-md-3">
                                                <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("Schedule_ID") %>' />
                                            </div>
                                            <div class="col-md-3">
                                                <asp:Label runat="server" Text='<%# Eval("Schedule_Description") %>' />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:Button ID="btnDelete" CommandName="DeleteCommand" CssClass="btn btn-danger" Text="Delete" runat="server"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </AlternatingItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Menu Item Modals --%>
    <div class="modal" tabindex="-1" id="AddNewMenuItemModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Menu Item</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblNewMenuItemError" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Product Name:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbMenuItemNameNew" />
                                        </div>
                                    </div>
                                    <div runat="server" id="Div1" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Price:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" Width="100%" ID="tbNewMenuPrice" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <asp:ListView runat="server" ID="lvNewInventory" ItemPlaceholderID="lvItemPlaceHolder">
                                                        <LayoutTemplate>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="Label2" Font-Bold="true" Text='Include in Order' />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
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
                                                        <ItemTemplate>
                                                            <div class="row" style="background-color: #D3D3D3;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <div class="row" style="background-color: white;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </AlternatingItemTemplate>
                                                    </asp:ListView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateNewMenuItem(); return false;" class="btn btn-success">Add</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Add" OnClick="btnAddNewMenuItem_Click" ID="btnAddNewMenuItem" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdateMenuItemModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Menu Item</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblErrorMenuItemModify" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Product:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select a Product From the list" OnSelectedIndexChanged="ddlMenuItemProducts_SelectedIndexChanged" AutoPostBack="true" DataTextField="Product_Name" CssClass="form-control" Width="100%" DataValueField="Product_ID" ID="ddlMenuItemProducts">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="MenuItemUpdateDiv" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Price:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtMenuItemPrice" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <asp:ListView runat="server" ID="lvInventoryItems" OnItemDataBound="lvInventoryItems_ItemDataBound" ItemPlaceholderID="lvItemPlaceHolder">
                                                        <LayoutTemplate>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="Label2" Font-Bold="true" Text='Include in Order' />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" ID="lblName" Font-Bold="true" Text='Item Name' />
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
                                                        <ItemTemplate>
                                                            <div class="row" style="background-color: #D3D3D3;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <div class="row" style="background-color: white;">
                                                                <div class="col-md-12">
                                                                    <div class="row pad">
                                                                        <asp:Label runat="server" ID="lblItemID" Text='<%# Eval("Item_ID") %>' Visible="false" />
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="cbProductInvItem" runat="server" CssClass="checkbox-inline" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label runat="server" Text='<%# Eval("Item_Name") %>' />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </AlternatingItemTemplate>
                                                    </asp:ListView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateModifyMenuItem(); return false;" class="btn btn-success">Update</button>
                            <asp:Button runat="server" CssClass="hidden" OnClick="btnUpdateMenuItem_Click" ID="btnUpdateMenuItem" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Employee Modals --%>
    <div class="modal" tabindex="-1" id="AddNewEmployeeModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Employee</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <asp:Label ID="lblerrorNewEMployee" ForeColor="Red" runat="server" />
                            </div>
                            <div runat="server" id="Div2" class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Job:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select a Job From the list" DataTextField="Job_Name" CssClass="form-control" Width="100%" DataValueField="Job_ID" ID="ddlJobEmpNew">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Schedule:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select a Schedule From the list" DataTextField="Schedule_Description" CssClass="form-control" Width="100%" DataValueField="Schedule_ID" ID="ddlScheduleNew">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="First Name" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtFirstNameNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Last Name" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtlastNameNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Pay Rate" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" Width="100%" ID="txtPayNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Phone Number" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Phone" Width="100%" ID="txtPhoneNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Email" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Email" Width="100%" ID="txtEmailNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Address" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtAddressNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Username" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtUsernameNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Password" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" Width="100%" ID="txtPasswordNew" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateNewEmployee(); return false;" class="btn btn-success">Add</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Add" OnClick="btnNewEmployee_Click" ID="btnNewEmployee" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdateEmployeeModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Employee</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblErrorEmployeeModify" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Employee:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select an Employee From the list" OnSelectedIndexChanged="ddlEmployeeModify_SelectedIndexChanged" AutoPostBack="true" DataTextField="F_Name" CssClass="form-control" Width="100%" DataValueField="Emp_ID" ID="ddlEmployeeModify">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="divEmployeeModify" visible="false" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Job:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:DropDownList runat="server" ToolTip="Select a Job From the list" DataTextField="Job_Name" CssClass="form-control" Width="100%" DataValueField="Job_ID" ID="ddlJobEmpModify">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Schedule:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:DropDownList runat="server" ToolTip="Select a Schedule From the list" DataTextField="Schedule_Description" CssClass="form-control" Width="100%" DataValueField="Schedule_ID" ID="ddlScheduleEmpModify">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="First Name" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtFirstnameModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Last Name" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtLastnameModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Pay Rate" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" Width="100%" ID="txtPayModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Phone Number" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Phone" Width="100%" ID="txtPhoneModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Email" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Email" Width="100%" ID="txtEmailModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Address" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtAddressModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Username" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtUsername" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Password" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" Width="100%" ID="txtPassword" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateModifyEmployee(); return false;" class="btn btn-success">Update</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Update" OnClick="btnUpdateEmployee_Click" ID="btnUpdateEmployee" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Promotion Modals --%>
    <div class="modal" tabindex="-1" id="AddNewPromoModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Promo</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <asp:Label ID="lblErrorPromoNew" ForeColor="Red" runat="server" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Discount Type:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select a Discount Type From the list" CssClass="form-control" Width="100%" ID="ddlDiscountTypeNew">
                                                <asp:ListItem>Cash Off</asp:ListItem>
                                                <asp:ListItem>Percent Off</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Discount:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbDicountNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Begin Date:" />
                                        </div>
                                        <div class="col-md-8">
                                            <div class="row pad-top">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <div class='input-group date' id='dpBeginDatePickerNew'>
                                                            <input type='text' runat="server" id="dpBeginDatePickerNewInput" class="form-control" />
                                                            <span class="input-group-addon">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="End Date:" />
                                        </div>
                                        <div class="col-md-8">
                                            <div class="row pad-top">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <div class='input-group date' id='dpEndDatePickerNew'>
                                                            <input type='text' runat="server" id="dpEndDatePickerNewInput" class="form-control" />
                                                            <span class="input-group-addon">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Promo Description:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbPromoDescNew" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateNewPromo(); return false;" class="btn btn-success">Add</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Add" OnClick="btnNewPromo_Click" ID="btnNewPromo" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdatePromoModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Promo</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblErrorModifyPromo" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Promotion:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select an Promo From the list" OnSelectedIndexChanged="ddlPromoModify_SelectedIndexChanged" AutoPostBack="true" DataTextField="Promo_Description" CssClass="form-control" Width="100%" DataValueField="Promo_ID" ID="ddlPromoModify">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="divPromoModify" visible="false" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Discount Type:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:DropDownList runat="server" ToolTip="Select a Discount Type From the list" CssClass="form-control" Width="100%" ID="ddlDiscountType">
                                                        <asp:ListItem>Cash Off</asp:ListItem>
                                                        <asp:ListItem>Percent Off</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Discount" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbDiscountModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Begin Date" />
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="row pad-top">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <div class='input-group date' id='dpBeginDatePickerModify'>
                                                                    <input type='text' runat="server" id="dpBeginDatePickerModifyInput" class="form-control" />
                                                                    <span class="input-group-addon">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="End Date" />
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="row pad-top">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <div class='input-group date' id='dpEndDatePickerModify'>
                                                                    <input type='text' runat="server" id="dpEndDatePickerModifyInput" class="form-control" />
                                                                    <span class="input-group-addon">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Promo Description" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbPromDescModify" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateModifyPromo(); return false;" class="btn btn-success">Update</button>

                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Update" OnClick="btnUpdatePromo_Click" ID="btnUpdatePromo" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <%-- Vendors Modals --%>
    <div class="modal" tabindex="-1" id="AddNewVendorModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Vendor</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <asp:Label ID="lblVendorNewError" ForeColor="Red" runat="server" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Vendor Name:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtVendorNameNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Discount:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtVendorDiscountNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Vendor Address" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtVendorAddressNew" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateNewVendor(); return false;" class="btn btn-success">Add</button>

                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Add" OnClick="btnAddVendor_Click" ID="btnAddVendor" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdateVendorModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Vendor</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblVendorModifyError" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Vendor:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select an Promo From the list" OnSelectedIndexChanged="ddlVendorModify_SelectedIndexChanged" AutoPostBack="true" DataTextField="Vendor_Name" CssClass="form-control" Width="100%" DataValueField="Vendor_ID" ID="ddlVendorModify">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="divVendorModify" visible="false" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Vendor Name:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtVendorNameModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Discount:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtDiscountVendorModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Vendor Address" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtVendorAddress" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateModifyVendor(); return false;" class="btn btn-success">Update</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Update" OnClick="btnUpdateVendor_Click" ID="btnUpdateVendor" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Jobs Modals --%>
    <div class="modal" tabindex="-1" id="AddNewJobModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Job</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <asp:Label ID="lblErrorNewJob" ForeColor="Red" runat="server" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Job Name:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="tbJobNameNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Duties:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtJobDutiesNew" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateNewJob(); return false;" class="btn btn-success">Add</button>

                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Add" OnClick="btnAddNewJob_Click" ID="btnAddNewJob" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdateJobModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Job</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblErrorJobModify" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Job:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select an Promo From the list" OnSelectedIndexChanged="ddlJobsModify_SelectedIndexChanged" AutoPostBack="true" DataTextField="Job_Name" CssClass="form-control" Width="100%" DataValueField="Job_ID" ID="ddlJobsModify">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="divJobModify" visible="false" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Job Name:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtJobNameModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Duties:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtJobDutiesModify" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateModifyJob(); return false;" class="btn btn-success">Update</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Update" OnClick="btnJobpdate_Click" ID="btnJobpdate" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Schedule Modals --%>
    <div class="modal" tabindex="-1" id="AddNewScheduleModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Schedule</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <asp:Label ID="lblErrorSchModify" ForeColor="Red" runat="server" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Shift Start:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtShiftStartNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Shift End:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtShiftEndNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Description:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtDescriptionNew" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbMondayNew" Text="Monday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbTuesdayNew" Text="Tuesday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbWednesdayNew" Text="Wednesday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbThursdayNew" Text="Thursday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbFridayNew" Text="Friday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbSaturdayNew" Text="Saturday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <asp:CheckBox ID="cbSundayNew" Text="Sunday" runat="server" CssClass="checkbox-inline" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateNewSchedule(); return false;" class="btn btn-success">Add</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Add" OnClick="btnAddNewSchedule_Click" ID="btnAddNewSchedule" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" id="UpdateScheduleModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Schedule</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="updatePanel6" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:Label ID="lblErrorScheduleModify" ForeColor="Red" runat="server" />
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <asp:Label runat="server" Font-Bold="true" Text="Schedule:" />
                                        </div>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" ToolTip="Select an Schedule From the list" OnSelectedIndexChanged="ddlScheduleModify_SelectedIndexChanged" AutoPostBack="true" DataTextField="Schedule_Description" CssClass="form-control" Width="100%" DataValueField="Schedule_ID" ID="ddlScheduleModify">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div runat="server" id="divScheduleModify" visible="false" class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Shift Start:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtShiftStartModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Shift End:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtShiftEndModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Description:" />
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:TextBox runat="server" CssClass="form-control" Width="100%" ID="txtDescriptionModify" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbMondayModify" Text="Monday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbTuesdayModify" Text="Tuesday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbWednesdayModify" Text="Wednesday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbThursdayModify" Text="Thursday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbFridayModify" Text="Friday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbSaturdayModify" Text="Saturday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <asp:CheckBox ID="cbSundayModify" Text="Sunday" runat="server" CssClass="checkbox-inline" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-3">
                            <button onclick="ValidateModifySchedule(); return false;" class="btn btn-success">Update</button>
                            <asp:Button runat="server" CssClass="btn btn-success hidden" Text="Update" OnClick="btnUpdateSchedule_Click" ID="btnUpdateSchedule" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
