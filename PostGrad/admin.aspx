<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="PostGrad.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" OnClick="issueInstall" Text="Issue Installment" Width="180px" />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="issueTheses" Text="Issue Theses Payment" Width="180px" />
            <br />
            <asp:Button ID="Button3" runat="server" OnClick="listSup" Text="List Supervisors" Width="180px" />
            <br />
            <asp:Button ID="Button4" runat="server" OnClick="listTheses" Text="List Theses" Width="180px" />
            <br />
            <asp:Button ID="Button5" runat="server" OnClick="updateExtension" Text="Update Extensions" Width="180px" />
            <br />
        </div>
    </form>
</body>
</html>
