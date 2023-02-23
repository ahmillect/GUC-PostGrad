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
    public partial class courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse((string)Session["user"]);

            SqlCommand nonGucCourse = new SqlCommand("ViewCoursesGrades", conn);
            nonGucCourse.CommandType = CommandType.StoredProcedure;

            nonGucCourse.Parameters.Clear();
            nonGucCourse.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = id;

            conn.Open();
            SqlDataReader rdr = nonGucCourse.ExecuteReader(CommandBehavior.CloseConnection);
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();

        }
    }
}