
<script>
    function error(){
        alert("error occured.!\nIf you are retailer then please check the checkBox\nIf you are shopper then please Uncheck the checkBox");
    }
	
	function notFound(){
		alert("Invalid User name or Password");
	}
 </script>
 <%@ page import ="dob.*"%>
<jsp:useBean id="commitObject" class="dob.Commit"/>

<% 
Shopper shopperObject = new Shopper(commitObject.getDbconnection());
Retailer retailerObject = new Retailer(commitObject.getDbconnection());
String inputemail = "";
inputemail = request.getParameter("inputEmail");
String inputpassword ="";
inputpassword = request.getParameter("inputPassword");
String retailer = request.getParameter("identity");
session.setAttribute("inputEmail",inputemail);
//out.println(inputemail);
//out.println(inputpassword);
//out.println(retailer);
if(retailer!=null)
{
	String password = retailerObject.searchRetailer(inputemail);
	if(inputpassword.equals(password))
	{
%>
<jsp:forward page="retailerHome.jsp"/>
<%
}
else 
{
	if(password.equals("error"))
{
%>
<script>
        error(); 
</script>
<%
}
else
{
%>
<script>
        notFound(); 
</script>
<%
}
%>
<jsp:include page="index.html" flush="true"/>

<%

//out.println(inputemail);
//out.println(inputpassword);
//out.println(retailer);
//out.println("incorrect login details");
}
}
else{
	String password = shopperObject.searchShopper(inputemail);
	if(inputpassword.equals(password))
	{
%>
<jsp:forward page="shopperHome.jsp"/>
<%
}
else 
{
	if(password.equals("error"))
{
%>
<script>
        error(); 
</script>
<%
}
else
{
%>
<script>
        notFound(); 
</script>
<%
}
%>

<jsp:include page="index.html" flush="true"/>

<%
//out.println(inputemail);
//out.println(inputpassword);
//out.println(retailer);
//out.println("incorrect login details");
}
}	

%>
