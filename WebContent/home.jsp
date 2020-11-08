<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
      <div class="search-bar">
        <input type="text" placeholder="Search artists, events, etc . .">
        <button type="submit"><i class="fa fa-search"></i></button>
     </div>
  </div>
  <div class="about-desc">
  	<h2>What is CheapTix?</h2>
  	<p>Ticket reselling is a huge market as many ticket holders are unable to directly refund their ticket and instead turn to online ticket reselling platforms to easily make their money back.  Although there currently exist many ticket resale platforms, many of these platforms charge their users convenience fees in order to turn a profit.  The motivation behind the development of this application is to provide ticket sellers and buyers with an online ticket resale experience, free of convenience fees.</p>
  </div>
  <div class="card-group">
    <div class="event-card">
    	<div class="date">March 13, 2021</div>
    	<div class="time">7:00pm</div>
    	<div class="performer-name">Green Day</div>
    	<div class="event-name">Green Day Concert</div>
    	<div class="location">Pasay, NCR, PH</div>
  	</div>
  	<div class="event-card">
    	<div class="date">April 23, 2021</div>
    	<div class="time">10:00pm</div>
    	<div class="performer-name">Billie Eilish</div>
    	<div class="event-name">Music Festival</div>
    	<div class="location">San Jose, CA, USA</div>
  	</div>
  	<div class="event-card">
    	<div class="date">November 1, 2021</div>
    	<div class="time">8:00pm</div>
    	<div class="performer-name">San Jose Sharks</div>
    	<div class="event-name">San Jose Sharks game</div>
    	<div class="location">San Jose, CA, USA</div>
  	</div>
  </div>
  </body>
</html>
