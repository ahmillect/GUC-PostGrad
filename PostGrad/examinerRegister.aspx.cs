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
    public partial class examinerRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (firstName.Text != "" && lastName.Text != "" && field.Text != "" && password.Text != "" && email.Text != "")
            {

                String fn = firstName.Text;
                String ln = lastName.Text;
                String pass = password.Text;
                String fow = field.Text;
                String mail = email.Text;
                int bit;
                if (isNational.Checked)
                {
                    bit = 1;
                }
                else bit = 0;

                SqlCommand regProc = new SqlCommand("examinerRegister", conn);
                regProc.CommandType = CommandType.StoredProcedure;

                regProc.Parameters.Clear();
                regProc.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = fn;
                regProc.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = ln;
                regProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;
                regProc.Parameters.Add(new SqlParameter("@fieldOfWork", SqlDbType.VarChar)).Value = fow;
                regProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
                regProc.Parameters.Add(new SqlParameter("@isNational", SqlDbType.Bit)).Value = bit;

                conn.Open();
                regProc.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("success.aspx");
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