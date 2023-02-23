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
    public partial class studentRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (firstName.Text != "" && lastName.Text != "" && faculty.Text != "" && password.Text != "" && email.Text != "" && address.Text != "")
            {
                String fn = firstName.Text;
                String ln = lastName.Text;
                String pass = password.Text;
                String fac = faculty.Text;
                String mail = email.Text;
                String add = address.Text;
                int bit;
                if (Gucian.Checked)
                {
                    bit = 1;
                }
                else bit = 0;

                SqlCommand regProc = new SqlCommand("studentRegister", conn);
                regProc.CommandType = CommandType.StoredProcedure;

                regProc.Parameters.Clear();
                regProc.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = fn;
                regProc.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = ln;
                regProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;
                regProc.Parameters.Add(new SqlParameter("@faculty", SqlDbType.VarChar)).Value = fac;
                regProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
                regProc.Parameters.Add(new SqlParameter("@address", SqlDbType.VarChar)).Value = add;
                regProc.Parameters.Add(new SqlParameter("@Gucian", SqlDbType.Bit)).Value = bit;

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