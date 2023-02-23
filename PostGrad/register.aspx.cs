using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void student(object sender, EventArgs e)
        {
            Response.Redirect("studentRegister.aspx");
        }
        protected void supervisor(object sender, EventArgs e)
        {
            Response.Redirect("supervisorRegister.aspx");
        }
        protected void examiner(object sender, EventArgs e)
        {
            Response.Redirect("examinerRegister.aspx");
        }
    }
}