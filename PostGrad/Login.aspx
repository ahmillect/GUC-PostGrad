<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PostGrad.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            position: absolute;
            top: 15px;
            left: 10px;
        }
    </style>
    </head>
<body>
    <form id="form1" runat="server">
        <div>
            Please enter your login information to proceed! If not a user, Please click on the Register button.<br />
            Email:<br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server" PasswordChar='*'></asp:TextBox>
            <br />
            <asp:Button ID="signin" runat="server" OnClick="login" Text="Login" Width="90px" />
            <br />
            <asp:Button ID="signup" runat="server" OnClick="register" Text="Register" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
