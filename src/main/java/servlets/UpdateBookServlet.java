package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Books.BookDao;
import Books.Book;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateBookServlet
 */
@WebServlet("/UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookDao bookDao;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateBookServlet() {
		super();
		try {
			bookDao = new BookDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().removeAttribute("errors");
		request.getSession().removeAttribute("inputData");
		request.getSession().removeAttribute("success");

		System.out.println("Entered doPost method in UpdateBookServlet");
		String bookId = request.getParameter("bookId");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String genreId = request.getParameter("genreId");
		String price = request.getParameter("price");
		String quantity = request.getParameter("quantity");
		String publisher = request.getParameter("publisher");
		String publishDate = request.getParameter("publishDate");
		String isbn = request.getParameter("isbn");
		String rating = request.getParameter("rating");
		String description = request.getParameter("description");
		String imageLocation = request.getParameter("imageLocation");
		String sold = request.getParameter("sold");

		Map<String, String> errors = new HashMap<>();
		Pattern decimalPattern = Pattern.compile("\\d+(\\.\\d+)?");
		Pattern integerPattern = Pattern.compile("\\d+");

		if (title == null || title.isEmpty()) {
			errors.put("title", "Title is required");
		}
		if (author == null || author.isEmpty()) {
			errors.put("author", "Author is required");
		}
		if (genreId == null || genreId.trim().isEmpty()) {
			errors.put("genreId", "Genre must be selected");
		}
		if (!decimalPattern.matcher(price).matches()) {
			errors.put("price", "Price should be a number");
		}
		if (!integerPattern.matcher(quantity).matches()) {
			errors.put("quantity", "Quantity should be a whole number");
		}
		if (publisher == null || publisher.isEmpty()) {
			errors.put("publisher", "Publisher is required");
		}
		if (isbn == null || isbn.isEmpty()) {
			errors.put("isbn", "ISBN is required");
		}
		if (!decimalPattern.matcher(rating).matches()) {
			errors.put("rating", "Rating should be a number");
		}
		if (description == null || description.isEmpty()) {
			errors.put("description", "Description is required");
		}
		if (imageLocation == null || imageLocation.isEmpty()) {
			errors.put("imageLocation", "Image Location is required");
		}
		if (!integerPattern.matcher(sold).matches()) {
			errors.put("sold", "Sold should be a whole number");
		}

		Book book = bookDao.getBookById(bookId);
		if (book == null) {
			errors.put("bookId", "Invalid book ID");
		}

		if (errors.isEmpty()) {
			// Update the book in the database
			book.setTitle(title);
			book.setAuthor(author);
			book.setGenreId(Integer.parseInt(genreId));
			book.setPrice(Double.parseDouble(price));
			book.setQuantity(Integer.parseInt(quantity));
			book.setPublisher(publisher);
			book.setPublishDate(publishDate);
			book.setIsbn(isbn);
			book.setRating(Double.parseDouble(rating));
			book.setDescription(description);
			book.setImageLocation(imageLocation);
			book.setSold(Integer.parseInt(sold));

			bookDao.updateBook(book);

			request.getSession().setAttribute("success", "Book updated successfully");
			request.getSession().removeAttribute("errors");
			request.getSession().removeAttribute("inputData");
			response.sendRedirect("ca1/adminDashboard.jsp");
		} else {
			Map<String, String> inputData = new HashMap<>();
			inputData.put("bookId", bookId);
			inputData.put("title", title);
			inputData.put("author", author);
			inputData.put("genreId", genreId);
			inputData.put("price", price);
			inputData.put("quantity", quantity);
			inputData.put("publisher", publisher);
			inputData.put("publishDate", publishDate);
			inputData.put("isbn", isbn);
			inputData.put("rating", rating);
			inputData.put("description", description);
			inputData.put("imageLocation", imageLocation);
			inputData.put("sold", sold);

			request.getSession().setAttribute("inputData", inputData);
			request.getSession().setAttribute("errors", errors);
			response.sendRedirect("ca1/editBook.jsp?id=" + bookId);
		}
	}
}
