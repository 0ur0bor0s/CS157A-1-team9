<link href="../css/login.css" rel="stylesheet" type="text/css"> 
<html>
	<head>
		<title>CheapTix Login</title>
	</head>
	<style text='text/css'>
	
		body {
			background-color: #ffaff1;
		}
		
		h1 {
			background-color: #BC76BA;
		}
		
		.error {
			color: red;
		}
		
		/*
		====== About Description ==========================================================
		*/
		
		.about-desc {
			border-radius: 20px;
			margin: 50px auto;
			border: 3px black;
			background-color: #8F4FA0;
			width: 50%;
			padding: 10px 10px;
		}
		
		.about-desc h2 {
			text-align: center;
			color: white;
			margin-top: 8px;
		}
		
		.about-desc p {
			border: 3px green;
			color: white;
			padding: 10px 10px;
		}
	</style>
	<body>
		<h1>Create User</h1>
		<b class='error'>User could not be created. Username already exists. Please try again.</b>
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