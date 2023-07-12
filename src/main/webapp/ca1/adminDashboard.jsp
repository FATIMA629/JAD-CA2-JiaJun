<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="Books.*"%>
<%@ page import="Geners.*"%>
<%@ page import="Users.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!-- Customised CSS -->
<link href="css/books.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<style>
.error {
	color: red;
}

.book-table {
	table-layout: fixed;
	word-wrap: break-word;
}

.book-table .col-book-id {
	width: 80px;
}

.col-book-id {
	width: 80px;
}

.col-title {
	width: 200px;
}

.col-author {
	width: 150px;
}

.col-genre-id {
	width: 80px;
}

.col-price {
	width: 80px;
}

.col-quantity {
	width: 100px;
}

.col-publisher {
	width: 150px;
}

.col-publishDate {
	width: 150px;
}

.col-isbn {
	width: 150px;
}

.col-rating {
	width: 80px;
}

.col-description {
	width: 400px;
}

.col-image-loc {
	width: 600px;
}

.col-sold {
	width: 80px;
}

.col-update {
	width: 80px;
}

.col-delete {
	width: 80px;
}

.dashboard-buttons {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-bottom: 20px;
}

.dashboard-buttons a {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.dashboard-buttons a:hover {
	background-color: #0056b3;
}

#statistics-section {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.statistics-card {
	width: 300px;
	margin: 10px;
	height: 200px;
	padding: 20px;
	text-align: center;
	background-color: #f8f8f8;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	justify-content: center;
	align-items: center;
}

.statistics-header {
	font-size: 24px;
	font-weight: bold;
	justify-content: center;
	align-items: center;
}

.statistics-value {
	font-size: 20px;
	font-weight: bold;
	justify-content: center;
	align-items: center;
}

.statistics-card h3 {
	font-size: 18px;
	margin-bottom: 10px;
	justify-content: center;
	align-items: center;
}

.statistics-card p {
	font-size: 24px;
	font-weight: bold;
	justify-content: center;
	align-items: center;
}

.statistics-card ul {
	list-style: none;
	padding: 0;
	margin: 10px 0;
	justify-content: center;
	align-items: center;
}

.statistics-card ul li {
	margin-bottom: 5px;
	justify-content: center;
	align-items: center;
}

.statistics-card a {
	text-decoration: none;
	color: #007bff;
	justify-content: center;
	align-items: center;
}

.statistics-card a:hover {
	text-decoration: underline;
	justify-content: center;
	align-items: center;
}
</style>


<script>
	var checkboxes = document.querySelectorAll('.book-checkbox');
	var deleteInput = document.getElementById('delete-input');

	document.querySelector('.btn-danger').addEventListener('click', function() {
		var ids = [];
		checkboxes.forEach(function(checkbox) {
			if (checkbox.checked) {
				ids.push(checkbox.value);
			}
		});
		deleteInput.value = ids.join(',');
	});
</script>


