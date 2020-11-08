<link href="../css/login.css" rel="stylesheet" type="text/css"> 
<html>
	<head>
		<title>CheapTix Login</title>
	</head>
	<body>
		<h1>Create User</h1>
		<div class="login-info">
        	<form action="adduser.jsp" method="post">
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
	        			<td>Email</td>
	        			<td><input type="text" name="email" size="20" placeholder="user@gmail.com"/></td>
	        		</tr>
	        		<tr>
	        			<td>Phone Number</td>
	        			<td><input type="text" name="phoneNumber" size="20" placeholder="2094445555"/></td>
	        		</tr>
	        	</table>
	        	<input type="submit" value="Submit"/>
        	</form>
    	</div>
	</body>
</html>