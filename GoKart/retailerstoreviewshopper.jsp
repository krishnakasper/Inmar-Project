
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

    <title>Gokart</title>
	<script>
	function conformation(){
		alert("Confirm Buy");
	}
	</script>
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
					<a class="nav-link" href="#">Wallet Blalance: 
					<%
				
				Store storeObject = new Store(commitObject.getDbconnection());
				Shopper shopperObject = new Shopper(commitObject.getDbconnection());
				Fruits fruitsObject = new Fruits(commitObject.getDbconnection());
				
				String email = (String)session.getAttribute("shopperEmail");
				String retaileremail = request.getParameter("retailerEmail");
				
				out.println(shopperObject.shopperbalance(email)); 
				//out.println(retaileremail);
				if(retaileremail==null){
				retaileremail = (String)session.getAttribute("retailerEmail");
				}
				//out.println(retaileremail);
				String userName = shopperObject.getShopperName(email);
				String storename = storeObject.getstorename(retaileremail);
				 int[] quantity = fruitsObject.getfruitsQuantity(retaileremail); 
				 float[] price = fruitsObject.getfruitsPrices(retaileremail);
				%>	
					</a>
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

<main class="my-form"><%! int i=1;%>
    <div class="cotainer">
        <div class="row justify-content-center">
            <div class="col-md-8">
                    <div class="card">
					<div class="card-header">Welcome <%=userName%></div>
                        <div class="card-header">Store Name: <%=storename%></div>
						
                        <div class="card-body">
                            <form name="my-form" onsubmit="conformation()" action="purchaseValidation.jsp" method="post">
							<div class="form-group row">
                                    
									<label for="name" class="col-md-2 col-form-label text-md-right">Fruite Name</label>
									<label for="name" class="col-md-2 col-form-label text-md-right">Quantity</label>
									<label for="name" class="col-md-2 col-form-label text-md-right">Price</label>
									<input type="hidden" id="retailerEmail" name="retailerEmail" value=<%=retaileremail%>>
									<input type="hidden" id="shopperEmail" name="shopperEmail" value=<%=email%> >
						
									<a for="name" class="col-md-2 col-form-label text-md-right" href = "#">select Quantity</a>
                                    
                                </div>
							
							<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Banana</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[0]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[0]%></label>
									<input type="hidden" id="bananaPrice" name="bananaPrice" value=<%=price[0]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="banana" min="0" value = "0" class="form-control" name="banana">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Orange</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[1]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[1]%></label>
									<input type="hidden" id="orangePrice" name="orangePrice" value=<%=price[1]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="orange" min="0" value = "0" class="form-control" name="orange">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Apple</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[2]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[2]%></label>
									<input type="hidden" id="applePrice" name="applePrice" value=<%=price[2]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="apple" min="0" value = "0" class="form-control" name="apple">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Water Melon</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[3]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[3]%></label>
									<input type="hidden" id="melonPrice" name="melonPrice" value=<%=price[3]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="melon" min="0" value = "0" class="form-control" name="melon">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Papaya</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[4]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[4]%></label>
									<input type="hidden" id="papayaPrice" name="papayaPrice" value=<%=price[4]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="papaya" min="0" value = "0" class="form-control" name="papaya">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Mango</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[5]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[5]%></label>
									<input type="hidden" id="mangoPrice" name="mangoPrice" value=<%=price[5]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="mango" min="0" value = "0" class="form-control" name="mango">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Pine Apple</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[6]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[6]%></label>
									<input type="hidden" id="pineapplePrice" name="pineapplePrice" value=<%=price[6]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="pineapple" min="0" value = "0" class="form-control" name="pineapple">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">Promegranate</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[7]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[7]%></label>
									<input type="hidden" id="pomegranatePrice" name="pomegranatePrice" value=<%=price[7]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="pomegranate" min="0" value = "0" class="form-control" name="pomegranate">
                                    </div>
                                </div>
								<div class="form-group row">
                                    <label for="banana" class="col-md-2 col-form-label text-md-right">guava</label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=quantity[8]%></label>
									<label for="banana" class="col-md-2 col-form-label text-md-right"><%=price[8]%></label>
									<input type="hidden" id="guavaPrice" name="guavaPrice" value=<%=price[8]%>>
                                    <div class="col-md-2">
                                        <input type="number" id="guava" min="0" value = "0" class="form-control" name="guava">
                                    </div>
                                </div>

                                    <div class="col-md-6 offset-md-4">
                                        <button type="submit" class="btn btn-primary">
                                        Buy
                                        </button>
                                    </div>
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