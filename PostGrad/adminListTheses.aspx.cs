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
    public partial class adminListTheses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(cStr);

            SqlCommand listingThesisProcedure = new SqlCommand("AdminViewAllTheses", conn);
            listingThesisProcedure.CommandType = CommandType.StoredProcedure;

            SqlCommand ongoingThesisProcedure = new SqlCommand("AdminViewOnGoingTheses", conn);
            ongoingThesisProcedure.CommandType = CommandType.StoredProcedure;
            
            ongoingThesisProcedure.Parameters.Clear();
            var rawOngoingThesisCount = ongoingThesisProcedure.Parameters.Add("@thesesCount", SqlDbType.Int);
            rawOngoingThesisCount.Direction = ParameterDirection.Output;

            conn.Open();

            ongoingThesisProcedure.ExecuteNonQuery();
            var rawSupervisors = listingThesisProcedure.ExecuteReader();


            thesesGrid.DataSource = rawSupervisors;
            thesesGrid.DataBind();

            onGoingThesesCount.Text = "Current Ongoing Thesis Count: " + rawOngoingThesisCount.Value;

            conn.Close();
        }
    }
}