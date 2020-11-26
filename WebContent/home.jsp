<%@ page import="src.RetrieveEvents, src.EventBean, java.util.ArrayList" contentType="text/html;charset=UTF-8" language="java" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<html>
  <head>
	<title>CheapTix Home Page</title>
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
        <button type="submit"><i class="fa fa-search"></i></button>
     </div>
  </div>
  <div class="about-desc">
  	<h2>What is CheapTix?</h2>
  	<p>Ticket reselling is a huge market as many ticket holders are unable to directly refund their ticket and instead turn to online ticket reselling platforms to easily make their money back.  Although there currently exist many ticket resale platforms, many of these platforms charge their users convenience fees in order to turn a profit.  The motivation behind the development of this application is to provide ticket sellers and buyers with an online ticket resale experience, free of convenience fees.</p>
  </div>
  <%
  	// Retrive events
  	RetrieveEvents revents = new RetrieveEvents();
  	ArrayList<EventBean> events = revents.retrieve(10);
	out.println("<div class=\"card-group\">");
  	for (EventBean e : events) {
		out.println("<div class=\"event-card\">");
  		out.println("<div class=\"date\">" + e.getDatetime() + "</div>");
  		out.println("<div class=\"time\">" + e.getDatetime() + "</div>");
  		ArrayList<String> performers = e.getPerformers();
  		for (String performer : performers) {
  	  		out.println("<div class=\"performer-name\">" + performer + "</div>");
  		}
  		out.println("<div class=\"event-name\">" + e.getEventName() + "</div>");
  		out.println("<div class=\"location\">" + e.getAddress() + " " + e.getCity() + ", " + e.getDistrict() + " " + e.getZipcode() + "</div>");
  		out.println("<button>Purchase</button>");
  		out.println("</div>");
  	}
	out.println("</div>");
  %>

  </body>
</html>
