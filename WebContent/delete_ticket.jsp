<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.InsertTicket" %>
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
<head>
<meta charset="UTF-8">
<title>CheapTix Delete Ticket</title>
</head>
<body>
	<%
		// Delete ticket from Lists and Tickets
		InsertTicket it = new InsertTicket();
		it.deleteTicket(Integer.valueOf(request.getParameter("ticketId")));
		response.sendRedirect("home.jsp");
	%>
</body>
</html>