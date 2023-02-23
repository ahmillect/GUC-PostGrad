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
    public partial class listStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse((string)Session["user"]);

            SqlCommand students = new SqlCommand("ViewSupStudentsYears", conn);
            students.CommandType = CommandType.StoredProcedure;

            students.Parameters.Clear();
            students.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = id;

            conn.Open();
            SqlDataReader rdr = students.ExecuteReader(CommandBehavior.CloseConnection);
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();
        }
    }
}