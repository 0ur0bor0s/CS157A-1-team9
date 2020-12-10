<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="src.RetrievePerformerInfo, src.PerformerBean, java.util.ArrayList, src.PerformerType" %>
    
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
			 <h1><%out.println(request.getParameter("name"));%></h1>	
				 <%
				 	// Formatter for dates
				 	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 	java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
				 	  	
		 	  		// Retrieve info about performer
		 	  		RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
		 	  		PerformerBean pb = pInfo.retrievePerformerInfo(request.getParameter("name"));
		 	  	  %>
	 	  	
	 	  	  <h2>Performer Type</h2>
	 	  	  	<% 
		 	  	  	if (pb.getPerformerType() != null){
		 	  	  		out.println(pb.getPerformerType());	
	 	  	  		} else {
	 	  	  			out.println("Performer type not specified");
	 	  	  		}
 	  	  		%>
 		 	 <h2>About</h2>
	 	  	  	<% 
	 	  	  		if (pb.getAbout() != null){
		 	  	  		out.println(pb.getAbout()); 
		 	  	  	} else {
		 	  	  		out.println("There is no information about this performer yet");
		 	  	  	}
		 	 	%>
	 	  	  <h2>Upcoming Events</h2>
	 	  	  	<br/>	 	  	  		
	 	  	  		<%	
			 	  	  	if (pb.getEventsNames() != null && !pb.getEventsNames().isEmpty()){
			 	  	  		System.out.println("listing events..");
		 	  	  			for (int i=1; i<=pb.getEventsNames().size(); i++){
		 	  	  				out.println("<div class=\"event-name\">" + pb.getEventsNames().get(i-1) + " at " + pb.getEventVenues().get(i-1) + " - " + printFormat.format(pb.getEventTimes().get(i-1)) + "</div>");
		 	  	  			}
			  	  		} else {
			  	  			out.println("There are no upcoming events for this performer.");
			  	  		}
	 	  	  		%>
		  </div>		 
	</body>

</html>