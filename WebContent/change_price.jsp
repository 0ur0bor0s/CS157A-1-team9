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
<title>Cheaptix Change Email</title>
</head>
<body>
	<%
		InsertTicket it = new InsertTicket();
		it.changeTicketPrice(Integer.valueOf(request.getParameter("ticketId")), Float.valueOf(request.getParameter("price")));
		response.sendRedirect("home.jsp");
	%>
</body>
</html>