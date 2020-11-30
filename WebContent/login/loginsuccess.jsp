<%@ page import="src.Login" language="java" contentType="text/html;charset=UTF-8" %>
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
	        	</table>
	        	<input type="submit" value="Submit"/>
        	</form>
        	<form action="createuser.jsp" method="post">
	        	<input type="submit" value="Create User" />
        	</form>
    	</div>
        <jsp:useBean id="loginBean" class="src.LoginBean"/>
		<jsp:setProperty property="*" name="loginBean" />
		<%
			Login log = new Login();
			boolean status = log.validate(loginBean);
			
			String email = log.getEmail(loginBean.getUsername());
			String phoneNumber = log.getNumber(loginBean.getUsername());
			
			if (status) {
				
				// Store username and password to maintain login
				session.setAttribute("username", loginBean.getUsername());
				session.setAttribute("password", loginBean.getPassword());
				session.setAttribute("email", email);
				session.setAttribute("phonenumber", phoneNumber);
				
				System.out.println("Successful login");
				try {
					response.sendRedirect("../home.jsp");
					return;
				} catch (Exception e) {
					System.out.println(e);
				}
			} else {
				System.out.println("Unsuccessful login");
				out.print("<b class=\"error\">Incorrect username or password</b>");
			}
		%>
	</body>
</html>