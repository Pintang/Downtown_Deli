<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DowntownDeliProject.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>downtowndelicafe.com</title>
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    <link href="/Content/fontawesome.css" rel="stylesheet" />
    <meta name="theme-color" content="#D3D3D3" />
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
</head>
<body>
        <div class="container">
          <div class="row">
              <img src="Content/Images/header.jpg" />
          </div>
          <div class="row">
            <div class="col-sm-3" style="background-color:burlywood; padding-top: 10px; padding-bottom: 10px;">
                <form id="form1" runat="server">
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                    <div class="form-group">
                        <label for="Username">Username</label>
                        <asp:TextBox runat="server" ID="Username" CssClass="form-control" Placeholder="Username" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Username" CssClass="text-danger" ErrorMessage="The Username field is required." />
                    </div>
                    <div class="form-group">
                        <label for="Password">Password</label>
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" Placeholder="Password" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                    </div>
                    <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-primary" /> 
                </form>
            </div>
            <div class="col-sm">
                Content
            </div>
          </div>


        </div>
</body>
</html>
