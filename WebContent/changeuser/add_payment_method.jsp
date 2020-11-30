<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.Login, src.PaymentMethodBean, src.CardType" %>
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
<head>
<meta charset="UTF-8">
<title>CheapTix Add Payment Method</title>
</head>
<body>
<%
	PaymentMethodBean pmb = new PaymentMethodBean();
	pmb.setCardName(request.getParameter("name"));
	pmb.setCardNo(request.getParameter("cardNo"));
	pmb.setExpDate(request.getParameter("expMonth") + "/" + request.getParameter("expYr"));
	pmb.setCardType(CardType.valueOf(request.getParameter("cardType")));
	Login l = new Login();
	l.addPaymentInfo((String)session.getAttribute("username"), pmb);
	response.sendRedirect("../profile.jsp");
%>
</body>
</html>