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
    public partial class adminListSup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(cStr);

            SqlCommand listingSupProcedure = new SqlCommand("AdminListSup", conn);
            listingSupProcedure.CommandType = CommandType.StoredProcedure;

            conn.Open();

            var rawSupervisors = listingSupProcedure.ExecuteReader();

            supGrid.DataSource = rawSupervisors;
            supGrid.DataBind();

            conn.Close();
        }
    }
}