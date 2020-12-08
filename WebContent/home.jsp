<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.RetrieveEvents,src.RetrieveTickets, src.EventBean, src.TicketBean, java.util.ArrayList, src.PerformerType"  %>
<link href="css/home.css" rel="stylesheet" type="text/css">
<%
	// Make sure user is logged in to session
	if ((String)session.getAttribute("username") == null) {
		response.sendRedirect("login/login.jsp");
	}
%> 
<html>
  <head>
	<title>CheapTix Home Page</title>
	<link rel="stylesheet" href="css/fontawesome">
  </head>
  <body>
	<div class="navbar">
      <a class="current" href="home.jsp">Home</a>
      <a href="sell.jsp">Sell</a>
      <a href="events.jsp">Events</a>
	  <a href="profile.jsp">Profile</a>
      <div class="search-bar">
      	<form method="post" action="search.jsp">
	        <input type="text" id="keyword" name="keyword" placeholder="Search artists, events, etc . .">
       		<button type="submit"><i class="fas fa-search"></i>Search</button>
        </form>
     </div>
  </div>
  <div class="header-group">
  	<h1>Hello <%= (String)session.getAttribute("username") %></h1>
  </div>
  <!-- <canvas id="glCanvas" width="640" height="480"></canvas> -->
  <!--
  <div class="about-desc">
  	<h2>What is CheapTix?</h2>
  	<p>Ticket reselling is a huge market as many ticket holders are unable to directly refund their ticket and instead turn to online ticket reselling platforms to easily make their money back.  Although there currently exist many ticket resale platforms, many of these platforms charge their users convenience fees in order to turn a profit.  The motivation behind the development of this application is to provide ticket sellers and buyers with an online ticket resale experience, free of convenience fees.</p>
  </div>-->
  <div>
    <%
    	RetrieveTickets rtickets = new RetrieveTickets();
    	java.util.ArrayList<TicketBean> listedList = rtickets.retrieveUserListed((String)session.getAttribute("username"));
    	
		java.text.SimpleDateFormat printFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
    	
    	out.println("<div class=\"card-group\">");
    	
    	out.println("<h2>Tickets you have listed:</h2>");
    	
    	if (listedList.isEmpty()) {
    		out.println("<div>You have no tickets currently listed</div>");
    	}
    	
    	for (TicketBean t : listedList) {
    		out.println("<div class=\"event-card\">");
    		out.println("<div class='price'><b>Price: $" + String.format("%.2f", t.getPrice()) + "</b></div>");
			out.println("<div class='event-name'><h3>" + t.getEventName() + " at " + t.getVenueName() + "</h3></div>");
			
	  		out.println("<b>Performing:</b><br>");
	  		ArrayList<String> performers = t.getPerformers();
	  		for (String performer : performers) {
	  	  		out.println("<div class=\"performer-name\"><a href=\"about_performer.jsp?name=" + performer + "\">" + performer + "</a></div>");	// trying to pass "performer" as value to next page (about_performer.jsp)
	  		}
	  		
	  		out.println("<br><b>Event Category:</b><br>");
	  		ArrayList<PerformerType> perftypes = t.getPerformerTypes();
	  		for (PerformerType ty : perftypes) {
	  			out.println("<div>" + ty + "</div>");
	  		}
	  		
	  		out.println("<br><b>Date:</b><br>");
	  		out.println("<div class=\"time\">" + printFormat.format(t.getDatetime()) + "</div><br>");
	  		out.println("<div class=\"location\">" + t.getCity() + ", " + t.getDistrict() + " " + t.getCountry() + " " + t.getZipcode() + "</div>");
      		out.println("<form method='post' action='change_price.jsp?ticketId=" + t.getTicketId() +"'>" +
      		     	"<input type='number' min='0' name='price' id='price' placeholder='25.00'>&nbsp;" +
      		     	"<input type='submit' value='Change Price'>" +
      		         "</form>");
	  		out.println("<button href='delete_ticket.jsp' onclick=\"window.location.href='delete_ticket.jsp?ticketId=" + t.getTicketId() + "'\">Remove Ticket Listing</button>");
	  		out.println("</div>");
    	}
    	out.println("</div>");

    %>
  </div>
  <div>
    <%
    	java.util.ArrayList<TicketBean> boughtList = rtickets.retrieveUserBought((String)session.getAttribute("username"));
    	
    	out.println("<div class=\"card-group\">");
    	
    	out.println("<h2>Tickets you have bought:</h2>");
    	
    	if (boughtList.isEmpty()) {
    		out.println("<div>You have no tickets currently listed</div>");
    	}
    	
    	for (TicketBean t : boughtList) {
    		out.println("<div class=\"event-card\">");
			out.println("<div class='event-name'><h3>" + t.getEventName() + " at " + t.getVenueName() + "</h3></div>");
	  		out.println("<b>Performing:</b><br>");
	  		ArrayList<String> performers = t.getPerformers();
	  		for (String performer : performers) {
	  	  		out.println("<div class=\"performer-name\"><a href=\"about_performer.jsp?name=" + performer + "\">" + performer + "</a></div>");	// trying to pass "performer" as value to next page (about_performer.jsp)
	  		}
	  		
	  		out.println("<br><b>Event Category:</b><br>");
	  		ArrayList<PerformerType> perftypes = t.getPerformerTypes();
	  		for (PerformerType ty : perftypes) {
	  			out.println("<div>" + ty + "</div>");
	  		}
	  		
	  		out.println("<br><b>Date:</b><br>");
	  		out.println("<div class=\"time\">" + printFormat.format(t.getDatetime()) + "</div><br>");
	  		out.println("<div class=\"location\">" + t.getCity() + ", " + t.getDistrict() + " " + t.getCountry() + " " + t.getZipcode() + "</div>");
	  		out.println("</div>");
    	}
    	out.println("</div>");
    %>
  </div>
  <div>
  	 <%
		// Formatter for dates
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	  	// Retrieve events
	  	RetrieveEvents revents = new RetrieveEvents();
	  	ArrayList<EventBean> events = revents.retrieve(50);
		out.println("<div class=\"card-group\">");
		out.println("<h1>Events with ticket listings:</h1>");
	  	for (EventBean e : events) {
	  		out.println("<a style='text-decoration:none; color:black' href='event_listings.jsp?venueName=" + 
	  					e.getVenueName() + "&eventName=" + e.getEventName() + "&datetime=" + dateFormat.format(e.getDatetime()) + "&performers=" + e.getPerformers() + 
	  					"&ptypes=" + e.getPerformerTypes() + "&address=" + e.getAddress() + "&city=" + e.getCity() + "&district=" + e.getDistrict() + 
	  					"&zipcode=" + e.getZipcode() + "&country=" + e.getCountry() + "'>");
			out.println("<div class=\"event-card\">");
			out.println("<div class='event-name'><h3>" + e.getEventName() + " at " + e.getVenueName() + "</h3></div>");
	  		out.println("<b>Performing:</b><br>");
	  		ArrayList<String> performers = e.getPerformers();
	  		for (String performer : performers) {
	  	  		out.println("<div class=\"performer-name\"><a href=\"about_performer.jsp?name=" + performer + "\">" + performer + "</a></div>");	// trying to pass "performer" as value to next page (about_performer.jsp)
	  		}
	  		
	  		out.println("<br><b>Event Category:</b><br>");
	  		ArrayList<PerformerType> perftypes = e.getPerformerTypes();
	  		for (PerformerType t : perftypes) {
	  			out.println("<div>" + t + "</div>");
	  		}
	  		
	  		out.println("<br><b>Date:</b><br>");
	  		out.println("<div class=\"time\">" + printFormat.format(e.getDatetime()) + "</div><br>");
	  		out.println("<div class=\"location\">" + e.getCity() + ", " + e.getDistrict() + " " + e.getCountry() + " " + e.getZipcode() + "</div>");
	  		out.println("</div>");
	  		out.println("</a>");
	  	}
		out.println("</div>");
  %>
  </div>
 	<script type="text/javascript">
 	// WebGl stuff
		main();
	
		function main() {
		  const canvas = document.querySelector("#glCanvas");
		  // Initialize the GL context
		  const gl = canvas.getContext("webgl");

		  // Only continue if WebGL is available and working
		  if (!gl) {
		    alert("Unable to initialize WebGL. Your browser or machine may not support it.");
		    return;
		  }
		  
		  // Vertex shader
		  const vertSource = `
		  	attribute vec4 aVertexPositition;
		  	attribute vec4 aVertexColor;
		  	
		    uniform mat4 uModelViewMatrix;
		    uniform mat4 uProjectionMatrix;
		    varying lowp vec4 vColor;
		    void main(void) {
		      gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
		      vColor = aVertexColor;
		    }
		  `;
		  
		  // Fragment shader
		  const fragSource = `
		  	varying lowp vec4 vColor;
		    void main(void) {
		      gl_FragColor = vColor;
		    }
		  `;
		  
		  // Add shaders to the WebGL context
		  const shaderProgram = initShaderProgram(gl, vertSource, fragSource);
		  
		  // info needed for shader program
		  const programInfo = {
			  program: shaderProgram,
			  attribLocations: {
				  vertexPosition: gl.getAttribLocation(shaderProgram, 'aVertexPosition'),
				  vertexColor: gl.getAttribLocation(shaderProgram, 'aVertexColor'),
			  },
			  uniformLocations: {
				  projectionMatrix: gl.getUniformLocation(shaderProgram, 'uProjectionMatrix'),
				  modelViewMatrix: fl.getUniformLocation(shaderProgram, 'uModelViewMatrix'),
			  }
		  };
		  
		  // Buffers to send data to GPU
		  const buffers = initBuffers(gl);

		  // Set clear color to black, fully opaque
		  gl.clearColor(0.0, 0.0, 0.0, 1.0);
		  // Clear the color buffer with specified clear color
		  gl.clear(gl.COLOR_BUFFER_BIT);
		}
		
		// Function to initialize the vertex and fragment shader in the WebGL context
		function initShaderProgram(gl, vertSource, fragSource) {
			const vertShader = loadShader(gl, gl.VERTEX_SHADER, vertSource);
			const fragShader = loadShader(gl, gl.FRAGMENT_SHADER, fragSource);
			
			const shaderProgram = gl.createProgram();
			gl.attachShader(shaderProgram, vertShader);
			gl.attachShader(shaderProgra, fragmentShader);
			gl.linkProgram(shaderProgram);
			
			if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
				alert('Could not init shader program: ' + gl.getProgramInfoLog(shaderProgram));
				return null;
			}
			
			return shaderProgram;
		}
		
		function loadShader(gl, shaderType, shaderSource) {
			const shader = gl.createShader(shaderType);
			gl.shaderSource(shader, shaderSource);
			gl.compileShader(shader);
			if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
				alert('Error compiling shader: ' + gl.getShaderInfoLog(shader));
				gl.deleteShader(shader);
				return null;
			}
			return shader;
		}
		
		// Function to initialize buffers needed for rendering
		function initBuffers(gl) {
			const posBuffer = gl.createBuffer();
			
			gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
		
			
		}
		
	</script>

  </body>
</html>
