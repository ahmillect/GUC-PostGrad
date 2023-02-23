<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminListTheses.aspx.cs" Inherits="PostGrad.adminListTheses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="thesesGrid" ShowHeaderWhenEmpty="true" runat="server"></asp:GridView>
            <br/>
        </div>
        <br />
        <asp:Label ID="onGoingThesesCount" runat="server"></asp:Label>
    </form>
</body>
</html>
