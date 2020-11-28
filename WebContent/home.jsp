<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.RetrieveEvents,src.RetrieveTickets, src.EventBean, src.TicketBean, java.util.ArrayList"  %>
<link href="css/home.css" rel="stylesheet" type="text/css">
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
  <head>
	<title>CheapTix Home Page</title>
	<link rel="stylesheet" href="css/fontawesome">
  </head>
  <body>
	<div class="navbar">
      <a class="current" href="home.jsp">Home</a>
      <a href="buy.jsp">Buy</a>
      <a href="sell.jsp">Sell</a>
      <a href="events.jsp">Events</a>
	  <a href="profile.jsp">Profile</a>
      <div class="search-bar">
        <input type="text" placeholder="Search artists, events, etc . .">
        <button type="submit"><i class="fas fa-search"></i>Search</button>
     </div>
  </div>
  <h1>Hello <%= (String)session.getAttribute("username") %></h1>
  <div class="about-desc">
  	<h2>What is CheapTix?</h2>
  	<p>Ticket reselling is a huge market as many ticket holders are unable to directly refund their ticket and instead turn to online ticket reselling platforms to easily make their money back.  Although there currently exist many ticket resale platforms, many of these platforms charge their users convenience fees in order to turn a profit.  The motivation behind the development of this application is to provide ticket sellers and buyers with an online ticket resale experience, free of convenience fees.</p>
  </div>
  <div>
    <h2>Tickets you have listed:</h2>
    <%
    	RetrieveTickets rtickets = new RetrieveTickets();
    	java.util.ArrayList<TicketBean> listedList = rtickets.retrieveUserListed((String)session.getAttribute("username"));
    	
    	out.println("<div class=\"card-group\">");
    	if (listedList.isEmpty()) {
    		out.println("<div>You have no tickets currently listed</div>");
    	}
    	
    	for (TicketBean t : listedList) {
    		out.println("<div class=\"event-card\">");
    		out.println("<div class='price'>$" + t.getPrice() + "</div>");
    		out.println("<div class=\"date\">" + t.getDatetime().getDate() + "</div>");
      		out.println("<div class=\"time\">" + t.getDatetime().getTime() + "</div>");
      		ArrayList<String> performers = t.getPerformers();
      		for (String performer : performers) {
      	  		out.println("<div class=\"performer-name\">" + performer + "</div>");
      		}
      		out.println("<div class=\"event-name\">" + t.getEventName() + "</div>");
      		out.println("<div class=\"location\">" + t.getAddress() + "</div>");
      		out.println("</div>");
    	}
    	out.println("</div>");
    %>
  </div>
  <div>
  	<h2>Tickets you have bought:</h2>
    <%
    	java.util.ArrayList<TicketBean> boughtList = rtickets.retrieveUserBought((String)session.getAttribute("username"));
    	
    	out.println("<div class=\"card-group\">");
    	if (boughtList.isEmpty()) {
    		out.println("<div>You have no tickets currently listed</div>");
    	}
    	
    	for (TicketBean t : boughtList) {
    		out.println("<div class=\"event-card\">");
    		out.println("<div class=\"date\">" + t.getDatetime().getDate() + "</div>");
      		out.println("<div class=\"time\">" + t.getDatetime().getTime() + "</div>");
      		ArrayList<String> performers = t.getPerformers();
      		for (String performer : performers) {
      	  		out.println("<div class=\"performer-name\">" + performer + "</div>");
      		}
      		out.println("<div class=\"event-name\">" + t.getEventName() + "</div>");
      		out.println("<div class=\"location\">" + t.getAddress() + "</div>");
      		out.println("</div>");
    	}
    	out.println("</div>");
    %>
  </div>
  <div>
  	<h2>Events with tickets for sale:</h2>
  	 <%
  	// Retrive events
  	RetrieveEvents revents = new RetrieveEvents();
  	ArrayList<EventBean> events = revents.retrieve(10);
	out.println("<div class=\"card-group\">");
  	for (EventBean e : events) {
  		out.println("<a style='text-decoration:none; color:black' href='event_listings.jsp?venueName=" + 
  					e.getVenueName() + "&eventName=" + e.getEventName() + "&datetime=" + e.getDatetime() + "&performers=" + e.getPerformers() + 
  					"&ptype=" + e.getPerformerType() + "&address=" + e.getAddress() + "&city=" + e.getCity() + "&district=" + e.getDistrict() + 
  					"&zipcode=" + e.getZipcode() + "&country=" + e.getCountry() + "'>");
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
  		out.println("</a>");
  	}
	out.println("</div>");
  %>
  </div>
 

  </body>
</html>
