<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="defense.aspx.cs" Inherits="PostGrad.defense" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Add defense for a thesis: <br />
            Check this button if the student is a Gucian: <br />
            <asp:RadioButton ID="gucian" runat="server" /><br />
            Thesis Serial No:<br />
            <asp:TextBox ID="thesisNo" runat="server"></asp:TextBox>
            <br />
            Defense Date:<br />
            <asp:TextBox ID="defDate" runat="server"></asp:TextBox>
            <br />
            Defense Location:<br />
            <asp:TextBox ID="defLoc" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="def" runat="server" OnClick="addDef" Text="Add defense" Width="120px" /><br />
            <br />
            Add Examiner for defense:<br />
            <asp:Button ID="eval" runat="server" OnClick="addEx" Text="Add Examiner" Width="120px" />
            <br />
        </div>
    </form>
</body>
</html>
