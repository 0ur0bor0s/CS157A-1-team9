<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.InsertTicket" %>
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
<title>CheapTix Processing Ticket</title>
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
	 <%
	 	// Purchase ticket buy adding a tuple into the Buys table
	 	InsertTicket it = new InsertTicket();
	 	boolean status = it.buyTicket(Integer.valueOf(request.getParameter("ticketId")), (String)session.getAttribute("username"));
	 	
	 	if (status) {
			out.println("<h1>Ticket has successfully been purchased. You may view it in your Home tab.</h1>");
	 	} else {
	 		out.println("<h1>Ticket could not be purchased. Please try again.</h1>");
	 	}
	 %>
</body>
</html>