<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminIssueThesesPayment.aspx.cs" Inherits="PostGrad.adminIssueThesesPayment" %>

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
        <asp:Label runat="server" Text="Payment Ammount:"></asp:Label>
        <asp:TextBox ID="paymentAmmountTB" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label runat="server" Text="Installments Count:"></asp:Label>
        <asp:TextBox ID="noInstallmentsTB" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label runat="server" Text="Fund Percentage:"></asp:Label>
        <asp:TextBox ID="fundPercentageTB" runat="server"></asp:TextBox>
        <asp:Label runat="server" Text="%"></asp:Label>
        <br />
        <br />

        <asp:Button ID="issueThesesPaymentBtn" OnClick="issueThesesPaymentBtn_Click" runat="server" Text="Issue Thesis Payment" />
    </form>
</body>
</html>
