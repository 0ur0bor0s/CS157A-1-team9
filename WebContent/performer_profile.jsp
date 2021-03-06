<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="src.RetrievePerformerInfo, src.PerformerBean, java.util.ArrayList, src.PerformerType, src.Login" %>
    
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
		<script type="text/javascript">
			function logout() {
				window.location.href = "login/logout.jsp";
			}
			function goEdit(){
				window.location.href = "./EditPerformerInfo.jsp";
			}
		</script>
	</head>
	<body>
		 <div class="card-group">
			 <h1><%out.println((String)session.getAttribute("name"));%></h1>	
				 <%
				 	// Formatter for dates
				 	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 	java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
				 	  		
		 	  		// Retrieve info about performer
		 	  		RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
		 	  		PerformerBean pb = pInfo.retrievePerformerInfo((String)session.getAttribute("name"));
		 	  	  %>
	 	  	
	 	  	  <h2>Performer Type</h2>
	 	  	  	<% 
	 	  	  		//out.println(session.getAttribute("performerBean").getPerformerType()); 
	 	  	  		if (pb.getPerformerType() != null){
		 	  	  		out.println(pb.getPerformerType());	
	 	  	  		} else {
	 	  	  			out.println("Performer type not specified");
	 	  	  		}
		 	  	%>
 		 	 <h2>About</h2>
	 	  	  	<% 
	 	  	  		//out.println(session.getAttribute("performerBean").getAbout()); 
	 	  	  		if (pb.getAbout() != null){
	 	  	  			out.println(pb.getAbout());	
	 	  	  		} else {
	 	  	  			out.println("There is no information about this performer yet.");
	 	  	  		}
	 	  	  	%>
	 	  	  <h2>Upcoming Events</h2>
	 	  	  	<br/>
	 	  	  		<%	
			 	  	  	if (pb.getEventsNames() != null && !pb.getEventsNames().isEmpty()){
		 	  	  			for (int i=1; i<=pb.getEventsNames().size(); i++){
		 	  	  			out.println("<div class=\"event-name\">" + pb.getEventsNames().get(i-1) + " at " + pb.getEventVenues().get(i-1) + " - " + printFormat.format(pb.getEventTimes().get(i-1)) + "</div>");
		 	  	  			}
			  	  		} else {
			  	  			out.println("There are no upcoming events for this performer.");
			  	  		}
	 	  	  		%>	
		 <h3></h3>	
		<button type="button" onclick="goEdit()">Edit</button>
		<button type="button" onclick="logout()">Log out</button> 
		</div>
	</body>
</html>