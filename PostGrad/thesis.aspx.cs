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
    public partial class thesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse((string)Session["user"]);

            SqlCommand myThesis = new SqlCommand("stuThesis", conn);
            myThesis.CommandType = CommandType.StoredProcedure;

            myThesis.Parameters.Clear();
            myThesis.Parameters.Add(new SqlParameter("@sid", SqlDbType.Int)).Value = id;


            SqlCommand lp = new SqlCommand("ViewAStudentPublications", conn);
            lp.CommandType = CommandType.StoredProcedure;

            lp.Parameters.Clear();
            lp.Parameters.Add(new SqlParameter("@StudentID", SqlDbType.Int)).Value = id;


            conn.Open();
            SqlDataReader rdr = myThesis.ExecuteReader(CommandBehavior.CloseConnection);
            GridView1.DataSource = rdr;
            GridView1.DataBind();
            conn.Close();

            conn.Open();
            SqlDataReader rdr1 = lp.ExecuteReader(CommandBehavior.CloseConnection);
            GridView2.DataSource = rdr1;
            GridView2.DataBind();
            conn.Close();

        }

        protected void Link_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            int thesisNo = Int16.Parse(noThes.Text);
            int pubNo = Int16.Parse(noPub.Text);

            SqlCommand lp = new SqlCommand("linkPubThesis", conn);
            lp.CommandType = CommandType.StoredProcedure;

            lp.Parameters.Clear();
            lp.Parameters.Add(new SqlParameter("@PubID", SqlDbType.Int)).Value = pubNo;
            lp.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = thesisNo;
            SqlParameter success = lp.Parameters.Add("@success", SqlDbType.Bit);

            success.Direction = System.Data.ParameterDirection.Output;

           /* if (success.Value.ToString() == "True") 
            {*/
                
            conn.Open();
            lp.ExecuteNonQuery();
            conn.Close();
            Label l = new Label();
            l.Text = "You successfully linked the publication to the thesis";
            form1.Controls.Add(l);
           
            /*}

          /*  else
            {
                Label l = new Label();
                l.Text = "You have to link the publication to an on going Thesis";
                form1.Controls.Add(l);
            }*/









        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            calBox.Text = Calendar1.SelectedDate.ToShortDateString();
        }

        protected void addRep_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGrad"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse((string)Session["user"]);

            int thesisNo = Int16.Parse(noThes1.Text);
            int pubNo = Int16.Parse(repNum.Text);

            String cal = calBox.Text;

            SqlCommand addRep = new SqlCommand("AddProgressReport", conn);
            addRep.CommandType = CommandType.StoredProcedure;

            addRep.Parameters.Clear();
            addRep.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = id;
            addRep.Parameters.Add(new SqlParameter("@progressReportDate", SqlDbType.VarChar)).Value = cal;
            addRep.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = thesisNo;
            addRep.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = pubNo;

            int state = Int16.Parse(stateNo.Text);
            String desc = descBox.Text;


            SqlCommand fillRep = new SqlCommand("FillProgressReport", conn);
            fillRep.CommandType = CommandType.StoredProcedure;

            fillRep.Parameters.Clear();
            fillRep.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = id;
            fillRep.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = thesisNo;
            fillRep.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = pubNo;
            fillRep.Parameters.Add(new SqlParameter("@state", SqlDbType.Int)).Value = state;
            fillRep.Parameters.Add(new SqlParameter("@description", SqlDbType.VarChar)).Value = desc;

            if (cal.Length != 0 && desc.Length != 0 && stateNo.Text.Length != 0 && noThes1.Text.Length != 0 && repNum.Text.Length != 0)
            {


                conn.Open();
                addRep.ExecuteNonQuery();
                conn.Close();


                conn.Open();
                fillRep.ExecuteNonQuery();
                conn.Close();

                Label l = new Label();
                l.Text = "You successfully added and filled a progress report";
                form1.Controls.Add(l);


            }

            else
            {
                Label l = new Label();
                l.Text = "Make sure to fill all the requirments above";
                form1.Controls.Add(l);

            }






        }
    }
}