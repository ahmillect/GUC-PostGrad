<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="PostGrad.student" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body>
    <form id="stu" runat="server">
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Height="28px" Width="354px">
            <asp:ListItem>My Info</asp:ListItem>
            <asp:ListItem>My Courses</asp:ListItem>
            <asp:ListItem>My Thesis and My Publication</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="selectInfo" runat="server" Text="select" OnClick="selectInfo_Click" />
        <br />
        <br />
        <br />
        <br />
        Add Phone Number:<br />
        <asp:TextBox ID="phoneBox" runat="server" Width="232px"></asp:TextBox>
        <br />
        <asp:Button ID="phone" runat="server" Text="Add" OnClick="phone_Click" />
        <br />
        <br />
        <br />
        <asp:Button ID="addPub" runat="server" Text="Add a new Publication" Width="268px" OnClick="addPub_Click1" />
        <br />
        <br />
        <br />
        <br />
    </form>
</body>
</html>
