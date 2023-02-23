<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addComment.aspx.cs" Inherits="PostGrad.addComment" %>

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
            Comments:<br />
            <asp:TextBox ID="comments" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="comment" runat="server" OnClick="Comment" Text="Post" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
