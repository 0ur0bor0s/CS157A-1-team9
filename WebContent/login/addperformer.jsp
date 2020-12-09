<%@ page import="src.CreatePerformer" language="java" contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="performerBean" class="src.CreatePerformerBean" />
<jsp:setProperty property="*" name="performerBean" />
<%
	CreatePerformer cp = new CreatePerformer();
	String status = cp.create(performerBean);
	
	if (status.equals("111")) {
		System.out.println("Performer successfully created");
		response.sendRedirect("../home.jsp");	// redirect to home to login
	} else if (status.equals("110")){
		System.out.println("User could not be created. Performer Name already exists.");
		response.sendRedirect("failedcreateperformer.jsp");
	} else if (status.equals("101")){
		System.out.println("User could not be created. Admin Code already in use.");
		response.sendRedirect("failedcreateperformer.jsp");
	} else if (status.equals("100")){
		System.out.println("User could not be created. Admin Code already in use and and Performer Name already exists.");
		response.sendRedirect("failedcreateperformer.jsp");
	} else if (status.equals("011")){
		System.out.println("User could not be created. Username already exists.");
		response.sendRedirect("failedcreateperformer.jsp");
	} else if (status.equals("010")){
		System.out.println("Performer could not be created. Username and Performer Name already exist.");
		response.sendRedirect("failedcreateperformer.jsp");
	} else if (status.equals("001")){
		System.out.println("Performer could not be created. Username already exists and Admin Code already in use.");
		response.sendRedirect("failedcreateperformer.jsp");
	}
%>