<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.PerformerType, src.TicketBean, src.InsertTicket" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<html>
	<head>
		<title>Listing Ticket</title>
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
<jsp:useBean id="ticketBean" class="src.TicketBean"/>
<jsp:setProperty property="*" name="ticketBean" />
<%

	// Set perform type
	if (request.getParameter("ptype") != null) {
		ticketBean.setPerformerType(PerformerType.valueOf(request.getParameter("ptype")));
	}

	// Set performers
	if (request.getParameter("performer") != null) {
		java.util.ArrayList<String> performers = new java.util.ArrayList<String>();
		performers.add(request.getParameter("performer"));
		ticketBean.setPerformers(performers);
	}

	// Set date and time of event
	if (request.getParameter("eventdate") != null && request.getParameter("eventtime") != null) {
		String dateAndTime = request.getParameter("eventdate") + " " + request.getParameter("eventtime");
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyy-MM-dd HH:mm");
		java.util.Date eventDate = dateFormat.parse(dateAndTime);
		ticketBean.setDatetime(eventDate);
	}

	/*
	out.println(ticketBean.getNumberTickets());
	out.println(ticketBean.getIsPurchased());
	out.println(ticketBean.getPrice());
	out.println(ticketBean.getEventName());
	out.println(ticketBean.getDatetime());
	out.println(ticketBean.getPerformers());
	out.println(ticketBean.getPerformerType());
	out.println(ticketBean.getAddress());
	out.println(ticketBean.getCity());
	out.println(ticketBean.getDistrict());
	out.println(ticketBean.getCountry());
	out.println(ticketBean.getZipcode());
    */

	boolean ticketStatus = false;
	try {
		InsertTicket it = new InsertTicket();
		ticketStatus = it.insert(ticketBean);
	} catch (Exception e) {
		System.out.println(e);
		e.printStackTrace();
	}
	
	if (ticketStatus) {
		out.println("<h1>Ticket has successfully been listed.</h1>");
	} else {
		out.println("<h1>Listing was unsuccessful. Please try again.</h1>");
	}
%>
		<a href="sell.jsp" class="redirect-button">Return to ticket registration page</a>
	</body>
</html>