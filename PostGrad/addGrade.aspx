<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addGrade.aspx.cs" Inherits="PostGrad.addGrade" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Thesis Serial Number:<br />
            <asp:TextBox ID="thesisNo" runat="server"></asp:TextBox>
            <br />
            Date of Defense:<br />
            <asp:TextBox ID="date" runat="server"></asp:TextBox>
            <br />
            Grade:<br />
            <asp:TextBox ID="grades" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="grade" runat="server" OnClick="Grade" Text="Submit" Width="90px" />
            <br />
        </div>
    </form>
</body>
</html>
