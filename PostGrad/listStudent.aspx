<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="listStudent.aspx.cs" Inherits="PostGrad.listStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 232px;
            height: 152px;
            position: absolute;
            top: 15px;
            left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" CssClass="auto-style1" style="z-index: 1">
            </asp:GridView>
        </div>
    </form>
</body>
</html>
