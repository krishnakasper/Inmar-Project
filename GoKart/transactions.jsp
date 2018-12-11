
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Fonts -->
    <link rel="dns-prefetch" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,600" rel="stylesheet" type="text/css">



    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="bootstrapcore.css">

    <title>Transaction History</title>
</head>

<%@ page import ="dob.*"%>
<%@ page import ="java.util.*"%>
<jsp:useBean id="commitObject" class="dob.Commit"/>

<body>

<nav class="navbar navbar-expand-lg navbar-light navbar-laravel">
    <div class="container">
		<a class="navbar-brand" href="#">GoKart</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item">
					<a class="nav-link" href="#">Wallet Blalance: 
						<%
						String email = request.getParameter("email");

						Transactions transactionObject = new Transactions(commitObject.getDbconnection());
				
						String retailerCheck = request.getParameter("retailerCheck");
						if(retailerCheck.equals("true")){
						Retailer retailerObject = new Retailer(commitObject.getDbconnection());
						out.println(retailerObject.retailerbalance(email));
						}
						else{
						Shopper shopperObject = new Shopper(commitObject.getDbconnection());
						out.println(shopperObject.shopperbalance(email));
						}
						%>	
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="index.html">Logout</a>
				</li>
			</ul>
		</div>
    </div>
</nav>
<%

ArrayList<String[]> transactionList = transactionObject.getTransactionList(email, retailerCheck);

%>
<main class="my-form"><%! int i=1;%>
    <div class="cotainer">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
					<div class="card-header">Your mail: <%=email%></div>
                    <div class="card-body">
						<div class="form-group row">
                            <label for="name" class="col-md-2 col-form-label text-md-right">ID</label>
							<label for="name" class="col-md-2 col-form-label text-md-right">Date</label>
							<label for="name" class="col-md-2 col-form-label text-md-right">From</label>
							<label for="name" class="col-md-2 col-form-label text-md-right">To</label>
							<label for="name" class="col-md-2 col-form-label text-md-right">Amount</label>
							<input type="hidden" id="retailerEmail" name="retailerEmail" value=<%=email%>>
																		                                  
                        </div>
						<%
						for(int i=0;i<transactionList.size();i++)
							{
								String[] transaction = transactionList.get(i);
						%>
						<div class="form-group row">
							<label for="banana" class="col-md-2 col-form-label text-md-right"><%=transaction[0]%></label>
                            <label for="banana" class="col-md-2 col-form-label text-md-right"><%=transaction[1]%></label>
							<label for="banana" class="col-md-2 col-form-label text-md-right"><%=transaction[3]%></label>
							<label for="banana" class="col-md-2 col-form-label text-md-right"><%=transaction[2]%></label>
							<label for="banana" class="col-md-2 col-form-label text-md-right"><%=transaction[4]%></label>
                                    
                        </div>
						<%}
						%>  
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>