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
    public partial class searchThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void searchThesisTitle(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String keyword = searchBar.Text;

            SqlCommand searchProc = new SqlCommand("searchTitle", conn);
            searchProc.CommandType = CommandType.StoredProcedure;

            searchProc.Parameters.Clear();
            searchProc.Parameters.Add(new SqlParameter("@keyword", SqlDbType.VarChar)).Value = keyword;

            SqlParameter success = searchProc.Parameters.Add("@success", SqlDbType.Bit);

            success.Direction = System.Data.ParameterDirection.Output;

            conn.Open();
            SqlDataReader rdr = searchProc.ExecuteReader(CommandBehavior.CloseConnection);
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();

            if (success.Value.ToString() == "False")
            {
                Label l = new Label();
                l.Text = "No thesis found :/";
                form1.Controls.Add(l);
            }
        }
    }
}