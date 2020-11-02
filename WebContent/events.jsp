<%@ page import="java.sql.*"%>
<html>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link href="style/home.css" rel="stylesheet" type="text/css">
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
		<div class="card" style="width: 18rem;">
			<img class="card-img-top" src="placeholder.jpg" alt="Card image cap">
		  <div class="card-body">
		    <h5 class="card-title">Green Day</h5>
		    <h6 class="card-subtitle mb-2 text-muted">Concert</h6>
		    <p class="card-text">Location: Pasay, NCR, PH</p>
				<p class="card-text">7:00pm March 13th, 2021</p>
		    <a href="#" class="card-link">Buy</a>
		    <a href="#" class="card-link">View Artist Website</a>
		  </div>
		</div>
		<div class="card" style="width: 18rem;">
			<img class="card-img-top" src="placeholder.jpg" alt="Card image cap">
			<div class="card-body">
				<h5 class="card-title">Billie Eilish</h5>
				<h6 class="card-subtitle mb-2 text-muted">Music Festival</h6>
				<p class="card-text">Location: San Jose, CA, USA</p>
				<p class="card-text">10:00pm April 23, 2021</p>
				<a href="#" class="card-link">Buy</a>
				<a href="#" class="card-link">View Artist Website</a>
			</div>
		</div>
		<div class="card" style="width: 18rem;">
			<img class="card-img-top" src="placeholder.jpg" alt="Card image cap">
			<div class="card-body">
				<h5 class="card-title">San Jose Sharks</h5>
				<h6 class="card-subtitle mb-2 text-muted">Sports Game</h6>
				<p class="card-text">Location: San Jose, CA, USA</p>
				<p class="card-text">8:00pm November 1, 2021</p>
				<a href="#" class="card-link">Buy</a>
				<a href="#" class="card-link">View Artist Website</a>
			</div>
		</div>
  </div>
	</body>
</html>
