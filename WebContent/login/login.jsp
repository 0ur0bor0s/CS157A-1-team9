<%@ page import="java.sql.*"%>
<link href="../css/login.css" rel="stylesheet" type="text/css"> 
<html>
	<head>
		<title>CheapTix Login</title>
	</head>
	<body>
		<h1>CheapTix User Login</h1>
		<div class="login-info">
        	<form action="loginsuccess.jsp" method="post">
	        	<table style="width: 100%">
	        		<tr>
	        			<td>Username</td>
	        			<td><input type="text" name="username" size="20" placeholder="Username"/></td>
	        		</tr>
	        		<tr>
	        			<td>Password</td>
	        			<td><input type="password" name="password" size="20" placeholder="Password"/></td>
	        		</tr>
	        	     <tr>
	        			<td>Admin Code (For admin use only)</td>
	        			<td><input type="password" size="20" placeholder="Admin Code"/></td>
	        		</tr>
	        	</table>
	        	<input type="submit" value="Submit"/>
        	</form>
        	<form action="createuser.jsp" method="post">
	        	<input type="submit" value="Create User" />
        	</form>
    	</div>
	</body>
</html>
