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
    public partial class supervisor : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void listStudent(object sender, EventArgs e)
        {
            Response.Redirect("listStudent.aspx");
        }
        protected void listPublication(object sender, EventArgs e)
        {
            Response.Redirect("listPublication.aspx");
        }
        protected void defense(object sender, EventArgs e)
        {
            Response.Redirect("defense.aspx");
        }
        protected void evaluatePR(object sender, EventArgs e)
        {
            Response.Redirect("evaluatePR.aspx");
        }
        protected void cancelThesis(object sender, EventArgs e)
        {
            Response.Redirect("cancelThesis.aspx");
        }
    }
}