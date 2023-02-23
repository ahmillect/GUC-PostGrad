<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="examiner.aspx.cs" Inherits="PostGrad.examiner" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             Edit my personal information:<br />
            <asp:Button ID="edit" runat="server" OnClick="editInfo" Text="Edit" Width="120px" />
            <br />
             List all theses titles, supervisors, and students names I attended defenses for:<br />
            <asp:Button ID="list" runat="server" OnClick="listAll" Text="List" Width="120px" />
            <br />
             Add comments for a defense:<br />
            <asp:Button ID="comm" runat="server" OnClick="addComment" Text="Comment" Width="120px" />
            <br />
             Add grade for a defense:<br />
            <asp:Button ID="grade" runat="server" OnClick="addGrade" Text="Grade" Width="120px" />
            <br />
             Search for thesis where the title contains the entered keyword:<br />
            <asp:Button ID="search" runat="server" OnClick="searchThesis" Text="Search" Width="120px" />
            <br />
        </div>
    </form>
</body>
</html>
