<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="PostGrad.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please choose your type:<br />
            <asp:Button ID="studentReg" runat="server" OnClick="student" Text="Student" Width="90px" />
            <br />
            <asp:Button ID="supReg" runat="server" OnClick="supervisor" Text="Supervisor" Width="90px"/>
            <br />
            <asp:Button ID="examinerReg" runat="server" OnClick="examiner" Text="Examiner" Width="90px"/>
            <br />
        </div>
    </form>
</body>
</html>
