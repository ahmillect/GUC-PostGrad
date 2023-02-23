using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad
{
    public partial class publication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            calBox.Text = Calendar1.SelectedDate.ToShortDateString();
        }

        protected void AddPublication_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String ti = title.Text;
            String cal = calBox.Text;
            String ho = host.Text;
            String pla = place.Text;
            int bit;
            if (Accepted.Checked)
            {
                bit = 1;
            }
            else bit = 0;


            SqlCommand regProc = new SqlCommand("addPublication", conn);
            regProc.CommandType = CommandType.StoredProcedure;

            regProc.Parameters.Clear();
            regProc.Parameters.Add(new SqlParameter("@title", SqlDbType.VarChar)).Value = ti;
            regProc.Parameters.Add(new SqlParameter("@pubDate", SqlDbType.VarChar)).Value = cal;
            regProc.Parameters.Add(new SqlParameter("@host", SqlDbType.VarChar)).Value = ho;
            regProc.Parameters.Add(new SqlParameter("@place", SqlDbType.VarChar)).Value = pla;
            regProc.Parameters.Add(new SqlParameter("@accepted", SqlDbType.Bit)).Value = bit;

            conn.Open();
            regProc.ExecuteNonQuery();
            conn.Close();

            Label l = new Label();
            l.Text = "You successfully added a new publication";
            form1.Controls.Add(l);

        }

    }
}