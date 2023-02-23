<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="publication.aspx.cs" Inherits="PostGrad.publication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            Title:<br />
            <asp:TextBox ID="title" runat="server" Height="40px" Width="241px"></asp:TextBox>
            <br />
            <br />
            Date of Publication:<br />
            <asp:TextBox ID="calBox" runat="server" Width="240px"></asp:TextBox>
            <br />
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="217px" Width="258px" OnSelectionChanged="Calendar1_SelectionChanged">
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#808080" />
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" />
                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                <WeekendDayStyle BackColor="#FFFFCC" />
            </asp:Calendar>
            <br />
            Host name:<br />
            <asp:TextBox ID="host" runat="server" Height="54px" Width="243px"></asp:TextBox>
            <br />
            <br />
            Place:<br />
            <asp:TextBox ID="place" runat="server" Height="40px" Width="181px"></asp:TextBox>
            <br />
            <br />
            <br />
            Check the button if publication is accepted:
            <br />
            <asp:RadioButton ID="Accepted" runat="server" />
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="AddPublication" runat="server" Text="Add" OnClick="AddPublication_Click" />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
