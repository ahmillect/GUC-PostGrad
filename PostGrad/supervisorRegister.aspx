<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="supervisorRegister.aspx.cs" Inherits="PostGrad.supervisorRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            Faculty:<br />
            <asp:TextBox ID="faculty" runat="server"></asp:TextBox>
            <br />
            Email:<br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="signup" runat="server" OnClick="register" Text="Register" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
