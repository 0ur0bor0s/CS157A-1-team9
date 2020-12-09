<%@ page import="java.sql.*"%>
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
		<h1>CheapTix User Login</h1>
		<div class="login-info">
        	<form action="loginsuccess.jsp" method="post">
	        	<table style="width: 100%">
	        		<tr>
	        			<td>Username<br> <input type="text" name="username" size="20" placeholder="Username"/></td>
	        		</tr>
	        		<tr>
	        			<td>Password<br> <input type="password" name="password" size="20" placeholder="Password"/></td>
	        		</tr>
	        	     <tr>
	        			<td>Admin Code (For admin use only)<br> <input type="password" name="adminCode" size="20" placeholder="Admin Code"/></td>
	        		</tr>
	        	</table>
	        	<input type="submit" value="Submit"/>
        	</form>
        	<form action="createuser.jsp" method="post">
	        	<input type="submit" value="Create User" />
        	</form>
        	<form action="createperformer.jsp" method="post">
	        	<input type="submit" value="Create Performer" />
        	</form>
    	</div>
    	<div class="about-desc">
  			<h2>What is CheapTix?</h2>
  			<p>Ticket reselling is a huge market as many ticket holders are unable to directly refund their ticket and instead turn to online ticket reselling platforms to easily make their money back.  Although there currently exist many ticket resale platforms, many of these platforms charge their users convenience fees in order to turn a profit.  The motivation behind the development of this application is to provide ticket sellers and buyers with an online ticket resale experience, free of convenience fees.</p>
	    </div>
	</body>
</html>
