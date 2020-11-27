package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.TimeZone;

import configs.DatabaseProperties;

/**
 * Object to retrieve ticket listings
 * @author ben
 *
 */
public class RetrieveTickets {
	
	/**
	 * Function to query for tickets for a given event
	 * @param eb The event bean to be queried for
	 * @return List of event Beans
	 */
	public java.util.ArrayList<TicketBean> retrieveEventListings(EventBean eb) {
		java.util.ArrayList<TicketBean> tickets = new java.util.ArrayList<TicketBean>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Timezone
			TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			
			// Formatter for dates
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			// Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query the database for event info
			PreparedStatement ticketQuery = con.prepareStatement("SELECT ticketId, price " + 
					"FROM Tickets " + 
					"INNER JOIN Events ON Tickets.eventId = Events.eventId " + 
					"INNER JOIN Venues ON Events.venueId = Venues.venueId " + 
					"INNER JOIN Addresses ON Venues.addressId = Addresses.addressId " + 
					"WHERE Events.name = ? AND time = ? AND venueName = ? AND Address = ? AND zipCode = ? " + 
					"LIMIT 50;");
			ticketQuery.setNString(1, eb.getEventName());
			System.out.println(eb.getEventName());
			ticketQuery.setNString(2, dateFormat.format(eb.getDatetime()));
			ticketQuery.setNString(3, eb.getVenueName());
			System.out.println(eb.getVenueName());
			ticketQuery.setNString(4, eb.getAddress());
			System.out.println(eb.getAddress());
			ticketQuery.setInt(5, eb.getZipcode());
			System.out.println(eb.getZipcode());
			ResultSet tr = ticketQuery.executeQuery();
			
			while (tr.next()) {
				TicketBean tb = new TicketBean(eb);
				tb.setPrice(tr.getFloat("price"));
				System.out.println("Ticket found");
				tickets.add(tb);
			}
			System.out.println("ticket ended");

		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace();
		}
		
		return tickets;
	}
	
	
	/**
	 * Retrieve a specified number of event data from the database
	 * @return List of event data
	 * @throws ClassNotFoundException 
	 */
	/*
	public ArrayList<TicketBean> retrieveListings(int querynum) {

		// List for storing event data
		ArrayList<TicketBean> ticketList = new ArrayList<TicketBean>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query database for event info
			PreparedStatement eventquery = con.prepareStatement("SELECT Events.name, time, venueName, address, city, district, zipCode, Performers.name " + 
																"FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId " + 
																"			 INNER JOIN Addresses ON Venues.addressId = Addresses.addressId " + 
																"			 INNER JOIN Cities ON Addresses.cityId = Cities.cityId " + 
																"            INNER JOIN Performs ON Events.eventId = Performs.eventId " + 
																"            INNER JOIN Performers ON Performs.performId = Performers.performId " + 
																"LIMIT ?");
			eventquery.setInt(1, querynum);
			ResultSet eqr = eventquery.executeQuery();
			
			// Iterate through each entry
			while (eqr.next()) {
				TicketBean event = new TicketBean();
				
				// Data in Event table
				event.setEventName(eqr.getString("Events.name"));
				event.setDatetime(eqr.getDate("time"));
				event.setAddress(eqr.getString("address"));
				ArrayList<String> performList = new ArrayList<String>();
				performList.add(eqr.getString("Performers.name"));
				event.setPerformers(performList);
				event.setCity(eqr.getString("city"));
				event.setDistrict(eqr.getString("district"));
				event.setZipcode(eqr.getInt("zipCode"));
								
				ticketList.add(event);
			}
			
			eventquery.close();
		} catch (Exception e) {
			System.out.println(e);
	  }
		
	return ticketList;
	}*/
}
