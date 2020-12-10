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
		 <div class="card-group">
			 <h1><%out.println(request.getParameter("name"));%></h1>	
				 <%
				 	// Formatter for dates
				 	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 	java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
				 	  		
		 	  		// Retrieve info about performer
		 	  		RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
		 	  		PerformerBean pb = pInfo.retrievePerformerInfo((String)session.getAttribute("name"));
		 	  	  %>
	 	  	
	 	  	  <h2>Performer Type</h2>
	 	  	  	<label for="performer-type">Performer Type</label><br>
			     	<%
			     		for (PerformerType p : PerformerType.values()) {
			     			out.println("<input type='radio' id='" + p.name() + "' name='ptype' value='" + p.name() + "'>");
			     			out.println("<label for='" + p.name() + "'>" + p.name() + "</label><br>");
			     		}
			     	%>
 		 	 <h2>About</h2>
	 	  	  	<% 
	 	  	  		// text field box 
	 	  	  	%>
	 	  	  <h2>Upcoming Events</h2>
	 	  	  	<br/>
	 	  	  		<%	
	 	  	  			//**** THIS CAN EITHER BE AVAILABLE FOR CREATING NEW EVENTS WHICH WOULD THEN BE INSERTED INTO DB OR LEAVE AS IS ****//
	 	  	  			//**** AND IF THIS WERE THE CASE, THIS SHOULD BE THE ONLY WAY TO CREATE AN EVENT -- I.E. WHEN A USER LISTS A TICKET, A DROP DOWN SELECTION OF EVENTS COULD POP UP? ****//
	 	  	  			//**** idk at this point. the db and referencing kinda gets messy ****//
	 	  	  			
	 	  	  			// all event info should be displayed here -- been having problems displaying venue and date/time on same line of event name.
			 	  	  	if (pb.getEventsNames() != null && pb.getEventsNames().isEmpty()){
		 	  	  			for (int i=1; i<=pb.getEventsNames().size(); i++){
		 	  	  			out.println("<div class=\"event-name\">" + pb.getEventsNames().get(i-1) + " at " + pb.getEventVenues().get(i-1) + " - " + printFormat.format(pb.getEventTimes().get(i-1)) + "</div>");
		 	  	  			}
			  	  		} else {
			  	  			out.println("There are no upcoming events for this performer.");
			  	  		}
	 	  	  		%>
		  </div>		
		<%//**** THESE BUTTONS ARE NOT WORKING ****// %>
		<button type="button" onclick="../performer_profile.jsp">Save</button>
		<button type="button" onclick="logout()">Log out</button> 
	</body>

</html>