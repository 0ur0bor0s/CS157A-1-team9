<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.PerformerType, src.TicketBean, src.InsertTicket" %>

<jsp:useBean id="ticketBean" class="src.TicketBean"/>
<jsp:setProperty property="*" name="ticketBean" />
<%
	// Set perform type
	ticketBean.setPerformerType(PerformerType.valueOf(request.getParameter("ptype")));

	// Set performers
	java.util.ArrayList<String> performers = new java.util.ArrayList<String>();
	performers.add(request.getParameter("performer"));
	ticketBean.setPerformers(performers);
	
	// Set date and time of event
	String dateAndTime = request.getParameter("eventdate") + " " + request.getParameter("eventtime");
	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyy-MM-dd HH:mm");
	java.util.Date eventDate = dateFormat.parse(dateAndTime);
	ticketBean.setDatetime(eventDate);
	
	out.println(ticketBean.getNumberTickets());
	out.println(ticketBean.getIsPurchased());
	out.println(ticketBean.getPrice());
	out.println(ticketBean.getEventName());
	out.println(ticketBean.getDatetime());
	out.println(ticketBean.getPerformers());
	out.println(ticketBean.getPerformerType());
	out.println(ticketBean.getAddress());
	out.println(ticketBean.getCity());
	out.println(ticketBean.getDistrict());
	out.println(ticketBean.getCountry());
	out.println(ticketBean.getZipcode());


	try {
		InsertTicket it = new InsertTicket();
		it.insert(ticketBean);
	} catch (Exception e) {
		System.out.println(e);
		e.printStackTrace();
	}

%>