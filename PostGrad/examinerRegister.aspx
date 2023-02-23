<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="examinerRegister.aspx.cs" Inherits="PostGrad.examinerRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            position: absolute;
            top: 294px;
            left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please enter your information to register --&gt;<br />
            First Name:<br />
            <asp:TextBox ID="firstName" runat="server"></asp:TextBox>
            <br />
            Last Name:<br />
            <asp:TextBox ID="lastName" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            Field of Work:<br />
            <asp:TextBox ID="field" runat="server"></asp:TextBox>
            <br />
            Email:<br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />
            Check the button if you're Egyptian:
            <br />
            <asp:RadioButton ID="isNational" runat="server" />
            <br />
            <asp:Button ID="signup" runat="server" OnClick="register" Text="Register" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
