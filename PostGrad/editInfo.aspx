<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editInfo.aspx.cs" Inherits="PostGrad.editInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please enter your new information to update them!<br />
            Name:<br />
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
            <br />
            Field of Work:<br />
            <asp:TextBox ID="field" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="update" runat="server" OnClick="updateInfo" Text="Update" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
