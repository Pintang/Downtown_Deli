<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationComplete.aspx.cs" Inherits="DowntownDeliProject.RegistrationComplete" %>

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
          <div class="row text-center">
                <h3>Downtown Deli & Cafe Account Created</h3>
                <p>Click below to log in.</p>
                <form id="form1" runat="server">
                    <asp:Button runat="server" OnClick="LogIn" Text="Log In" CssClass="btn btn-primary" /> 
                </form>

          </div>
        </div>
</html>
