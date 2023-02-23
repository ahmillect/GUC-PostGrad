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
    public partial class defense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addDef(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (thesisNo.Text != "")
            {
                int thesisNum = Int16.Parse(thesisNo.Text);
                DateTime defD = DateTime.Parse(defDate.Text);
                String defL = defLoc.Text;
                if (gucian.Checked)
                {
                    SqlCommand lp = new SqlCommand("AddDefenseGucian", conn);
                    lp.CommandType = CommandType.StoredProcedure;

                    lp.Parameters.Clear();
                    lp.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisNum;
                    lp.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defD;
                    lp.Parameters.Add(new SqlParameter("@DefenseLocation", SqlDbType.VarChar)).Value = defL;


                    conn.Open();
                    lp.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    SqlCommand lp = new SqlCommand("AddDefenseNonGucian", conn);
                    lp.CommandType = CommandType.StoredProcedure;

                    lp.Parameters.Clear();
                    lp.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisNum;
                    lp.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defD;
                    lp.Parameters.Add(new SqlParameter("@DefenseLocation", SqlDbType.VarChar)).Value = defL;


                    conn.Open();
                    lp.ExecuteNonQuery();
                    conn.Close();
                }
                Label l = new Label();
                l.Text = "Defense was added successfully";
                form1.Controls.Add(l);
            }
            else
            {
                Label l = new Label();
                l.Text = "Please fill out the fields";
                form1.Controls.Add(l);
            }
        }

        protected void addEx(object sender, EventArgs e)
        {
            Response.Redirect("addExDef.aspx");

        }
    }
}