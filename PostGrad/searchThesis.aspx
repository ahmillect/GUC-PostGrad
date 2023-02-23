<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="searchThesis.aspx.cs" Inherits="PostGrad.searchThesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 232px;
            height: 152px;
            position: absolute;
            top: 91px;
            left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Enter your desired keyword:<br />
            <asp:TextBox ID="searchBar" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="search" runat="server" OnClick="searchThesisTitle" Text="Search" Width="90px"/>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="auto-style1" style="z-index: 1">
            </asp:GridView>
            <br />
        </div>
    </form>
</body>
</html>
