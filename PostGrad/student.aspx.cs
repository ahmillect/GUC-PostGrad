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
    public partial class student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void phone_Click(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String pn = phoneBox.Text;
            int id = Int16.Parse((string)Session["user"]);

            SqlCommand addMobileProc = new SqlCommand("addMobile", conn);
            addMobileProc.CommandType = CommandType.StoredProcedure;


            addMobileProc.Parameters.Clear();
            addMobileProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = id;
            addMobileProc.Parameters.Add(new SqlParameter("@mobile_number", SqlDbType.VarChar)).Value = pn;


            if (pn.Length == 11)
            {
                conn.Open();
                addMobileProc.ExecuteNonQuery();
                conn.Close();
                Label l = new Label();
                l.Text = "You successfully added a new number";
                stu.Controls.Add(l);
            }

            else
            {
                Label l = new Label();
                l.Text = "Enter a number of 11 digit";
                stu.Controls.Add(l);
            }


        }

        protected void selectInfo_Click(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedIndex == 0)
            {
                Response.Redirect("personalInfo.aspx");
            }

            else if (DropDownList1.SelectedIndex == 1)
            {
                Response.Redirect("courses.aspx");
            }

            else if (DropDownList1.SelectedIndex == 2)
            {
                Response.Redirect("thesis.aspx");
            }
        }

        

        protected void addPub_Click1(object sender, EventArgs e)
        {
            Response.Redirect("publication.aspx");
        }
    }
}