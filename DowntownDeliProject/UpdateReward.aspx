<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateReward.aspx.cs" Inherits="DowntownDeliProject.UpdateReward" %>

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
                <h3>Add a reward card to your account</h3>
                <p>A reward card makes it easier to check out with your account when you visit the Downtown Deli.</p>
                <form id="form2" runat="server">
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                    <div class="form-group">
                        <label for="reward">Reward Card #</label>
                        <asp:TextBox runat="server" ID="reward" CssClass="form-control" Placeholder="Reward Card #" Width="200px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="reward" CssClass="text-danger" ErrorMessage="The Reward Card # field is required." />
                        <small runat="server" id="usernameUsed" class="form-text text-muted">Enter the number found under the bar code on your reward card.</small>
                    </div>
                    <asp:Button runat="server" OnClick="UpdateReward_Click" Text="Update" CssClass="btn btn-primary" /> 
                </form>
          </div>


        </div>
</body>
</html>
