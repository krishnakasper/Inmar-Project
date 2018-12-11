
<script>
    function purchaseLimit(){
		alert("only 1 purchase from a retailer\ntry another retailer..");
	}
	
	function countLimit(){
		alert("minimum of 3 types fruits must be purchased"):
	}
	
	function success(){
		alert("Purchase Successful..");
	}
	
	function lessamount(){
		alert("purchase amount less than 100.");
	}
	
</script>
 
<%@ page import ="java.util.*"%>
<%@ page import ="dob.*"%>

<jsp:useBean id="commitObject" class="dob.Commit"/>


<%

String shopperEmail = request.getParameter("shopperEmail");
String retailerEmail = request.getParameter("retailerEmail");

int[] requriedquantity = new int[9];
int bananaquantity = Integer.parseInt(request.getParameter("banana"));
int orangequantity = Integer.parseInt(request.getParameter("orange"));
int applequantity = Integer.parseInt(request.getParameter("apple"));
int melonquantity = Integer.parseInt(request.getParameter("melon"));
int papayaquantity = Integer.parseInt(request.getParameter("papaya"));
int mangoquantity = Integer.parseInt(request.getParameter("mango"));
int pineapplequantity = Integer.parseInt(request.getParameter("pineapple"));
int pomegranatequantity = Integer.parseInt(request.getParameter("pomegranate"));
int guavaquantity = Integer.parseInt(request.getParameter("guava"));
requriedquantity[0] = bananaquantity;
requriedquantity[1] = orangequantity;
requriedquantity[2] = applequantity;
requriedquantity[3] = melonquantity;
requriedquantity[4] = papayaquantity;
requriedquantity[5] = mangoquantity;
requriedquantity[6] = pineapplequantity;
requriedquantity[7] = pomegranatequantity;
requriedquantity[8] = guavaquantity;
float bananaPrice = Float.parseFloat(request.getParameter("bananaPrice"));
float orangePrice = Float.parseFloat(request.getParameter("orangePrice"));
float applePrice = Float.parseFloat(request.getParameter("applePrice"));
float melonPrice = Float.parseFloat(request.getParameter("melonPrice"));
float papayaPrice = Float.parseFloat(request.getParameter("papayaPrice"));
float mangoPrice = Float.parseFloat(request.getParameter("mangoPrice"));
float pineapplePrice = Float.parseFloat(request.getParameter("pineapplePrice"));
float pomegranatePrice = Float.parseFloat(request.getParameter("pomegranatePrice"));
float guavaPrice = Float.parseFloat(request.getParameter("guavaPrice"));
float price = bananaPrice*bananaquantity+orangePrice*orangequantity+applePrice*applequantity+melonPrice*melonquantity+papayaPrice*papayaquantity+mangoPrice*mangoquantity+pineapplePrice*pineapplequantity+pomegranatePrice*pomegranatequantity+guavaPrice*guavaquantity; 

Shopper shopperObject = new Shopper(commitObject.getDbconnection());
Fruits fruitsObject = new Fruits(commitObject.getDbconnection());
Transactions transactionObject = new Transactions(commitObject.getDbconnection());

float balance = shopperObject.shopperbalance(shopperEmail);
int[] quantity = fruitsObject.getfruitsQuantity(retailerEmail);
int flag=1;
commitObject.offCommit();
commitObject.runCommit();
int count=0;
for(int i=0;i<9;i++)
{
	if(requriedquantity[i]>0)
	{
		count++;
	}
}
for(int i=0;i<9;i++)
{
	if(quantity[i]<requriedquantity[i])
	{
		flag=0;
		break;
	}
}

if(shopperObject.shopperPurchaseRetailer(shopperEmail,retailerEmail))
{
%>
<script>
	function purchaseLimit(){
		alert("only 1 purchase from a retailer\ntry another retailer..");
	}
	
    purchaseLimit(); 
</script>

<jsp:include page="shopperHome.jsp"/>
<%
}
else if(price<100)
{
	%>
<script>
		function lessamount(){
		alert("minimum purchase amount is 100.\nBut your purchase amount is <%=price%>");
	}
        lessamount(); 
</script>

<jsp:include page="shopperHome.jsp"/>
<%
}
else if(count<3)
{
	%>
<script>
        function count(){
		alert("minimum 3 items.but you have selected <%=count%> items");
	}
        count(); 
</script>

<jsp:include page="shopperHome.jsp"/>
	<%
}
else if(price<=balance && flag==1 ){
	commitObject.offCommit();
	commitObject.runCommit();
	if(	fruitsObject.updateFruitsQuantity(retailerEmail,requriedquantity) && transactionObject.maketransaction(price,shopperEmail,retailerEmail))
	{
		commitObject.runCommit();
	}
	else
	{
		commitObject.rollBack();
	}
	commitObject.onCommit();
	session.setAttribute("shopperEmail",shopperEmail);
	session.setAttribute("retailerEmail",retailerEmail);
	
%>
<script>
        function success(){
		alert("Purchase Successful..");
	}
		success(); 
</script>

<jsp:include page="shopperHome.jsp"/>

<%
}
else{
	%>
<script>
        function error(){
		alert("error occured.");
	}
		success(); 
</script>
<jsp:include page="retailerstoreviewshopper.jsp" flush="true"/>
<%
}
%>