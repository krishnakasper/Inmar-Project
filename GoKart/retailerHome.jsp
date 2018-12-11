
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

    <title>Retailer Home</title>
</head>

<%@ page import ="java.util.*"%>
<%@ page import ="dob.*"%>

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
				
				Retailer retailerObject = new Retailer(commitObject.getDbconnection());
				Store storeObject = new Store(commitObject.getDbconnection());
				Fruits fruitsObject = new Fruits(commitObject.getDbconnection());
				
				String retaileremail = (String)session.getAttribute("inputEmail");
				//session.setAttribute("retaileremail",email);
				if(retaileremail==null)
					retaileremail = request.getParameter("retailerEmail");
				out.println(retailerObject.retailerbalance(retaileremail));
				String storename = storeObject.getstorename(retaileremail);

				%>	</a>
				</li>
				<li class="nav-item">
					<form name="my-form" action="transactions.jsp" method="post">
						<input type="hidden" id="email" name="email" value=<%=retaileremail%>>
						<input type="hidden" id="retailerCheck" name="retailerCheck" value="true">
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
<%

int[] quantity = fruitsObject.getfruitsQuantity(retaileremail);
float[] price = fruitsObject.getfruitsPrices(retaileremail);
%>
	<main class="my-form"><%! int i=0;%>
		<div class="cotainer">
			<div class="row justify-content-center">
				<div class="col-md-8">
                    <div class="card">
                        <div class="card-header">Store Name: <%=storename%></div>
						<div class="card-header">Welcome Retailer...</div>
						<div class="card-header">Your mail: <%=retaileremail%></div>
						<input type="hidden" id="Email" name="Email" value=<%=retaileremail%>>
						<input type="hidden" id="retailerCheck" name="retailerCheck" value="true">
                        <div class="card-body">
                            <form name="my-form" onsubmit="conformation()" action="retailerPriceValidation.jsp" method="post">
								<div class="form-group row">
									<label  class="col-md-2 col-form-label text-md-right">Fruite Name</label>
									<label  class="col-md-2 col-form-label text-md-right">Available Quantity</label>
									<label  class="col-md-2 col-form-label text-md-right">Change Quantity</label>
									<label  class="col-md-2 col-form-label text-md-right">Current Price</label>
									<input type="hidden" id="retailerEmail" name="retailerEmail" value=<%=retaileremail%>>
									<a for="name" class="col-md-2 col-form-label text-md-right" href = "#">Change Price</a>
                                </div>
							
								<div class="form-group row">
                                    <label  class="col-md-2 col-form-label text-md-right">Banana</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[0]%></label>
									<div class="col-md-2">
                                        <input type="number" id="bananaQuantity" min="0" value = <%=quantity[0]%> step = "1" class="form-control" name="bananaQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[0]%></label>
                                    <div class="col-md-2">
                                        <input type="number" id="banana" min="0" value = <%=price[0]%> step = "0.1" class="form-control" name="banana">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Orange</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[1]%></label>
									<div class="col-md-2">
                                        <input type="number" id="orangeQuantity" min="0" value = <%=quantity[1]%> step = "1" class="form-control" name="orangeQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[1]%></label>
                                    <div class="col-md-2">
                                        <input type="number" id="orange" min="0" value = <%=price[1]%> step = "0.1" class="form-control" name="orange">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Apple</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[2]%></label>
									<div class="col-md-2">
                                        <input type="number" id="appleQuantity" min="0" value = <%=quantity[2]%> step = "1" class="form-control" name="appleQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[2]%></label>
									<input type="hidden" id="applePrice" name="applePrice" value=<%=price[2]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="apple" min="0" value = <%=price[2]%> step = "0.1" class="form-control" name="apple">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Water Melon</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[3]%></label>
									<div class="col-md-2">
                                        <input type="number" id="melonQuantity" min="0" value = <%=quantity[3]%> step = "1" class="form-control" name="melonQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[3]%></label>
									<input type="hidden" id="melonPrice" name="melonPrice" value=<%=price[3]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="melon" min="0" value = <%=price[3]%> step = "0.1" class="form-control" name="melon">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Papaya</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[4]%></label>
									<div class="col-md-2">
                                        <input type="number" id="papayaQuantity" min="0" value = <%=quantity[4]%> step = "1" class="form-control" name="papayaQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[4]%></label>
									<input type="hidden" id="papayaPrice" name="papayaPrice" value=<%=price[4]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="papaya" min="0" value = <%=price[4]%> step = "0.1" class="form-control" name="papaya">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Mango</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[5]%></label>
									<div class="col-md-2">
                                        <input type="number" id="mangoQuantity" min="0" value = <%=quantity[5]%> step = "1" class="form-control" name="mangoQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[5]%></label>
									<input type="hidden" id="mangoPrice" name="mangoPrice" value=<%=price[5]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="mango" min="0" value = <%=price[5]%> step = "0.1" class="form-control" name="mango">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Pine Apple</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[6]%></label>
									<div class="col-md-2">
                                        <input type="number" id="pineappleQuantity" min="0" value = <%=quantity[6]%> step = "1" class="form-control" name="pineappleQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[6]%></label>
									<input type="hidden" id="pineapplePrice" name="pineapplePrice" value=<%=price[6]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="pineapple" min="0" value = <%=price[6]%> step = "0.1" class="form-control" name="pineapple">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Promegranate</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[7]%></label>
									<div class="col-md-2">
                                        <input type="number" id="pomegranateQuantity" min="0" value = <%=quantity[7]%> step = "1" class="form-control" name="pomegranateQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[7]%></label>
									<input type="hidden" id="pomegranatePrice" name="pomegranatePrice" value=<%=price[7]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="pomegranate" min="0" value = <%=price[7]%> step = "0.1" class="form-control" name="pomegranate">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">guava</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[8]%></label>
									<div class="col-md-2">
                                        <input type="number" id="guavaQuantity" min="0" value = <%=quantity[8]%> step = "1" class="form-control" name="guavaQuantity">
                                    </div>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[8]%></label>
									<input type="hidden" id="guavaPrice" name="guavaPrice" value=<%=price[8]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="guava" min="0" value = <%=price[8]%> step = "0.1" class="form-control" name="guava">
                                    </div>
                                </div>

                                <div class="col-md-6 offset-md-4">
                                    <button type="submit" class="btn btn-primary">
                                        Update
                                    </button>
                                </div>
                                
                            </form>
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