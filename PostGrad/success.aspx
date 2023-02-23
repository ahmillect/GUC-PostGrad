<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="success.aspx.cs" Inherits="PostGrad.popup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            You have registered successfully :)
            <br />
            <asp:Button ID="r" runat="server" OnClick="redirect" Text="Click here to return" Width="150px" />
            <br />
        </div>
    </form>
</body>
</html>
