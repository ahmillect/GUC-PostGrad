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
    public partial class listPublication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void listPub(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (id.Text != "")
            {
                int sid = Int16.Parse(id.Text);

                SqlCommand lp = new SqlCommand("ViewAStudentPublications", conn);
                lp.CommandType = CommandType.StoredProcedure;

                lp.Parameters.Clear();
                lp.Parameters.Add(new SqlParameter("@StudentID", SqlDbType.Int)).Value = sid;

                conn.Open();
                SqlDataReader rdr = lp.ExecuteReader(CommandBehavior.CloseConnection);
                GridView1.DataSource = rdr;
                GridView1.DataBind();
                conn.Close();
            }
            else
            {
                Label l = new Label();
                l.Text = "Please Enter a valid ID";
                form1.Controls.Add(l);
            }
        }
    }
}