<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cancelThesis.aspx.cs" Inherits="PostGrad.cancelThesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Thesis Serial Number:<br />
            <asp:TextBox ID="thesisno" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="sub" runat="server" OnClick="cancel" Text="Submit" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
