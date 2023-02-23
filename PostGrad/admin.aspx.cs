using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void issueInstall(object sender, EventArgs e)
        {
            Response.Redirect("adminIssueInstallment.aspx");
        }

        protected void issueTheses(object sender, EventArgs e)
        {
            Response.Redirect("adminIssueThesesPayment.aspx");
        }

        protected void listSup(object sender, EventArgs e)
        {
            Response.Redirect("adminListSup.aspx");
        }

        protected void listTheses(object sender, EventArgs e)
        {
            Response.Redirect("adminListTheses.aspx");
        }

        protected void updateExtension(object sender, EventArgs e)
        {
            Response.Redirect("adminUpdateExtension.aspx");
        }
    }
}