<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.Login, src.PaymentMethodBean, src.CardType" %>
<link href="css/home.css" rel="stylesheet" type="text/css"> 
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
	<head>
		<title>CheapTix Profile</title>
		<script type="text/javascript">
			function logout() {
				window.location.href = "login/logout.jsp";
			}
		</script>
	</head>
	<body>
		<div class="navbar">
	      <a href="home.jsp">Home</a>
	      <a href="sell.jsp">Sell</a>
	      <a href="events.jsp">Events</a>
	      <a class="current" href="profile.jsp">Profile</a>
	      <div class="search-bar">
	      	<form method="post" action="search.jsp">
	      		<input type="text" id="keyword" name="keyword" placeholder="Search artists, events, etc . .">
        		<button type="submit"><i class="fas fa-search"></i>Search</button>
	        </form>
	       </div>
	     </div>
	     <div class="card-group">
	     <h1>Hello <%= (String)session.getAttribute("username") %></h1>
	     <div class="sell-card">
	     <form method='post' action='changeuser/change_email.jsp'>
	     	<label for='email'><b>Current Email: </b><%= (String)session.getAttribute("email") %></label><br>
	     	<input type='text' id='email' name='email' placeholder='ChangeMe@gmail.com'>
	     	<input type='submit' value='Change Email'><br>
	     </form>
	     <form method='post' action='changeuser/change_number.jsp'>
	     	<%
	     		if ((String)session.getAttribute("email") == null || ((String)session.getAttribute("email")).equals("")) {
	     			out.println("<label for='phone'><b>Current Phone Number: </b> No phone number is currently registered.</label><br>");
	     		} else {
	     			out.println("<label for='phone'><b>Current Phone Number: </b>" + (String)session.getAttribute("phonenumber") + "</label><br>");
	     		}
	     	%>
	     	<input type='number' id='phone' name='phonenumber' placeholder='15105555555'>
	     	<input type='submit' value='Change Phone Number'><br>
	     </form>
	     <%
	 		// Get cards that current user owns
		  	Login l = new Login();
		  	java.util.ArrayList<PaymentMethodBean> cards = l.retrievePaymentMethods((String)session.getAttribute("username"));
		 %>
		 <h3>Registered Payment Methods:</h3>
		 <%
		 	if (cards.isEmpty()) {
		 		out.println("<div>No cards are currently registered. Please register one below!</div><br>");
		 	}
		 	for (PaymentMethodBean c : cards) {
		 		out.println("<form method='post' action='changeuser/delete_payment_method.jsp?name=" + c.getCardName() + "&cardNo=" + c.getCardNo() + "&expDate=" + c.getExpDate() + "'>");
		 		out.println("<label for='payment-method'>" + "<b>" + c.getCardName() + "</b> " + c.getCardType() + " " + c.getCardNo() + " " + c.getExpDate() + "</label>");
		 		out.println("&nbsp;<input type='submit' value='Delete Payment Method'><br>");
		 		out.println("</form>");
		 	}
		 %>
		 <% 
	  		out.println("<form method='post' action='changeuser/add_payment_method.jsp'>");
	  		out.println("<label for='payment-method'>Add Payment Method:</label><br>");
	  		out.println("<input type='text' name='name' placeholder='Full name on card'><br>");
	  		out.println("<input type='text' name='cardNo' minlength='16' maxlength='16' placeholder='16-digit card number'><br>");
	  		out.println("<input type='number' max='12' name='expMonth' placeholder='Expiration month (ex: 4)'>&nbsp;/&nbsp;<input type='number' min='21' max='30' name='expYr' placeholder='Expiration year (ex: 24)'><br>");
	  		for (CardType c : CardType.values()) {
	  			out.println("<input type='radio' id='" + c.name() + "' name='cardType' value='" + c.name() + "'>");
	  			out.println("<label for='" + c.name() + "'>" + c.name() + "</label><br>");
	  		}
	  		out.println("<input type='submit' value='Add Payment Method'></form><br><br>");
	     %>
	     <button type="button" onclick="logout()">Log out</button>
	     </div>
	     </div>
	</body>
</html>