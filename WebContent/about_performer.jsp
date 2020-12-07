<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="src.RetrievePerformerInfo, src.RetrieveEvents, src.EventBean, java.util.ArrayList, src.PerformerType" %>
    
<link href="css/home.css" rel="stylesheet" type="text/css">

<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 

<html>
	<head>
		<title>CheapTix Artist</title>
	</head>
	<body>
		<div class="navbar">
		    <a href="home.jsp">Home</a>
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
		 <div class="card-group">
		 <h1>About <% request.getParameter("performer"); %></h1>	
		 <%
		 	// *** GETS "performer" VALUE PASSED FROM PREVIOUS PAGE *** //
		 
		 	// Formatter for dates
		 	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 	java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
		 	  		
 	  		// Retrieve info about performer
 	  		RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
 	  		
 	  		
 	  	//	pInfo.retrievePerformerInfo(performerName)
		 %>
	</body>

</html>