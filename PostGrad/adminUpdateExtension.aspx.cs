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
    public partial class adminUpdateExtension : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void updateExtensionBtn_Click(object sender, EventArgs e)
        {
            int thesisSerial = 0;
            
            if (!string.IsNullOrEmpty(thesesSerialTB.Text))
            {
                if (!(int.TryParse(thesesSerialTB.Text, out thesisSerial)))
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

            SqlCommand updateExtensionProcedure = new SqlCommand("AdminUpdateExtension", conn);
            updateExtensionProcedure.CommandType = CommandType.StoredProcedure;

            updateExtensionProcedure.Parameters.Clear();
            updateExtensionProcedure.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisSerial;

            conn.Open();

            int affectedRowsCount = updateExtensionProcedure.ExecuteNonQuery();

            if (affectedRowsCount > 0)
                Response.Write("Extension updated successfully.");
            else
                Response.Write("Extension update failed.");

            conn.Close();
        }
    }
}