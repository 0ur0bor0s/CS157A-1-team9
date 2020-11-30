<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.Login, src.PaymentMethodBean" %>
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
<head>
<meta charset="UTF-8">
<title>CheapTix Delete Payment</title>
</head>
<body>
<%
	PaymentMethodBean pmb = new PaymentMethodBean();
	pmb.setCardName(request.getParameter("name"));
	pmb.setCardNo(request.getParameter("cardNo"));
	pmb.setExpDate(request.getParameter("expDate"));
	Login l = new Login();
	l.deletePaymentInfo((String)session.getAttribute("username"), pmb);
	response.sendRedirect("../profile.jsp");
%>
</body>
</html>