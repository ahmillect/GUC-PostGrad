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
    public partial class editInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void updateInfo(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (name.Text != "" && field.Text != "")
            {

                int id = Int16.Parse((string)Session["user"]);
                String Name = name.Text;
                String fow = field.Text;

                SqlCommand updateProc = new SqlCommand("UpdateExaminerProfile", conn);
                updateProc.CommandType = CommandType.StoredProcedure;

                updateProc.Parameters.Clear();
                updateProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = id;
                updateProc.Parameters.Add(new SqlParameter("@name", SqlDbType.VarChar)).Value = Name;
                updateProc.Parameters.Add(new SqlParameter("@fieldOfWork", SqlDbType.VarChar)).Value = fow;

                conn.Open();
                updateProc.ExecuteNonQuery();
                conn.Close();

                Label l = new Label();
                l.Text = "Your profile has been updated successfully";
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