<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="supervisor.aspx.cs" Inherits="PostGrad.supervisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            List students' names and years spent in thesis:<br />
            <asp:Button ID="student" runat="server" OnClick="listStudent" Text="Students" Width="120px" />
            <br />
             View all publications of a student:<br />
            <asp:Button ID="pub" runat="server" OnClick="listPublication" Text="Publications" Width="120px" />
            <br />
             Add defense for thesis and add examiner(s) for defense:<br />
            <asp:Button ID="def" runat="server" OnClick="defense" Text="Defense" Width="120px" />
            <br />
             Evaluate progress report for a student and give evaluation value (0-3):<br />
            <asp:Button ID="eval" runat="server" OnClick="evaluatePR" Text="Evaluate" Width="120px" />
            <br />
             Cancel thesis if the evauation of the last progress report is zero:<br />
            <asp:Button ID="cancel" runat="server" OnClick="cancelThesis" Text="Cancel Thesis" Width="120px" />
            <br />
        </div>
    </form>
</body>
</html>
