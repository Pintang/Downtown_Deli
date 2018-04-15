<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DowntownDeliProject.Register" %>

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
                <h3>Create a Downtown Deli & Cafe Account</h3>
                <form id="form1" runat="server">
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                    <div class="form-group">
                        <label for="FirstName">First Name</label>
                        <asp:TextBox runat="server" ID="FirstName" CssClass="form-control" Placeholder="First Name" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="FirstName" CssClass="text-danger" ErrorMessage="The First Name field is required." />
                    </div>
                    <div class="form-group">
                        <label for="LastName">Last Name</label>
                        <asp:TextBox runat="server" ID="LastName" CssClass="form-control" Placeholder="Last Name" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="LastName" CssClass="text-danger" ErrorMessage="The Last Name field is required." />
                    </div>
                    <div class="form-group">
                        <label for="Zip">Zip</label>
                        <asp:TextBox runat="server" ID="Zip" CssClass="form-control" Placeholder="ZipCode" Width="200px" />
                    </div>
                    <div class="form-group">
                        <label for="Phone">Phone Number</label>
                        <asp:TextBox runat="server" ID="Phone" CssClass="form-control" AutoPostBack="true" Placeholder="Phone Number" Width="200px" OnTextChanged="Phone_TextChanged" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Phone" CssClass="text-danger" ErrorMessage="The Phone Number field is required." />
                        <small runat="server" id="phoneUsed" class="form-text text-muted" style="display:none;">Phone number already used, try another.</small>
                    </div>
                    <div class="form-group">
                        <label for="Username">Email Address</label>
                        <asp:TextBox runat="server" ID="Username" CssClass="form-control" AutoPostBack="true" Placeholder="Email Address" Width="200px" OnTextChanged="Username_TextChanged" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Username" CssClass="text-danger" ErrorMessage="The Email Address field is required." />
                        <small runat="server" id="usernameUsed" class="form-text text-muted" style="display:none;">Email Address already used, try another.</small>
                    </div>
                    <div class="form-group">
                        <label for="Password">Password</label>
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" Placeholder="Password" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                    </div>
                    <asp:Button runat="server" OnClick="Register_Click" Text="Register" CssClass="btn btn-primary" /> 
                </form>

          </div>
        </div>
</body>
</html>
