<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="DowntownDeliProject.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>downtowndelicafe.com</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/fontawesome.css" rel="stylesheet" />
    <link href="Content/skeuocard.reset.css" rel="stylesheet" />
    <link href="Content/skeuocard.css" rel="stylesheet" />
    <link href="Content/demo.css" rel="stylesheet" />
    <meta name="theme-color" content="#D3D3D3" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/skeuocard.min.js"></script>
    <script>
        $(document).ready(function () {
            card = new Skeuocard($("#skeuocard"));
        });
    </script>
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
                <h2>Verify your order, then provide payment information below</h2>
                <asp:Panel ID="rewardPoints" runat="server"></asp:Panel>
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
                <br />

                <p class="text-center">
                    <div class="credit-card-input no-js" id="skeuocard">
                      <p class="no-support-warning">
                        Either you have Javascript disabled, or you're using an unsupported browser, amigo! That's why you're seeing this old-school credit card input form instead of a fancy new Skeuocard. On the other hand, at least you know it gracefully degrades...
                      </p>
                      <label for="cc_type">Card Type</label>
                      <select name="cc_type">
                        <option value="">...</option>
                        <option value="visa">Visa</option>
                        <option value="discover">Discover</option>
                        <option value="mastercard">MasterCard</option>
                        <option value="maestro">Maestro</option>
                        <option value="jcb">JCB</option>
                        <option value="unionpay">China UnionPay</option>
                        <option value="amex">American Express</option>
                        <option value="dinersclubintl">Diners Club</option>
                      </select>
                      <label for="cc_number">Card Number</label>
                      <input type="text" name="cc_number" id="cc_number" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" size="19">
                      <label for="cc_exp_month">Expiration Month</label>
                      <input type="text" name="cc_exp_month" id="cc_exp_month" placeholder="00">
                      <label for="cc_exp_year">Expiration Year</label>
                      <input type="text" name="cc_exp_year" id="cc_exp_year" placeholder="00">
                      <label for="cc_name">Cardholder's Name</label>
                      <input type="text" name="cc_name" id="cc_name" placeholder="John Doe">
                      <label for="cc_cvc">Card Validation Code</label>
                      <input type="text" name="cc_cvc" id="cc_cvc" placeholder="123" maxlength="3" size="3">
                    </div>
                    <asp:Button ID="CheckOut" runat="server" Text="Check Out" OnClick="CheckOut_Click" />
                    <asp:Button ID="Return" runat="server" Text="Return to Menu" OnClick="Return_Click" />
                </p>
            </div>
          </div>


        </div>
    </form>
</body>
</html>