</head>
<body>
 <jsp:include page="header.jsp"/>
	<%
	if (session != null && session.getAttribute("loggedIn") != null) {
		// User is logged in

		// Check if the user is an admin
		String role = (String) session.getAttribute("role");
		if (role.equals("admin")) {
	%>


	<div class="container py-5">
		<h1 class="mb-5">Admin Dashboard</h1>

		<div class="dashboard-buttons">
			<a href="#manage-books-section">Manage Books</a> <a
				href="#add-book-section">Add Book</a> <a
				href="#manage-users-section">Manage Users</a> <a
				href="#add-user-section">Add User</a>
		</div>

		<%
		BookDao bookDao = new BookDao();
		UserDao userDao = new UserDao();
		GenreDao genreDao = new GenreDao();
		%>
		<h3 class="mt-5">Statistics</h3>
		<div id="statistics-section">
			<div class="statistics-card">
				<h3 class="statistics-header">Total Users</h3>
				<p class="statistics-value">
					<%=userDao.getTotalUsers()%>
				</p>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Total Type Of Books</h3>
				<p class="statistics-value">
					<%=bookDao.getTotalTypeOfBooks()%>
				</p>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Total Number Of Books</h3>
				<p class="statistics-value">
					<%=bookDao.getTotalBooks()%>
				</p>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Total Revenue</h3>
				<p class="statistics-value">
					$<%=String.format("%.2f", bookDao.getTotalRevenue())%>
				</p>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Total Number of Books Sold</h3>
				<p class="statistics-value">
					<%=bookDao.getTotalBooksSold()%>
				</p>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Average Rating of All Books</h3>
				<p class="statistics-value">
					<%=String.format("%.1f", (float) bookDao.getAverageRatingOfAllBooks())%>
					stars
				</p>
			</div>

			<div class="statistics-card">
				<h3 class="statistics-header">Books Low Instock</h3>
				<ul>
					<%
					List<Book> lowestStock = bookDao.getLowestStockBooks(3);
					for (Book book : lowestStock) {
					%>
					<li><%=book.getTitle()%></li>
					<%
					}
					%>
				</ul>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Newest Books</h3>
				<ul>
					<%
					List<Book> newestBooks = bookDao.getNewestBooks(3);
					for (Book book : newestBooks) {
					%>
					<li><%=book.getTitle()%></li>
					<%
					}
					%>
				</ul>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Highest Rated Books</h3>
				<ul>
					<%
					List<Book> highestRatedBooks = bookDao.getHighestRatedBooks(3);
					for (Book book : highestRatedBooks) {
					%>
					<li><%=book.getTitle()%> - <%=book.getRating()%> stars</li>
					<%
					}
					%>
				</ul>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Popular Genres</h3>
				<ul>
					<%
					Map<Genre, Integer> popularGenres = genreDao.getPopularGenres(3);
					for (Map.Entry<Genre, Integer> entry : popularGenres.entrySet()) {
						Genre genre = entry.getKey();
						int genreCount = entry.getValue();
					%>
					<li><%=genre.getGenreName()%> - <%=genreCount%> books</li>
					<%
					}
					%>
				</ul>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Top Rated Genres</h3>
				<ul>
					<%
					List<Genre> topRatedGenres = genreDao.getTopRatedGenres(3);
					for (Genre genre : topRatedGenres) {
					%>
					<li><%=genre.getGenreName()%></li>
					<%
					}
					%>
				</ul>
			</div>
			<div class="statistics-card">
				<h3 class="statistics-header">Top Selling Books</h3>
				<ul>
					<%
					List<Book> topSellingBooks = bookDao.getTopSellingBooks(3);
					for (Book book : topSellingBooks) {
					%>
					<li><%=book.getTitle()%> - <%=book.getSold()%> copies sold</li>
					<%
					}
					%>
				</ul>
			</div>
		</div>





		<%
		List<Book> books = bookDao.readAllBooks();
		String bookIdsToDelete = request.getParameter("delete");
		if (bookIdsToDelete != null) {
			String[] bookIds = bookIdsToDelete.split(",");
			for (String bookId : bookIds) {
				bookDao.deleteBook(bookId);
			}
			books = bookDao.readAllBooks(); // Refresh the list after deletion
		}
		if (books != null) {
		%>
		<div class="table-responsive" id="manage-books-section">
			<form action="adminDashboard.jsp" method="post">
				<button type="submit" class="btn btn-danger mb-2">Delete
					Selected</button>
				<input type="hidden" id="delete-input" name="delete" value="">
			</form>
			<table class="table table-bordered book-table">
				<thead>
					<tr>
						<th class="col-delete">Multi-Select</th>
						<th class="col-book-id">Book ID</th>
						<th class="col-title">Title</th>
						<th class="col-author">Author</th>
						<th class="col-genre-id">Genre</th>
						<th class="col-price">Price</th>
						<th class="col-quantity">Quantity</th>
						<th class="col-publisher">Publisher</th>
						<th class="col-publishDate">Publish Date</th>
						<th class="col-isbn">ISBN</th>
						<th class="col-rating">Rating</th>
						<th class="col-description">Description</th>
						<th class="col-image-loc">Image Location</th>
						<th class="col-sold">Sold</th>
						<th class="col-update">Update</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Book book : books) {
					%>
					<tr>
						<td><input type="checkbox" class="book-checkbox"
							value="<%=book.getBookId()%>" data-title="<%=book.getTitle()%>"></td>
						<td><%=book.getBookId()%></td>
						<td><%=book.getTitle()%></td>
						<td><%=book.getAuthor()%></td>
						<td><%=genreDao.getGenreNameById(book.getGenreId())%></td>
						<td><%=book.getPrice()%></td>
						<td><%=book.getQuantity()%></td>
						<td><%=book.getPublisher()%></td>
						<td><%=book.getPublishDate()%></td>
						<td><%=book.getIsbn()%></td>
						<td><%=book.getRating()%></td>
						<td><%=book.getDescription()%></td>
						<td><%=book.getImageLocation()%></td>
						<td><%=book.getSold()%></td>
						<td><a href="editBook.jsp?id=<%=book.getBookId()%>">Update</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

		<hr />

		<%
		Map<String, String> inputData = (Map<String, String>) session.getAttribute("inputData");
		Map<String, String> errors = (Map<String, String>) session.getAttribute("errors");
		String successMessage = (String) session.getAttribute("success");

		session.removeAttribute("inputData");
		session.removeAttribute("errors");
		session.removeAttribute("success");
		%>

		<%
		if (successMessage != null) {
		%>
		<script>
	alert('<%=successMessage%>
			');
		</script>
		<%
		}
		%>

		<h2 class="mb-4" id="add-book-section">Add Book</h2>
		<form action="../AddBookServlet" method="post">
			<!-- Title field -->
			<div class="mb-3">
				<label for="title" class="form-label">Title</label> <input
					type="text" class="form-control" id="title" name="title"
					value="<%=inputData != null ? inputData.get("title") : ""%>">
				<%
				if (errors != null && errors.containsKey("title")) {
					out.println("<div class='error'>" + errors.get("title") + "</div>");
				}
				%>
			</div>

			<!-- Author field -->
			<div class="mb-3">
				<label for="author" class="form-label">Author</label> <input
					type="text" class="form-control" id="author" name="author"
					value="<%=inputData != null ? inputData.get("author") : ""%>">
				<%
				if (errors != null && errors.containsKey("author")) {
					out.println("<div class='error'>" + errors.get("author") + "</div>");
				}
				%>
			</div>

			<!-- Genre field -->
			<div class="mb-3">
				<label for="genreId" class="form-label">Genre</label> <select
					class="form-control" id="genreId" name="genreId">
					<option disabled style="color: gray;"
						<%=inputData == null || inputData.get("genreId") == null || inputData.get("genreId").equals("") ? "selected" : ""%>>Choose
						a genre</option>
					<%
					List<Genre> genres = genreDao.getAllGenres();
					String selectedGenreId = inputData != null ? inputData.get("genreId") : "";
					for (Genre genre : genres) {
						String genreIdStr = String.valueOf(genre.getGenreId());
					%>
					<option value="<%=genre.getGenreId()%>"
						<%=genreIdStr.equals(selectedGenreId) ? "selected" : ""%>>
						<%=genre.getGenreName()%></option>
					<%
					}
					%>
				</select>
				<%
				if (errors != null && errors.containsKey("genreId")) {
					out.println("<div class='error'>" + errors.get("genreId") + "</div>");
				}
				%>
			</div>

			<!-- Price field -->
			<div class="mb-3">
				<label for="price" class="form-label">Price</label> <input min="0"
					type="number" class="form-control" id="price" name="price"
					value="<%=inputData != null ? inputData.get("price") : ""%>">
				<%
				if (errors != null && errors.containsKey("price")) {
					out.println("<div class='error'>" + errors.get("price") + "</div>");
				}
				%>
			</div>

			<!-- Quantity field -->
			<div class="mb-3">
				<label for="quantity" class="form-label">Quantity</label> <input
					min="0" type="number" class="form-control" id="quantity"
					name="quantity"
					value="<%=inputData != null ? inputData.get("quantity") : ""%>">
				<%
				if (errors != null && errors.containsKey("quantity")) {
					out.println("<div class='error'>" + errors.get("quantity") + "</div>");
				}
				%>
			</div>

			<!-- Publisher field -->
			<div class="mb-3">
				<label for="publisher" class="form-label">Publisher</label> <input
					type="text" class="form-control" id="publisher" name="publisher"
					value="<%=inputData != null ? inputData.get("publisher") : ""%>">
				<%
				if (errors != null && errors.containsKey("publisher")) {
					out.println("<div class='error'>" + errors.get("publisher") + "</div>");
				}
				%>
			</div>

			<!-- Publish Date field -->
			<div class="mb-3">
				<label for="publishDate" class="form-label">Publish Date</label> <input
					type="date" class="form-control" id="publishDate"
					name="publishDate"
					value="<%=inputData != null ? inputData.get("publishDate") : ""%>">
				<%
				if (errors != null && errors.containsKey("publishDate")) {
					out.println("<div class='error'>" + errors.get("publishDate") + "</div>");
				}
				%>
			</div>

			<!-- ISBN field -->
			<div class="mb-3">
				<label for="isbn" class="form-label">ISBN</label> <input type="text"
					class="form-control" id="isbn" name="isbn"
					value="<%=inputData != null ? inputData.get("isbn") : ""%>">
				<%
				if (errors != null && errors.containsKey("isbn")) {
					out.println("<div class='error'>" + errors.get("isbn") + "</div>");
				}
				%>
			</div>

			<!-- Rating field -->
			<div class="mb-3">
				<label for="rating" class="form-label">Rating</label> <input
					type="number" min="0" step="0.01" class="form-control" id="rating"
					name="rating"
					value="<%=inputData != null ? inputData.get("rating") : ""%>">
				<%
				if (errors != null && errors.containsKey("rating")) {
					out.println("<div class='error'>" + errors.get("rating") + "</div>");
				}
				%>
			</div>

			<!-- Description field -->
			<div class="mb-3">
				<label for="description" class="form-label">Description</label>
				<textarea class="form-control" id="description" name="description"><%=inputData != null ? inputData.get("description") : ""%></textarea>
				<%
				if (errors != null && errors.containsKey("description")) {
					out.println("<div class='error'>" + errors.get("description") + "</div>");
				}
				%>
			</div>

			<!-- Image Location field -->
			<div class="mb-3">
				<label for="imageLocation" class="form-label">Image Location</label>
				<input type="text" class="form-control" id="imageLocation"
					name="imageLocation"
					value="<%=inputData != null ? inputData.get("imageLocation") : ""%>">
				<%
				if (errors != null && errors.containsKey("imageLocation")) {
					out.println("<div class='error'>" + errors.get("imageLocation") + "</div>");
				}
				%>
			</div>

			<!-- Sold field -->
			<div class="mb-3">
				<label for="sold" class="form-label">Sold</label> <input
					type="number" min="0" class="form-control" id="sold" name="sold"
					value="<%=inputData != null ? inputData.get("sold") : ""%>">
				<%
				if (errors != null && errors.containsKey("sold")) {
					out.println("<div class='error'>" + errors.get("sold") + "</div>");
				}
				%>
			</div>

			<button type="submit" class="btn btn-primary">Add Book</button>
		</form>
		<%
		}
		%>





		<hr />

		<%
		List<User> users = userDao.getAllUsers();
		String userIdsToDelete = request.getParameter("deleteUser");
		if (userIdsToDelete != null) {
			String[] userIds = userIdsToDelete.split(",");
			for (String userId : userIds) {
				userDao.deleteUser(userId);
			}
			users = userDao.getAllUsers(); // Refresh the list after deletion
		}
		%>

		<div class="table-responsive" id="manage-users-section">
			<form action="adminDashboard.jsp" method="post">
				<button type="submit" class="btn btn-danger mb-2 user-delete-btn">Delete
					Selected</button>
				<input type="hidden" id="user-delete-input" name="deleteUser"
					value="">
			</form>
			<table class="table table-bordered user-table">
				<thead>
					<tr>
						<th class="col-delete">Multi-Select</th>
						<th class="col-user-id">User ID</th>
						<th class="col-username">Username</th>
						<th class="col-email">Email</th>
						<th class="col-address">Address</th>
						<th class="col-role">Role</th>
						<th class="col-update">Update</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (User user : users) {
					%>
					<tr>
						<td><input type="checkbox" class="user-checkbox"
							value="<%=user.getUserID()%>"
							data-username="<%=user.getUserName()%>"></td>
						<td><%=user.getUserID()%></td>
						<td><%=user.getUserName()%></td>
						<td><%=user.getEmail()%></td>
						<td><%=user.getAddress()%></td>
						<td><%=user.getRole()%></td>
						<td><a href="editUser.jsp?id=<%=user.getUserID()%>">Update</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>


		<hr />

		<%
		Map<String, String> inputUserData = (Map<String, String>) session.getAttribute("inputUserData");
		Map<String, String> userErrors = (Map<String, String>) session.getAttribute("userErrors");
		String userSuccessMessage = (String) session.getAttribute("userSuccessMessage");

		session.removeAttribute("inputUserData");
		session.removeAttribute("userErrors");
		session.removeAttribute("userSuccessMessage");
		%>

		<%
		if (userSuccessMessage != null) {
		%>
		<script>
	alert('<%=userSuccessMessage%>');
</script>
		<%
		}
		%>
		<h2 class="mb-4" id="add-user-section">Add User</h2>
		<form action="../AddUserServlet" method="post">
			<!-- Username field -->
			<div class="mb-3">
				<label for="username" class="form-label">Username</label> <input
					type="text" class="form-control" id="username" name="username"
					value="<%=inputUserData != null ? inputUserData.get("username") : ""%>">
				<%
				if (userErrors != null && userErrors.containsKey("username")) {
					out.println("<div class='error'>" + userErrors.get("username") + "</div>");
				}
				%>
			</div>

			<!-- Email field -->
			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					type="email" class="form-control" id="email" name="email"
					value="<%=inputUserData != null ? inputUserData.get("email") : ""%>">
				<%
				if (userErrors != null && userErrors.containsKey("email")) {
					out.println("<div class='error'>" + userErrors.get("email") + "</div>");
				}
				%>
			</div>

			<!-- Password field -->
			<div class="mb-3">
				<label for="password" class="form-label">Password</label> <input
					type="password" class="form-control" id="password" name="password"
					value="<%=inputUserData != null ? inputUserData.get("password") : ""%>">
				<%
				if (userErrors != null && userErrors.containsKey("password")) {
					out.println("<div class='error'>" + userErrors.get("password") + "</div>");
				}
				%>
			</div>

			<!-- Confirm Password field -->
			<div class="mb-3">
				<label for="confirmPassword" class="form-label">Confirm
					Password</label> <input type="password" class="form-control"
					id="confirmPassword" name="confirmPassword"
					value="<%=inputUserData != null ? inputUserData.get("confirmPassword") : ""%>">
				<%
				if (userErrors != null && userErrors.containsKey("confirmPassword")) {
					out.println("<div class='error'>" + userErrors.get("confirmPassword") + "</div>");
				}
				%>
			</div>

			<!-- Address field -->
			<div class="mb-3">
				<label for="address" class="form-label">Address</label> <input
					type="text" class="form-control" id="address" name="address"
					value="<%=inputUserData != null ? inputUserData.get("address") : ""%>">
				<%
				if (userErrors != null && userErrors.containsKey("address")) {
					out.println("<div class='error'>" + userErrors.get("address") + "</div>");
				}
				%>
			</div>

			<!-- Role field -->
			<div class="mb-3">
				<label for="role" class="form-label">Role</label> <select
					class="form-control" id="role" name="role">
					<option disabled style="color: gray;"
						<%=inputUserData == null || inputUserData.get("role") == null || inputUserData.get("role").equals("")
		? "selected"
		: ""%>>Choose
						a role</option>
					<option value="USER"
						<%=inputUserData != null && inputUserData.get("role") != null && inputUserData.get("role").equals("USER")
		? "selected"
		: ""%>>User</option>
					<option value="ADMIN"
						<%=inputUserData != null && inputUserData.get("role") != null && inputUserData.get("role").equals("ADMIN")
		? "selected"
		: ""%>>Admin</option>
				</select>
				<%
				if (userErrors != null && userErrors.containsKey("role")) {
					out.println("<div class='error'>" + userErrors.get("role") + "</div>");
				}
				%>
			</div>

			<!-- Submit button -->
			<button type="submit" class="btn btn-primary">Add User</button>
		</form>
	</div>
	<%
	} else {
	// User is not an admin
	response.sendRedirect("home.jsp"); // Redirect to the home page
	}
	} else {
	// User is not logged in
	response.sendRedirect("home.jsp"); // Redirect to the home page
	}
	%>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>

	<script>
		var checkboxes = document.querySelectorAll('.book-checkbox');
		var deleteInput = document.getElementById('delete-input');
		var deleteBtn = document.querySelector('.btn-danger');

		deleteBtn
				.addEventListener(
						'click',
						function(event) {
							var ids = [];
							var titles = [];

							checkboxes.forEach(function(checkbox) {
								if (checkbox.checked) {
									ids.push(checkbox.value);
									titles.push(checkbox
											.getAttribute('data-title'));
								}
							});
							deleteInput.value = ids.join(',');

							if (ids.length == 0) {
								alert("No book is selected for deletion!");
								event.preventDefault();
							} else {
								var confirmMessage = "Are you sure you want to delete the following books?\n\n"
										+ titles.join('\n');
								var result = confirm(confirmMessage);
								if (!result) {
									event.preventDefault();
								}
							}
						});

		var userCheckboxes = document.querySelectorAll('.user-checkbox');
		var userDeleteInput = document.getElementById('user-delete-input');
		var userDeleteBtn = document.querySelector('.user-delete-btn');

		userDeleteBtn
				.addEventListener(
						'click',
						function(event) {
							var userIds = [];
							var usernames = [];

							userCheckboxes.forEach(function(checkbox) {
								if (checkbox.checked) {
									userIds.push(checkbox.value);
									usernames.push(checkbox
											.getAttribute('data-username'));
								}
							});
							userDeleteInput.value = userIds.join(',');

							if (userIds.length === 0) {
								alert("No user is selected for deletion!");
								event.preventDefault();
							} else {
								var confirmMessage = "Are you sure you want to delete the following users?\n\n"
										+ usernames.join('\n');
								var result = confirm(confirmMessage);
								if (!result) {
									event.preventDefault();
								}
							}
						});
	</script>


</body>
</html>