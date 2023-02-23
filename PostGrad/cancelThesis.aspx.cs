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
    public partial class cancelThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cancel(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (thesisno.Text != "")
            {
                int thesisNo = Int16.Parse(thesisno.Text);

                SqlCommand clr = new SqlCommand("CancelThesis", conn);
                clr.CommandType = CommandType.StoredProcedure;

                clr.Parameters.Clear();
                clr.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisNo;

                SqlParameter success = clr.Parameters.Add("@success", SqlDbType.Bit);

                success.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                clr.ExecuteNonQuery();
                conn.Close();
                Label l = new Label();

                if (success.Value.ToString() == "True")
                {
                    l.Text = "Thesis was cancelled successfully";
                }
                else
                {
                    l.Text = "Thesis was not found";

                }
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