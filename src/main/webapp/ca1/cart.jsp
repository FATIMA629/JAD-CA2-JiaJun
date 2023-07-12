<%@ page import="java.util.List"%>
<%@page import="Books.Book , Books.BookDao , Cart.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%
// Retrieve the cart items from the session
List<Book> cartItems = (List<Book>) session.getAttribute("cartItems");
%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <!—customised CSS -->

<link href="css/cart.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <!—compiled & minified CSS -->

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link
	href="https://fonts.googleapis.com/css?family=Montserrat&display=swap"
	rel="stylesheet">
<!-- <!—jQuery library -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- <!—compile JavaScript -->

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<!-- Axios -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<%
	CartDao cartDao = new CartDao();
	%>

	<div class="container-fluid"
		style="background-color: #f1f1f1; height: 100%;">
		<div class="cart-header">
			<h3>Shopping Cart</h3>
			<hr class="browse-line">
		</div>
		<div class="row"
			style="display: flex; justify-content: center; position: relative; top: 20px;">
			<div class="row"
				style="width: 89%; height: 55px; background-color: white; margin: 0 auto; border-radius: 5px; margin-bottom: 20px">
				<div class="col-6 horizontal-center">
					<span class="text-color">Product</span>
				</div>
				<div class="col-2 center">
					<span class="text-color">Price</span>
				</div>
				<div class="col-3 center">
					<span class="text-color">Quantity</span>
				</div>
				<div class="col-1 center">
					<span class="text-color">Action</span>
				</div>
			</div>
			<%
			for (Book item : cartItems) {
			%>
			<div class="item-container"
				style="width: 89%; height: 150px; margin: 0 auto; border-radius: 5px; border: 1px solid rgba(0, 0, 0, .4); background-color: rgb(221, 221, 221);">
				<div class="row">
					<div class="col-6 p-3">
						<img src="<%=item.getImageLocation()%>" alt="<%=item.getTitle()%>"
							style="height: 120px; width: 90px" /> <span
							style="font-size: 15px;"><%=item.getTitle()%></span>
					</div>
					<div class="col-2 center">
						<span><%=Double.toString(item.getPrice())%></span>
					</div>
					<div class="col-3 center">
						<button class="minus-button">-</button>
						<input type="text"
							value="<%=cartDao.getQuantity(1, Integer.parseInt(item.getBookId()))%>"
							class="quantity-input">
						<button class="plus-button">+</button>
					</div>
					<div class="col-1 center">
						<button class="delete">Delete</button>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>


<script>
	var quantityCounter = document.querySelector('.quantity-input');
	var minusButton = document.querySelector('.minus-button');
	var plusButton = document.querySelector('.plus-button');

	minusButton.addEventListener('click', function() {
		var currentQuantity = parseInt(quantityCounter.value);
		if (currentQuantity > 1) {
			quantityCounter.value = currentQuantity - 1;
		}
	});

	plusButton.addEventListener('click', function() {
		var currentQuantity = parseInt(quantityCounter.value);
		quantityCounter.value = currentQuantity + 1;
	});
</script>
</html>



