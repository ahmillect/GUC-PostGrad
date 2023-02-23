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
    public partial class evaluatePR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void evalPR(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (thesisno.Text != "" && prnumber.Text != "")
            {

                int id = Int16.Parse((string)Session["user"]);
                int tsn = Int16.Parse(thesisno.Text);
                int progno = Int16.Parse(prnumber.Text);
                int eval;
                if (DropDownList.SelectedIndex == 0)
                {
                    eval = 0;
                }
                else if (DropDownList.SelectedIndex == 1)
                {
                    eval = 1;
                }
                else if (DropDownList.SelectedIndex == 2)
                {
                    eval = 2;
                }
                else
                    eval = 3;

                SqlCommand evaluate = new SqlCommand("EvaluateProgressReport", conn);
                evaluate.CommandType = CommandType.StoredProcedure;

                evaluate.Parameters.Clear();
                evaluate.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = id;
                evaluate.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = tsn;
                evaluate.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = progno;
                evaluate.Parameters.Add(new SqlParameter("@evaluation", SqlDbType.Int)).Value = eval;
                SqlParameter success = evaluate.Parameters.Add("@success", SqlDbType.Bit);

                success.Direction = System.Data.ParameterDirection.Output;

                conn.Open();
                evaluate.ExecuteNonQuery();
                conn.Close();
                Label l = new Label();

                if (success.Value.ToString() == "True")
                {
                    l.Text = "Thesis was evaluated successfully";
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

        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}