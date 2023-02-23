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
    public partial class addComment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Comment(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (date.Text != "" && comments.Text != "")
            {
                int id = Int16.Parse(thesisNo.Text);
                DateTime dt = DateTime.Parse(date.Text);
                String cmnt = comments.Text;

                SqlCommand commentsProc = new SqlCommand("AddCommentsGrade", conn);
                commentsProc.CommandType = CommandType.StoredProcedure;

                commentsProc.Parameters.Clear();
                commentsProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = id;
                commentsProc.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = dt;
                commentsProc.Parameters.Add(new SqlParameter("@comments", SqlDbType.VarChar)).Value = cmnt;

                conn.Open();
                commentsProc.ExecuteNonQuery();
                conn.Close();

                Label l = new Label();
                l.Text = "Comments were added successfully";
                form1.Controls.Add(l);

            }
            else
            {
                Label l = new Label();
                l.Text = "Please fill out the fields";
                form1.Controls.Add(l);
            }
        }
    }
}