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

Fruits fruitsObject = new Fruits(commitObject.getDbconnection());
Retailer retailerObject = new Retailer(commitObject.getDbconnection());
Store storeObject = new Store(commitObject.getDbconnection());

String name = request.getParameter("name");
String email = request.getParameter("email");
String phone = request.getParameter("phone_number");
String storename = request.getParameter("store_name");
String address = request.getParameter("store_address");
String password = request.getParameter("password");
String pan = request.getParameter("pan");
commitObject.offCommit();
commitObject.runCommit();
String result = retailerObject.insertRetailer(name,email,phone,password,pan,3500);
String storeResult = storeObject.insertStore(email, storename, address);
boolean initailizeFruitsStore = fruitsObject.initializeFruits(email);

if(result.equals("success")&& storeResult.equals("success") && initailizeFruitsStore)
{
	commitObject.runCommit();
	commitObject.onCommit();
%>
<script>
       success(); 
</script>

<jsp:include page="index.html"/>

<%

}
else 
{	
commitObject.rollBack();
commitObject.onCommit();
if(result.equals("duplicationError") || storeResult.equals("duplicationError"))
{
%>
<script>
        duplicationError(); 
</script>
<%
}
else if(request.equals("sqlError") || storeResult.equals("sqlError"))
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
<jsp:include page="retailerRegistration.html" flush="true"/>

<%
//out.println(name);
//out.println(email);
//out.println(phone);
//out.println(result);
//out.println(storeResult);
}
%>