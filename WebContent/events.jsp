<%@ page import="java.sql.*"%>
<link href="style/home.css" rel="stylesheet" type="text/css"> 
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
	      <div class="search-bar">
	        <input type="text" placeholder="Search artists, events, etc . .">
	        <button type="submit"><i class="fa fa-search"></i></button>
	       </div>
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