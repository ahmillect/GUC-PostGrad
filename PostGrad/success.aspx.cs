using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad
{
    public partial class popup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void redirect(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}