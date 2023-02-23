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
    public partial class addGrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Grade(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (date.Text != "" && grades.Text != "")
            {

                int id = Int16.Parse(thesisNo.Text);
                DateTime dt = DateTime.Parse(date.Text);
                //??
                string s = (Convert.ToDouble(grades.Text) / 100).ToString("0.00");
                Decimal grd = Convert.ToDecimal(s);

                SqlCommand gradesProc = new SqlCommand("AddDefenseGrade", conn);
                gradesProc.CommandType = CommandType.StoredProcedure;

                gradesProc.Parameters.Clear();
                gradesProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = id;
                gradesProc.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = dt;
                gradesProc.Parameters.Add(new SqlParameter("@grade", SqlDbType.Decimal)).Value = grd;

                conn.Open();
                gradesProc.ExecuteNonQuery();
                conn.Close();

                Label l = new Label();
                l.Text = "Grades were added successfully";
                form1.Controls.Add(l);
            } else
            {
                Label l = new Label();
                l.Text = "Please fill out the fields";
                form1.Controls.Add(l);
            }
        }
    }
}