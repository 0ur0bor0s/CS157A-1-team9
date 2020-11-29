<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="src.PerformerType, src.TicketBean, src.RetrieveTickets, src.EventBean" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
<head>
<meta charset="UTF-8">
<title>Event Listings</title>
</head>
<body>
	<div class="navbar">
	     <a href="home.jsp">Home</a>
	     <a href="buy.jsp">Buy</a>
	     <a href="sell.jsp">Sell</a>
	     <a href="events.jsp">Events</a>
	     <a href="profile.jsp">Profile</a>
	     <div class="search-bar">
	       <input type="text" placeholder="Search artists, events, etc . .">
           <button type="submit"><i class="fas fa-search"></i>Search</button>
	 	 </div>
	</div>
	<h1><%= request.getParameter("eventName") %> at <%= request.getParameter("venueName") %></h1>
	<h2>Performing: <%=
		request.getParameter("performers")
	%></h2>
	<h3>Event category: <%= request.getParameter("ptype") %></h3>
	<h3>Time: <%= request.getParameter("datetime") %></h3>
	<%
		// Recollect url information into EventBean
		EventBean eb = new EventBean();
		eb.setVenueName(request.getParameter("venueName"));
		eb.setEventName(request.getParameter("eventName"));
		
		// Set date and time of event
		String dateAndTime = request.getParameter("datetime");
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyy-MM-dd HH:mm:ss");
		java.util.Date eventDate = dateFormat.parse(dateAndTime);
		eb.setDatetime(eventDate);
		
		// Convert string of performers back into an ArrayList
		String ps = request.getParameter("performers");
		java.util.ArrayList<String> pl = new java.util.ArrayList<String>();
		pl.addAll(java.util.Arrays.asList(ps.substring(1, ps.length() - 1).split(", ")));
		eb.setPerformers(pl);
		
		eb.setPerformerType(PerformerType.valueOf(request.getParameter("ptype")));
		eb.setAddress(request.getParameter("address"));
		eb.setCity(request.getParameter("city"));
		eb.setDistrict(request.getParameter("district"));
		eb.setCountry(request.getParameter("country"));
		eb.setZipcode(Integer.parseInt(request.getParameter("zipcode")));
		
		// Populate a page for ticket postings
		RetrieveTickets rt = new RetrieveTickets();
		java.util.ArrayList<TicketBean> ticketlist = rt.retrieveEventListings(eb);
		
		if (!ticketlist.isEmpty()) {
			out.println("<h2>Tickets were found</h2>");
			out.println("<div class=\"card-group\">");
			for (TicketBean tb : ticketlist) {
		  		out.println("<a style='text-decoration:none; color:black' href='ticket_purchase.jsp?venueName=" + 
		  				tb.getVenueName() + "&eventName=" + tb.getEventName() + "&datetime=" + dateFormat.format(tb.getDatetime()) + "&performers=" + tb.getPerformers() + 
	  					"&ptype=" + tb.getPerformerType() + "&address=" + tb.getAddress() + "&city=" + tb.getCity() + "&district=" + tb.getDistrict() + 
	  					"&zipcode=" + tb.getZipcode() + "&country=" + tb.getCountry() + "&price=" + tb.getPrice() + "&ticketId=" + tb.getTicketId() + "'>");
				out.println("<div class=\"event-card\">");
				out.println("<div>$" + tb.getPrice() + "</div>");
		  		out.println("</div>");
		  		out.println("</a>");
			}
			out.println("</div>");

		} else {
			out.println("<h2>No tickets are currently being sold for this event</h2>");
		}
	%>
</body>
</html>