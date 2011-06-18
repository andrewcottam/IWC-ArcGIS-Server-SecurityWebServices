<%@ WebService Language="C#" Class="IWCUserServices" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Security;
using System.Web.Services.Protocols;
using System.Xml;

[WebService(Namespace = "http://dev.unep-wcmc.org/iwc")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class IWCUserServices  : System.Web.Services.WebService {

    [WebMethod]
    public Boolean ValidateUser(String username, String password)
    {
        return Membership.ValidateUser(username, password);
    }
    [WebMethod]
    public String GetUser(String username)
    {
        MembershipUser user = Membership.GetUser(username);
        string[] roles = Roles.GetRolesForUser(username);
        return "username=" + username + ";id=" + user.ProviderUserKey + ";email=" + user.Email + ";roles=" + String.Join(",", roles);
    }
    [WebMethod]
    public String[] GetRoles(String username)
    {
        MembershipUser user = Membership.GetUser(username);
        return Roles.GetRolesForUser(username);
    }

    [WebMethod]
    public String RegisterUser(String username, String password,String email)
    {
        MembershipUser user;
        try
        {
            user=Membership.CreateUser(username, password, email);
        }
        catch (Exception e)
        {
            return e.Message;
        }
        if (user==null)
        {
            return "false";
        }
        else
        {
            return "true";
        }
    }

}

