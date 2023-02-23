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
    public partial class addExDef : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addEx(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (thesisNo.Text != "" && defDate.Text != "" && exName.Text != "" && pass.Text != "" && fow.Text != "")
            {
                int thesisNum = Int16.Parse(thesisNo.Text);
                DateTime defD = DateTime.Parse(defDate.Text);
                String eName = exName.Text;
                String password = pass.Text;
                String fieldWork = fow.Text;
                int national;
                if (isNational.Checked)
                {
                    national = 1;
                }
                else national = 0;

                SqlCommand lp = new SqlCommand("AddExaminer", conn);
                lp.CommandType = CommandType.StoredProcedure;

                lp.Parameters.Clear();
                lp.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisNum;
                lp.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defD;
                lp.Parameters.Add(new SqlParameter("@ExaminerName", SqlDbType.VarChar)).Value = eName;
                lp.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar)).Value = password;
                lp.Parameters.Add(new SqlParameter("@National", SqlDbType.Bit)).Value = national;
                lp.Parameters.Add(new SqlParameter("@fieldOfWork", SqlDbType.VarChar)).Value = fieldWork;

                conn.Open();
                lp.ExecuteNonQuery();
                conn.Close();

                Label l = new Label();
                l.Text = "Examiner was added successfully";
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