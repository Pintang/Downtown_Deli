<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DowntownDeliProject.WebForm1" %>

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
        <div class="container">
          <div class="row">
              <img src="Content/Images/header.jpg" />
          </div>
          <div class="row">
            <div class="col-sm-3" style="background-color:burlywood; padding-top: 10px; padding-bottom: 10px; height: 500px">
                <h3>Log In to Order</h3>
                <form id="form1" runat="server">
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                    <div class="form-group">
                        <label for="Username">Email Address</label>
                        <asp:TextBox runat="server" ID="Username" CssClass="form-control" Placeholder="Email Address" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Username" CssClass="text-danger" ErrorMessage="The Email Address field is required." />
                    </div>
                    <div class="form-group">
                        <label for="Password">Password</label>
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" Placeholder="Password" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                    </div>
                    <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-primary" /> 
                    <asp:Button runat="server" OnClick="Register" Text="Register" CssClass="btn btn-primary" /> 
                </form>
            </div>
            <div class="col-sm-7">
                <h1>About Us</h1>
                <h3>Having lunch at the Downtown Deli & Cafe, is like having lunch with friends!</h3>
                <p>The owners of Downtown Deli, Lee Charleville and Scott Nifong, have been friends since little league and are veterans in the restaurant business.  They have been in downtown Winston Salem for over 20 years and remain the most popular restaurant on 4th street!</p>
                <p>The Downtown Deli menu features over 80 items including gourmet sandwiches, subs, fresh burgers, salads, wraps, and homemade desserts.</p>
                <blockquote>At Downtown Deli you are treated like family.  From the time you walk in the door you can relax, have a good time, and eat great food.  Scott and Lee will be sure to suggest the perfect thing if you are stuck and don’t know just what to order!</blockquote>
            </div>
          </div>


        </div>
</body>
</html>
