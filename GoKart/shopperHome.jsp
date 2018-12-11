
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

    <title>Shopper Home</title>
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
					<a class="nav-link" href="#">Wallet Blalance: <%
				Shopper shopperObject = new Shopper(commitObject.getDbconnection());
				Store storeObject = new Store(commitObject.getDbconnection());
				String email = request.getParameter("inputEmail");
				if(email==null){
					email = (String)session.getAttribute("shopperEmail");
				}
				session.setMaxInactiveInterval(5*60);
				session.setAttribute("shopperEmail",email);
				
				
				String userName = shopperObject.getShopperName(email);
				out.println(shopperObject.shopperbalance(email)); %></a>
				</li>
				<li class="nav-item">
					<form name="my-form" action="transactions.jsp" method="post">
						<input type="hidden" id="email" name="email" value=<%=email%>>
						<input type="hidden" id="retailerCheck" name="retailerCheck" value="false">
						<div class="col-md-1 offset-md-1">
                            <button type="submit" class="btn btn-primary">
                                Transactions
                            </button>
                                    
						</div>
					</form>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="index.html">Logout</a>
				</li>
            
			</ul>

		</div>
    </div>
</nav>

<main class="my-form">
    <div class="cotainer">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
					<div class="card-header">Welcome <%=userName %></div>
					<div class="card-header">Available Stores near you..</div>
                    <div class="card-body">
						<div class="form-group row">
							<label for="name" class="col-md-4 col-form-label text-md-right">Store Name</label>
							<label for="name" class="col-md-4 col-form-label text-md-right">Retailer Name</label>
                        </div>
						<% 
						ArrayList<ArrayList<String>> result = storeObject.availableStores();
							
						ArrayList<String> list = result.get(0);
						ArrayList<String> retailer = result.get(1);
						ArrayList<String> retailersemails = result.get(2);
						int size = list.size();
						//out.println(size);
						for(int i=0;i<size;i++)
						{%>
						<form name="my-form"  action="retailerstoreviewshopper.jsp" method="post">
                            <div class="form-group row">
								<label id = "label" name="label" for="name" class="col-md-4 col-form-label text-md-right"><%out.println(list.get(i));%></label>
								<label for="name" class="col-md-4 col-form-label text-md-right"><%String s = retailersemails.get(i); out.println(retailer.get(i));%></label>
								<input type="hidden" id="retailerEmail" name="retailerEmail" value=<%=retailersemails.get(i)%>>
                                <button type="submit" class="col-md-1 btn ">
                                    Visit
                                </button>
                            </div>
						</form>
						<%}%>
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