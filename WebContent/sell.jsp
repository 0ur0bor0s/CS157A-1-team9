<%@ page import="src.PerformerType" contentType="text/html;charset=UTF-8" language="java" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<html>
	<head>
		<title>Events</title>
		<script type='text/javascript'>
			var performerCounter = 1;
			var container = document.getElementById("container");
			
			// Function to add performer field
			function addPerformer() {
				var newCount = 1 + (++window.performerCounter);
				container.appendChild(document.createTextNode("Performer " + newCount));
				var input = document.createElement("input");
				input.type = "text";
				container.appendChild(input);
				container.appendChild(document.createElement("br"));
			}
			
			// Function to remove performer field
			function removePerformer() {
				if (window.performerCount > 1) {
					container.removeChild(container.lastChild);
					window.performerCounter--;
				}
			}
			
			document.getElementById("add-performer").addEventListener("click", addPerformer);
			document.getElementById("remove-performer").addEventListener("click", removePerformer);
		</script>
	</head>
	<body>
		<div class="navbar">
	      <a href="home.jsp">Home</a>
	      <a href="buy.jsp">Buy</a>
	      <a class="current" href="sell.jsp">Sell</a>
	      <a href="events.jsp">Events</a>
	      <a href="profile.jsp">Profile</a>
	      <div class="search-bar">
	        <input type="text" placeholder="Search artists, events, etc . .">
        	<button type="submit"><i class="fas fa-search"></i>Search</button>
	       </div>
	     </div>
	     <h1>Enter the tickets you want to sell here!</h1>
	     <form method="post" action="process_ticket_listing.jsp">
	     	<label for="num-tickets">Number of tickets you wish to sell:</label><br>
	     	<input type="number" min="1" id="num-tickets" name="numberTickets"><br>
	     	<label for="price">Price for ticket(s):</label><br>
	     	<input type="number" min="1" step="any" id="price" name="price"><br>
	     	<label for="event-name">Name of event:</label><br>
	     	<input type="text" id="event-name" name="eventName"><br>
	     	
	     	<label for="event-time">Time of event:</label><br>
	     	<input type="date" id="event-time" name="eventdate"><input type="time" name="eventtime"><br>
	     	
	     	<label for="performer-name">Performers:</label><br>
	     	<input type="text" id="performer-name" name="performer"><br>
	     	<div id="container"></div>
	     	<button id="add-performer">Add Performer</button>
	     	<button id="remove-performer">Remove Performer</button><br>
	     	<label for="performer-type">Category of Event</label><br>
	     	<%
	     		for (PerformerType p : PerformerType.values()) {
	     			out.println("<input type='radio' id='" + p.name() + "' name='ptype' value='" + p.name() + "'>");
	     			out.println("<label for='" + p.name() + "'>" + p.name() + "</label><br>");
	     		}
	     	%>
	     	<label for="venue-name">Venue name:</label><br>
	     	<input type="text" id="venue-name" name="venueName"><br>
	     	<label for="address">Address:</label><br>
	     	<input type="text" id="address" name="address"><br>
	     	<label for="city">City:</label><br>
	     	<input type="text" id="city" name="city"><br>
	     	<label for="district">State/Province:</label><br>
	     	<input type="text" id="district" name="district"><br>
	     	<label for="country">Country:</label><br>
	     	<input type="text" id="country" name="country"><br>
	     	<label for="zipcode">Zip Code:</label><br>
	     	<input type="number" id="zipcode" name="zipcode"><br>
	     	<input type="submit" value="Submit">
	     </form>
	</body>
</html>
	