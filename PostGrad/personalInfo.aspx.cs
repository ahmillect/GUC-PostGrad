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
    public partial class personalInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse((string)Session["user"]);

            SqlCommand stuProfile = new SqlCommand("viewMyProfile", conn);
            stuProfile.CommandType = CommandType.StoredProcedure;

            stuProfile.Parameters.Clear();
            stuProfile.Parameters.Add(new SqlParameter("@studentId", SqlDbType.Int)).Value = id;

            conn.Open();
            SqlDataReader rdr = stuProfile.ExecuteReader(CommandBehavior.CloseConnection);
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();

        }
    }
}