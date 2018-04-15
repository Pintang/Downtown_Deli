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
            <div class="col-sm-3" style="background-color:burlywood; padding-top: 10px; padding-bottom: 10px; height: 500px">
                <h3>Welcome, <asp:Literal ID="Name" runat="server"></asp:Literal></h3>

            </div>
            <div class="col-sm-7">
            </div>
          </div>


        </div>
    </form>
</body>
</html>
