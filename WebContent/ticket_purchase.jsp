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
	      	<form method="post" action="search.jsp">
	      		<input type="text" id="keyword" name="keyword" placeholder="Search artists, events, etc . .">
        		<button type="submit"><i class="fas fa-search"></i>Search</button>
	        </form>
	     </div>
	  </div>
	  <h1>Purchase ticket for <%= request.getParameter("eventName") %> at <%= request.getParameter("venueName") %></h1>
	  <h2>Price: $<%= request.getParameter("price") %></h2>
	  
	  <%
	  	// Get cards that current user owns
	  	Login l = new Login();
	  	java.util.ArrayList<PaymentMethodBean> cards = l.retrievePaymentMethods((String)session.getAttribute("username"));
	  	//java.util.ArrayList<PaymentMethodBean> cards = new java.util.ArrayList<PaymentMethodBean>();
	  	if (!cards.isEmpty()) { // Select card
	  		out.println("<form method='post' action='process_ticket_purchase.jsp?venueName=" + 
	  				request.getParameter("venueName") + "&eventName=" + request.getParameter("eventName") + "&datetime=" + request.getParameter("datetime") + "&performers=" + request.getParameter("performers") + 
  					"&ptype=" + request.getParameter("ptype") + "&address=" + request.getParameter("address") + "&city=" + request.getParameter("city") + "&district=" + request.getParameter("district") + 
  					"&zipcode=" + request.getParameter("zipcode") + "&country=" + request.getParameter("country") + "&price=" + request.getParameter("price") + "&ticketId=" + request.getParameter("ticketId") + "'>");
		  	out.println("<label for=\"payment-method\">Payment Method:</label><br>");
	  		for (PaymentMethodBean c : cards) {
	  			out.println("<input type='radio' name='paymentMethod' value=" + c + "'>");
	  			out.println("<label for='payment-method'>" + "<b>" + c.getCardName() + "</b> " + c.getCardType() + " " + c.getCardNo() + " " + c.getExpDate() + "</label><br>");
	  		}
	  	} else { // If no cards exist, add new one
	  		out.println("<h2>It looks like you haven't set up a payment method yet. Lets go do that!</h2>");
	  		out.println("<button href='profile.jsp' onclick=\"window.location.href='profile.jsp'\">Add Payment Method</button>");
	  		out.println("<form method='post' action='add_payment_method.jsp>");
	  		out.println("<label for='payment-method'>Add Payment Method:</label><br>");
	  		out.println("<input type='text' name='name' placeholder='Full name on card'><br>");
	  		out.println("<input type='text' name='cardNo' maxlength='16' placeholder='16-digit card number'><br>");
	  		out.println("<input type='number' min='1' max='12' name='expMonth' placeholder='Expiration month'>&nbsp;/&nbsp;<input type='number' min='2020' max='2030' name='expYr' placeholder='Expiration year'><br>");
	  		for (CardType c : CardType.values()) {
	  			out.println("<input type='radio' id='" + c.name() + "' name='cardType' value='" + c.name() + "'>");
	  			out.println("<label for='" + c.name() + "'>" + c.name() + "</label><br>");
	  		}
	  		
	  	}
	  %>
	  <input type='submit' value='Submit'>
	  </form>
</body>
</html>