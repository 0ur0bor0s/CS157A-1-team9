<%@ page import="src.Login, src.PerformerBean, src.RetrievePerformerInfo" language="java" contentType="text/html;charset=UTF-8" %>
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

        <jsp:useBean id="loginBean" class="src.LoginBean"/>
		<jsp:setProperty property="*" name="loginBean" />
		<%
			Login log = new Login();
			String status = log.validate(loginBean);
			
			String email = log.getEmail(loginBean.getUsername());
			String phoneNumber = log.getNumber(loginBean.getUsername());
			
			System.out.println(status);
			if (!status.equals("00")) {
		
				// Store username and password to maintain login
				session.setAttribute("username", loginBean.getUsername());
				session.setAttribute("password", loginBean.getPassword());
				session.setAttribute("adminCode", loginBean.getAdminCode()); // added
				session.setAttribute("email", email);
				session.setAttribute("phonenumber", phoneNumber);
				System.out.println("Successful login");
				System.out.println("admincCode attr set as: " + loginBean.getAdminCode());
				try {
					if(status.equals("10")){
						RetrievePerformerInfo pInfo = new RetrievePerformerInfo();
			 	  		PerformerBean pb = pInfo.retrievePerformerName((Integer)loginBean.getAdminCode());
						session.setAttribute("name", pb.getName());
						System.out.println("session's name: " + (String)session.getAttribute("name"));
						response.sendRedirect("../performer_profile.jsp?name=" + pb.getName());	// need to pass performer attribs/values
					} else {
						response.sendRedirect("../home.jsp");
					}
					return;
				} catch (Exception e) {
					System.out.println(e);
				}
			} else {
				System.out.println("Unsuccessful login");
				if (loginBean.getAdminCode() != null){ 
					out.print("<b class=\"error\">Incorrect username, password, or admin code</b>");	// or return results from add user to display which field was invalid
				} else {
					out.print("<b class=\"error\">Incorrect username or password</b>");
				}
			}
		%>
		    	<div class="about-desc">
  			<h2>What is CheapTix?</h2>
  			<p>Ticket reselling is a huge market as many ticket holders are unable to directly refund their ticket and instead turn to online ticket reselling platforms to easily make their money back.  Although there currently exist many ticket resale platforms, many of these platforms charge their users convenience fees in order to turn a profit.  The motivation behind the development of this application is to provide ticket sellers and buyers with an online ticket resale experience, free of convenience fees.</p>
	    </div>
	</body>
</html>