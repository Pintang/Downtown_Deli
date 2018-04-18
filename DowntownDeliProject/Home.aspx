<%@ Page Title="Downtown Deli Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="DowntownDeliProject._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Body" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-12">
                    <asp:Label runat="server" ID="WelcomeUser" Font-Bold="true" Text="" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <h3 class="text-center">Today's Sales</h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <canvas id="myChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <h3 class="text-center">Today's Promo Sales</h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <canvas height="150" id="pieChart"></canvas>
                        </div>
                    </div>

                </div>
            </div>
            <div class="row pad-top text-center">
                <div class="col-md-12">
                    <h2>Remember!
                    </h2>
                </div>
            </div>
            <div class="row pad-top">
                <div class="col-md-12">
                    <asp:Literal ID="Promotions" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
