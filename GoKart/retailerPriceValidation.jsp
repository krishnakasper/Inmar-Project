
<%@ page import ="java.util.*"%>
<%@ page import ="dob.*"%>

<jsp:useBean id="commitObject" class="dob.Commit"/>

<%
Fruits fruitsObject = new Fruits(commitObject.getDbconnection());

String retailerEmail = request.getParameter("retailerEmail");
int bananaQuantity = Integer.parseInt(request.getParameter("bananaQuantity"));
int orangeQuantity = Integer.parseInt(request.getParameter("orangeQuantity"));
int appleQuantity = Integer.parseInt(request.getParameter("appleQuantity"));
int melonQuantity = Integer.parseInt(request.getParameter("melonQuantity"));
int papayaQuantity = Integer.parseInt(request.getParameter("papayaQuantity"));
int mangoQuantity = Integer.parseInt(request.getParameter("mangoQuantity"));
int pineappleQuantity = Integer.parseInt(request.getParameter("pineappleQuantity"));
int pomegranateQuantity = Integer.parseInt(request.getParameter("pomegranateQuantity"));
int guavaQuantity = Integer.parseInt(request.getParameter("guavaQuantity"));

float bananaPrice = Float.parseFloat(request.getParameter("banana"));
float orangePrice = Float.parseFloat(request.getParameter("orange"));
float applePrice = Float.parseFloat(request.getParameter("apple"));
float melonPrice = Float.parseFloat(request.getParameter("melon"));
float papayaPrice = Float.parseFloat(request.getParameter("papaya"));
float mangoPrice = Float.parseFloat(request.getParameter("mango"));
float pineapplePrice = Float.parseFloat(request.getParameter("pineapple"));
float pomegranatePrice = Float.parseFloat(request.getParameter("pomegranate"));
float guavaPrice = Float.parseFloat(request.getParameter("guava"));
int numberOfFruits = 9;
float[] fruitsChangingPrices = {bananaPrice, orangePrice, applePrice, melonPrice, papayaPrice, mangoPrice, pineapplePrice, pomegranatePrice, guavaPrice};
int[] fruitsChangingQuantities = {bananaQuantity, orangeQuantity, appleQuantity, melonQuantity, papayaQuantity, mangoQuantity, pineappleQuantity, pomegranateQuantity, guavaQuantity};
commitObject.offCommit();
commitObject.runCommit();
if(fruitsObject.changeFruitsPrices(retailerEmail,fruitsChangingPrices) && fruitsObject.changeFruitsQuantity(retailerEmail,fruitsChangingQuantities))
{
	commitObject.runCommit();
	commitObject.onCommit();
%>
<script>
	
		alert("update successful");
	
</script>
<input type="hidden" id="retailerEmail" name="retailerEmail" value=<%=retailerEmail%>>


<jsp:include page="retailerHome.jsp" />

<%

}
else{
	commitObject.rollBack();
	commitObject.onCommit();
	%>
	
	<script>
	
		alert("error in updation");
	
</script>
<jsp:include page="retailerHome.jsp" />
<%
//out.println("error in updation");
}
%>