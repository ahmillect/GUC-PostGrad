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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (email.Text != "" && password.Text != "")
            {
                String mail = email.Text;
                String pass = password.Text;

                SqlCommand loginProc = new SqlCommand("userLogin", conn);
                loginProc.CommandType = CommandType.StoredProcedure;
                SqlCommand sessionProc = new SqlCommand("getSessionID", conn);
                sessionProc.CommandType = CommandType.StoredProcedure;

                loginProc.Parameters.Clear();
                loginProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
                loginProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;
                sessionProc.Parameters.Clear();
                sessionProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = mail;
                sessionProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = pass;

                SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Bit);
                SqlParameter type = loginProc.Parameters.Add("@type", SqlDbType.Int);
                SqlParameter id = sessionProc.Parameters.Add("@id", SqlDbType.Int);

                success.Direction = System.Data.ParameterDirection.Output;
                type.Direction = System.Data.ParameterDirection.Output;
                id.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                loginProc.ExecuteNonQuery();
                sessionProc.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "True")
                {
                    Session["user"] = id.Value.ToString();

                    if (type.Value.ToString() == "0")
                    {
                        Response.Redirect("student.aspx");
                    }
                    else if (type.Value.ToString() == "1")
                    {
                        Response.Redirect("admin.aspx");
                    }
                    else if (type.Value.ToString() == "2")
                    {
                        Response.Redirect("supervisor.aspx");
                    }
                    else if (type.Value.ToString() == "3")
                    {
                        Response.Redirect("examiner.aspx");
                    }
                }
                else
                {
                    Response.Write("Please enter a valid email/password");
                }
            }
            else
            {
                Label l = new Label();
                l.Text = "Please enter a valid email/password";
                form1.Controls.Add(l);
            }
        }

        protected void register(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");

        }
    }
}