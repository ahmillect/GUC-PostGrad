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
    public partial class adminIssueInstallment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            installmentStartDateCalender.SelectedDate = DateTime.Today;
        }

        protected void issueInstallmentBtn_Click(object sender, EventArgs e)
        {
            int paymentID = 0;
            DateTime installmentStartDate = DateTime.Today;

            if (!string.IsNullOrEmpty(paymentIDTB.Text) && installmentStartDateCalender.SelectedDate != null)
            {
                if (!(int.TryParse(paymentIDTB.Text, out paymentID)))
                {
                    Response.Write("One or more inputs is not valid, please check your inputs format.");
                    return;
                }
            }
            else
            {
                Response.Write("One or more inputs is empty, please fill all the fields.");
                return;
            }

            string cStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(cStr);

            SqlCommand issueInstallmentProcedure = new SqlCommand("AdminIssueInstallPayment", conn);
            issueInstallmentProcedure.CommandType = CommandType.StoredProcedure;

            issueInstallmentProcedure.Parameters.Clear();
            issueInstallmentProcedure.Parameters.Add(new SqlParameter("@paymentID", SqlDbType.Int)).Value = paymentID;
            issueInstallmentProcedure.Parameters.Add(new SqlParameter("@InstallStartDate", SqlDbType.DateTime)).Value = installmentStartDate.ToString();

            conn.Open();

            int affectedRowsCount = issueInstallmentProcedure.ExecuteNonQuery();

            if (affectedRowsCount > 0)
                Response.Write("Installment issued successfully.");
            else
                Response.Write("Installment failed.");

            conn.Close();
        }
    }
}