<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addExDef.aspx.cs" Inherits="PostGrad.addExDef" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Thesis Serial No:<br />
            <asp:TextBox ID="thesisNo" runat="server"></asp:TextBox>
            <br />
            Defense Date:<br />
            <asp:TextBox ID="defDate" runat="server"></asp:TextBox>
            <br />
            Examiner Name:<br />
            <asp:TextBox ID="exName" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="pass" runat="server"></asp:TextBox>
            <br />
            Check the button if you're Egyptian:
            <br />
            <asp:RadioButton ID="isNational" runat="server" />
            <br />
            Field of Work:<br />
            <asp:TextBox ID="fow" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="add" runat="server" OnClick="addEx" Text="Add examiner" Width="120px" /><br />

        </div>
    </form>
</body>
</html>
