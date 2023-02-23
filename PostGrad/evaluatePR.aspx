<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="evaluatePR.aspx.cs" Inherits="PostGrad.evaluatePR" %>

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
            Progress Report Number:<br /> 
            <asp:TextBox ID="prnumber" runat="server"></asp:TextBox>
            <br />
            Evaluation:<br />
            <asp:DropDownList ID="DropDownList" runat="server" OnSelectedIndexChanged="DropDownList_SelectedIndexChanged">
                <asp:ListItem>0</asp:ListItem>
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Button ID="sub" runat="server" OnClick="evalPR" Text="Submit" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
