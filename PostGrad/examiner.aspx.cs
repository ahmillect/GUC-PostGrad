using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad
{
    public partial class examiner : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void editInfo(object sender, EventArgs e)
        {
            Response.Redirect("editInfo.aspx");
        }
        protected void listAll(object sender, EventArgs e)
        {
            Response.Redirect("listAll.aspx");
        }
        protected void addComment(object sender, EventArgs e)
        {
            Response.Redirect("addComment.aspx");
        }
        protected void addGrade(object sender, EventArgs e)
        {
            Response.Redirect("addGrade.aspx");
        }
        protected void searchThesis(object sender, EventArgs e)
        {
            Response.Redirect("searchThesis.aspx");
        }
    }
}