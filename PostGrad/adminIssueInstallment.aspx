<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminIssueInstallment.aspx.cs" Inherits="PostGrad.adminIssueInstallment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label runat="server" Text="Payment ID:"></asp:Label>
        <asp:TextBox ID="paymentIDTB" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label runat="server" Text="Installment Start Date:"></asp:Label>
        <asp:Calendar ID="installmentStartDateCalender" runat="server"></asp:Calendar>
        <br />
        <br />

        <asp:Button ID="issueInstallmentBtn" OnClick="issueInstallmentBtn_Click" runat="server" Text="Issue Installment" />
    </form>
</body>
</html>
