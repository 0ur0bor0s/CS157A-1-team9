<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="src.RetrievePerformerInfo, src.PerformerBean, java.util.ArrayList, src.PerformerType" %>
    
<link href="css/home.css" rel="stylesheet" type="text/css">

<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 

<html>
	<head>
		<title>CheapTix Artist</title>
		<script type="text/javascript">
			function logout() {
				window.location.href = "login/logout.jsp";
			}
			function goProf() {
				window.location.href = "./performer_profile.jsp";
			}
		</script>
	</head>
	<body>
		 <div class="card-group">
			 <h1><%out.println((String)session.getAttribute("name"));%></h1>	
				 <%
				 	// Formatter for dates
				 	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 	java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
				 	  		
		 	  		// Retrieve info about performer
		 	  		RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
		 	  		PerformerBean pb = pInfo.retrievePerformerInfo((String)session.getAttribute("name"));
		 	  	  %>
	 	  	
	 	  	  <h2>Performer Type</h2>
	 	  	  	<label for="performer-type">Performer Type</label><br>
			     	<%
			     		for (PerformerType p : PerformerType.values()) {
			     			out.println("<input type='radio' id='" + p.name() + "' name='ptype' value='" + p.name() + "'>");
			     			out.println("<label for='" + p.name() + "'>" + p.name() + "</label><br>");
			     		}
			     	%>
 		 	 <h2>About</h2>
	 	  	  	 
	 	  		<form method='post' action='changeuser/change_about.jsp'>
				<textarea id="about" name="about" rows="4" cols="50" maxlength = "200" placeholder ="About description"></textarea><br>
	 		       	<input type='submit' value='Save changes'>
				</form>	
	 	  	   	
	 			<h3></h3> 
					<button type="button" onclick="goProf()">Save</button>
					<button type="button" onclick="logout()">Log out</button> 
		</div>
	</body>
</html>