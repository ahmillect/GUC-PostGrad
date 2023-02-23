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
    public partial class adminIssueThesesPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void issueThesesPaymentBtn_Click(object sender, EventArgs e)
        {
            int thesisSerial = 0;
            decimal paymentAmmount = 0;
            int installmentsCount = 0;
            decimal fundPercentage = 0;

            if (!string.IsNullOrEmpty(thesesSerialTB.Text) && !string.IsNullOrEmpty(paymentAmmountTB.Text)
                && !string.IsNullOrEmpty(noInstallmentsTB.Text) && !string.IsNullOrEmpty(fundPercentageTB.Text))
            {
                if (!(int.TryParse(thesesSerialTB.Text, out thesisSerial) && decimal.TryParse(paymentAmmountTB.Text, out paymentAmmount)
                    && int.TryParse(noInstallmentsTB.Text, out installmentsCount) && decimal.TryParse(fundPercentageTB.Text, out fundPercentage)))
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

            SqlCommand issueThesisPaymentProcedure = new SqlCommand("AdminIssueThesisPayment", conn);
            issueThesisPaymentProcedure.CommandType = CommandType.StoredProcedure;

            issueThesisPaymentProcedure.Parameters.Clear();
            issueThesisPaymentProcedure.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisSerial;
            issueThesisPaymentProcedure.Parameters.Add(new SqlParameter("@amount", SqlDbType.Decimal)).Value = paymentAmmount;
            issueThesisPaymentProcedure.Parameters.Add(new SqlParameter("@noOfInstallments", SqlDbType.Int)).Value = installmentsCount;
            issueThesisPaymentProcedure.Parameters.Add(new SqlParameter("@fundPercentage", SqlDbType.Decimal)).Value = fundPercentage;

            conn.Open();

            int affectedRowsCount = issueThesisPaymentProcedure.ExecuteNonQuery();

            if (affectedRowsCount > 0)
                Response.Write("Payment issued successfully.");
            else
                Response.Write("Payment failed.");

            conn.Close();
        }
    }
}