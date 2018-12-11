<script>
    function duplicationError(){
        alert("Similar details already exists in database.. ");
    }
	
	function sqlError(){
		alert("SQL Error");
	}
	
	function error(){
		alert("Error");
	}
	
	function success(){
		alert("Registration Successful..");
	}
	
 </script>
 
<%@ page import ="dob.*"%>
<jsp:useBean id="commitObject" class="dob.Commit"/>

<% 
Shopper shopperObject = new Shopper(commitObject.getDbconnection());
String name = request.getParameter("name");
String email = request.getParameter("email");
String phone = request.getParameter("phone_number");
String address = request.getParameter("address");
String password = request.getParameter("password");
commitObject.offCommit();
commitObject.runCommit();
String result =shopperObject.insertShopper(name,email,phone,address,password,3500);

if(result.equals("success"))
{
	commitObject.runCommit();
	commitObject.onCommit();
%>
<script>
        success(); 
</script>
<jsp:include page="index.html" flush="true"/>
<%
}
else 
{	
commitObject.rollBack();
commitObject.onCommit();
if(result.equals("duplicationError"))
{
%>
<script>
        duplicationError(); 
</script>
<%
}
else if(request.equals("sqlError"))
{
%>
<script>
        sqlError(); 
</script>

<%
}
else{
	
%>
<script>
        error(); 
</script>
<%
}
%>
<jsp:include page="shopperRegistration.html" flush="true"/>

<%

//out.println(result);
}

%>
