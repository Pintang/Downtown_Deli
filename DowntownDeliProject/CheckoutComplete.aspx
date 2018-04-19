<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckoutComplete.aspx.cs" Inherits="DowntownDeliProject.CheckoutComplete" %>

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
            </div>
            <div class="col-sm-7">
                <h2>Your order has been placed!</h2>
                <table class="table">
                    <thead>
                        <th scope="col">Item</th>
                        <th scope="col">Price</th>
                    </thead>
                    <tbody>
                        <asp:Panel ID="shoppingCartContents" runat="server"></asp:Panel>
                    </tbody>
                </table>
                <br />
                <asp:Button ID="Return" runat="server" Text="Return to menu" OnClick="Return_Click" />
            </div>
          </div>


        </div>
    </form>
</body>
</html>
