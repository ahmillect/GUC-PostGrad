<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thesis.aspx.cs" Inherits="PostGrad.thesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            My Theses:<br />
            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" >
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
            <br />
            <br />
            <br />
            <br />
            <br />
            My Publications:<br />
            <asp:GridView ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
            <br />
            <br />
            <br />
            Link a publication to a thesis:<br />
            <br />
            Enter thesis&#39;s number:<asp:TextBox ID="noThes" runat="server" Width="113px"></asp:TextBox>
            <br />
            Enter publication&#39;s number:<asp:TextBox ID="noPub" runat="server" Width="113px"></asp:TextBox>
            <br />
            <asp:Button ID="Link" runat="server" Text="Link" OnClick="Link_Click" />
            <br />
            <br />
            <br />
            <br />
            Add a Progress Report to a thesis:<br />
            <br />
            Enter thesis&#39;s number:<asp:TextBox ID="noThes1" runat="server" Width="113px"></asp:TextBox>
            <br />
            <br />
            Date of Progress Report:<br />
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
            <br />
            Add the Reports&#39;s number:<asp:TextBox ID="repNum" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            Add State number:<asp:TextBox ID="stateNo" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            Description of the Progress:<br />
            <asp:TextBox ID="descBox" runat="server" Height="113px" Width="478px"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Button ID="addRep" runat="server" Text="Finish" OnClick="addRep_Click" />
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
