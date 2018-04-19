<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoggedIn.aspx.cs" Inherits="DowntownDeliProject.LoggedIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>downtowndelicafe.com</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/fontawesome.css" rel="stylesheet" />
    <meta name="theme-color" content="#D3D3D3" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
          <div class="row">
              <img src="Content/Images/header.jpg" />
          </div>
          <div class="row">
            <div class="col-sm-3" style="background-color:burlywood; padding-top: 10px; padding-bottom: 10px; height: 100%">
                <h3>Welcome, <asp:Literal ID="Name" runat="server"></asp:Literal></h3>
                <asp:Literal ID="rewardCard" runat="server"></asp:Literal>
                <h3>Reward Balance</h3>
                <p><asp:Literal ID="rewardBalance" runat="server"></asp:Literal></p>
                <h3>Shopping Cart</h3>
                <p><asp:Literal ID="shoppingCart" runat="server"></asp:Literal></p>
                <table class="table">
                    <thead>
                        <th scope="col">Item</th>
                        <th scope="col">Price</th>
                        <th scope="col"></th>
                    </thead>
                    <tbody>
                        <asp:Panel ID="shoppingCartContents" runat="server"></asp:Panel>
                    </tbody>
                </table>

            </div>
            <div class="col-sm-7">
                <h2>Choose item(s) you'd like to add to your cart</h2>
                <table class="table">
                    <thead>
                        <th scope="col"></th>
                        <th scope="col">Item</th>
                        <th scope="col">Price</th>
                    </thead>
                    <tbody>
                        <asp:Panel ID="Menu" runat="server"></asp:Panel>
                    </tbody>
                </table>
                <asp:Button ID="Add" runat="server" Text="Add to Cart" OnClick="Add_Click" />
                <br />
            </div>
          </div>


        </div>
    </form>
</body>
</html>
