<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.Login, src.PaymentMethodBean, src.CardType" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
<head>
<meta charset="UTF-8">
<title>CheapTix Purchase</title>
</head>
<body>
	<div class="navbar">
	     <a href="home.jsp">Home</a>
	     <a href="buy.jsp">Buy</a>
	     <a href="sell.jsp">Sell</a>
	     <a href="events.jsp">Events</a>
	     <a href="profile.jsp">Profile</a>
	     <div class="search-bar">
	        <input type="text" placeholder="Search artists, events, etc . .">
	      	<button type="submit"><i class="fas fa-search"></i>Search</button>
	     </div>
	  </div>
	  <h1>Purchase ticket for <%= request.getParameter("eventName") %> at <%= request.getParameter("venueName") %></h1>
	  <h2>Price: $<%= request.getParameter("price") %></h2>
	  <form method='post' action="<%= ("process_ticket_purchase.jsp?venueName=" + 
		  				request.getParameter("venueName") + "&eventName=" + request.getParameter("eventName") + "&datetime=" + request.getParameter("datetime") + "&performers=" + request.getParameter("performers") + 
	  					"&ptype=" + request.getParameter("ptype") + "&address=" + request.getParameter("address") + "&city=" + request.getParameter("city") + "&district=" + request.getParameter("district") + 
	  					"&zipcode=" + request.getParameter("zipcode") + "&country=" + request.getParameter("country") + "&price=" + request.getParameter("price") + "&ticketId=" + request.getParameter("ticketId")) %>">
	  	<label for="payment-method">Payment Method:</label><br>
	  <%
	  	// Get cards that current user owns
	  	Login l = new Login();
	  	java.util.ArrayList<PaymentMethodBean> cards = l.retrievePaymentMethods((String)session.getAttribute("username"));
	  	
	  	if (!cards.isEmpty()) {
	  		for (PaymentMethodBean c : cards) {
	  			out.println("<input type='radio' name='paymentMethod' value=" + c + "'>");
	  			out.println("<label for='payment-method'>" + "<b>" + c.getCardName() + "</b> " + c.getCardType() + " " + c.getCardNo() + " " + c.getExpDate() + "</label><br>");
	  		}
	  	}
	  %>
	  <input type='submit' value='Submit'>
	  </form>
</body>
</html>