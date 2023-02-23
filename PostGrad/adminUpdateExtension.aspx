<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminUpdateExtension.aspx.cs" Inherits="PostGrad.adminUpdateExtension" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label runat="server" Text="Thesis Serial Number:"></asp:Label>
        <asp:TextBox ID="thesesSerialTB" runat="server"></asp:TextBox>
        <br />
        <br />

        <asp:Button ID="updateExtensionBtn" OnClick="updateExtensionBtn_Click" runat="server" Text="Update Extension" />
    </form>
</body>
</html>
