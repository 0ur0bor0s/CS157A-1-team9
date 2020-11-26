<%@ page import="src.RetrieveEvents, src.EventBean, java.util.ArrayList" contentType="text/html;charset=UTF-8" language="java" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<html>
	<head>
		<title>Events</title>
	</head>
	<body>
		<div class="navbar">
	      <a href="home.jsp">Home</a>
	      <a href="buy.jsp">Buy</a>
	      <a href="sell.jsp">Sell</a>
	      <a class="current" href="events.jsp">Events</a>
	      <a href="profile.jsp">Profile</a>
	      <div class="search-bar">
	        <input type="text" placeholder="Search artists, events, etc . .">
	        <button type="submit"><i class="fa fa-search"></i></button>
	       </div>
	     </div>
	  	<%
		  	// Retrive events
		  	RetrieveEvents revents = new RetrieveEvents();
		  	ArrayList<EventBean> events = revents.retrieve(10);
			out.println("<div class=\"card-group\">");
		  	for (EventBean e : events) {
				out.println("<div class=\"event-card\">");
		  		out.println("<div class=\"date\">" + e.getDatetime().getDate() + "</div>");
		  		out.println("<div class=\"time\">" + e.getDatetime().getTime() + "</div>");
		  		ArrayList<String> performers = e.getPerformers();
		  		for (String performer : performers) {
		  	  		out.println("<div class=\"performer-name\">" + performer + "</div>");
		  		}
		  		out.println("<div class=\"event-name\">" + e.getEventName() + "</div>");
		  		out.println("<div class=\"location\">" + e.getAddress() + "</div>");
		  		out.println("</div>");
		  	}
			out.println("</div>");
  	%>
	</body>
</html>