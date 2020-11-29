<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.RetrieveEvents, src.EventBean" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<html>
<head>
<meta charset="UTF-8">
<title>CheapTix Search</title>
</head>
<body>
	<div class="navbar">
	     <a href="home.jsp">Home</a>
	     <a href="buy.jsp">Buy</a>
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
	<%
		// Search for keyword in Events
		RetrieveEvents re = new RetrieveEvents();
		java.util.ArrayList<EventBean> events = re.searchKeyword(request.getParameter("keyword"));
		
		// Formatter for dates
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
		if (!events.isEmpty()) {
			out.println("<div class=\"card-group\">");
			for (EventBean e : events) {
			out.println("<a style='text-decoration:none; color:black' href='event_listings.jsp?venueName=" + 
	  					e.getVenueName() + "&eventName=" + e.getEventName() + "&datetime=" + dateFormat.format(e.getDatetime()) + "&performers=" + e.getPerformers() + 
	  					"&ptype=" + e.getPerformerType() + "&address=" + e.getAddress() + "&city=" + e.getCity() + "&district=" + e.getDistrict() + 
	  					"&zipcode=" + e.getZipcode() + "&country=" + e.getCountry() + "'>");
			out.println("<div class=\"event-card\">");
	  		out.println("<div class=\"date\">" + e.getDatetime().getDate() + "</div>");
	  		out.println("<div class=\"time\">" + e.getDatetime().getTime() + "</div>");
	  		java.util.ArrayList<String> performers = e.getPerformers();
	  		for (String performer : performers) {
	  	  		out.println("<div class=\"performer-name\">" + performer + "</div>");
	  		}
	  		out.println("<div class=\"event-name\">" + e.getEventName() + "</div>");
	  		out.println("<div class=\"location\">" + e.getAddress() + "</div>");
	  		out.println("</div>");
	  		out.println("</a>");
			}
			out.println("</div>");
		}
	%>
</body>
</html>