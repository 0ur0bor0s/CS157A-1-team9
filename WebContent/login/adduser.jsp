<%@ page import="src.CreateUser" language="java" contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="userBean" class="src.CreateUserBean" />
<jsp:setProperty property="*" name="userBean" />
<%
	CreateUser cu = new CreateUser();
	boolean status = cu.create(userBean);
	
	if (status) {
		System.out.println("User successfully created");
		response.sendRedirect("../home.jsp");
	} else {
		System.out.println("User not created");
		response.sendRedirect("createuser.jsp");
	}
%>