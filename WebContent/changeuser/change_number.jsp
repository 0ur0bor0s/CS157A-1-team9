<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.Login" %>
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
<head>
<meta charset="UTF-8">
<title>CheapTix Phone Number Change</title>
</head>
<body>
<%
	Login l = new Login();
	l.changeNumber((String)session.getAttribute("username"), request.getParameter("phonenumber"));
	session.setAttribute("phonenumber", l.getNumber((String)session.getAttribute("username")));
	response.sendRedirect("../profile.jsp");
%>
</body>
</html>