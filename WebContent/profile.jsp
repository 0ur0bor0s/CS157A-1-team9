<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
	      <a href="buy.jsp">Buy</a>
	      <a href="sell.jsp">Sell</a>
	      <a href="events.jsp">Events</a>
	      <a class="current" href="profile.jsp">Profile</a>
	      <div class="search-bar">
	        <input type="text" placeholder="Search artists, events, etc . .">
        	<button type="submit"><i class="fas fa-search"></i>Search</button>
	       </div>
	     </div>
	     <button type="button" onclick="logout()">Log out</button>
	</body>
</html>