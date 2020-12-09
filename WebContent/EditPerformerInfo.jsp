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
			 <h1><%out.println();%></h1>	
				 <%
				 	// Formatter for dates
				 	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 	java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
				 	  		
		 	  		// Retrieve info about performer
		 	  		RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
		 	  		PerformerBean pb = pInfo.retrievePerformerInfo(request.getParameter("name"));
		 	  	  %>
	 	  	
	 	  	  <h2>Performer Type</h2>
	 	  	  	<% out.println(pb.getPerformerType()); %>
 		 	 <h2>About</h2>
	 	  	  	<% out.println(pb.getAbout()); %>
	 	  	  <h2>Upcoming Events:</h2>
	 	  	  	<br/>
	 	  	  		<%	// all event info should be displayed here -- been having problems displaying venue and date/time on same line of event name.
	 	  	  			for (int i=1; i<=pb.getEventsNames().size(); i++){
	 	  	  				//out.println("pb.getEventsNames().get(i-1) +"\n"); //+ " | Venue: " + pb.getEventVenues().get(i-1)); //" | Time: " + dateFormat.format(pb.getEventTimes().get(i-1)));
	 	  	  				out.println("<div class=\"event-name\">" + pb.getEventsNames().get(i-1) + "</div>");
	 	  	  			}
	 	  	  		%>
	 	  	  		<button type="button" onclick="logout()">Log out</button>
		  </div>		 
	</body>

</html>