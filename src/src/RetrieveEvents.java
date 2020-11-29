package src;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.TimeZone;

import configs.DatabaseProperties;

/**
 * Class to retrieve various events
 * @author ben
 *
 */
public class RetrieveEvents {
	
	/**
	 * Retrieve a specified number of event data from the database
	 * @return List of event data
	 */
	public ArrayList<EventBean> retrieve(int querynum) {

		// List for storing event data
		ArrayList<EventBean> eventList = new ArrayList<EventBean>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query database for event info
			PreparedStatement eventquery = con.prepareStatement("SELECT Events.name, time, venueName, address, city, district, country, zipCode, Performers.name , performerType\n" + 
					"FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId\n" + 
					"INNER JOIN Addresses ON Venues.addressId = Addresses.addressId \n" + 
					"INNER JOIN Cities ON Addresses.cityId = Cities.cityId\n" + 
					"INNER JOIN Performs ON Events.eventId = Performs.eventId \n" + 
					"INNER JOIN Performers ON Performs.performId = Performers.performId \n" + 
					"WHERE Events.eventId NOT IN (SELECT Tickets.eventId FROM Buys \n" + 
					"INNER JOIN Tickets ON Buys.ticketId = Tickets.ticketId )" +
					"LIMIT ?");
			eventquery.setInt(1, querynum);
			ResultSet eqr = eventquery.executeQuery();
			
			
			// Iterate through each entry
			while (eqr.next()) {
				EventBean event = new EventBean();
				
				// Data in Event table
				event.setEventName(eqr.getString("Events.name"));
				event.setVenueName(eqr.getString("venueName"));
				
				TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
				
				event.setDatetime(eqr.getTimestamp("time"));
				event.setAddress(eqr.getString("address"));
				ArrayList<String> performList = new ArrayList<String>();
				performList.add(eqr.getString("Performers.name"));
				event.setPerformerType(PerformerType.valueOf(eqr.getString("performerType")));
				event.setPerformers(performList);
				event.setCity(eqr.getString("city"));
				event.setDistrict(eqr.getString("district"));
				event.setCountry(eqr.getString("country"));
				event.setZipcode(eqr.getInt("zipCode"));
				
				
				eventList.add(event);
			}
			
			eventquery.close();
		} catch (Exception e) {
			System.err.println(e);
	  }
		
	return eventList;
	}
	
	
	/**
	 * Function to search Events using a keyword from the search bar
	 * @param keyword
	 * @return
	 */
	public ArrayList<EventBean> searchKeyword(String keyword) {
		ArrayList<EventBean> events = new ArrayList<EventBean>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
			DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query database for event info
			PreparedStatement eventquery = con.prepareStatement("SELECT Events.name, time, venueName, address, city, district, country, zipCode, Performers.name , performerType\n" + 
					"FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId\n" + 
					"INNER JOIN Addresses ON Venues.addressId = Addresses.addressId\n" + 
					"INNER JOIN Cities ON Addresses.cityId = Cities.cityId\n" + 
					"INNER JOIN Performs ON Events.eventId = Performs.eventId\n" + 
					"INNER JOIN Performers ON Performs.performId = Performers.performId\n" + 
					"WHERE Events.eventId NOT IN (SELECT Tickets.eventId FROM Buys\n" + 
					"INNER JOIN Tickets ON Buys.ticketId = Tickets.ticketId )\n" + 
					"AND (Events.name = ? OR venueName = ? \n" + 
					"OR Events.name = ? OR address = ? \n" + 
					"OR district = ? OR country = ? \n" + 
					"OR zipCode = ? OR Performers.name = ?);");
			eventquery.setNString(1, keyword);
			eventquery.setNString(2, keyword);
			eventquery.setNString(3, keyword);
			eventquery.setNString(4, keyword);
			eventquery.setNString(5, keyword);
			eventquery.setNString(6, keyword);
			eventquery.setNString(7, keyword);
			eventquery.setNString(8, keyword);
			ResultSet eqr = eventquery.executeQuery();
			
			System.out.println("keyword: " + keyword);

			System.out.println("Results arrived");
			
			while (eqr.next()) {
				EventBean event = new EventBean();
				
				// Data in Event table
				event.setEventName(eqr.getString("Events.name"));
				event.setVenueName(eqr.getString("venueName"));
				
				TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
				
				event.setDatetime(eqr.getTimestamp("time"));
				event.setAddress(eqr.getString("address"));
				ArrayList<String> performList = new ArrayList<String>();
				performList.add(eqr.getString("Performers.name"));
				event.setPerformerType(PerformerType.valueOf(eqr.getString("performerType")));
				event.setPerformers(performList);
				event.setCity(eqr.getString("city"));
				event.setDistrict(eqr.getString("district"));
				event.setCountry(eqr.getString("country"));
				event.setZipcode(eqr.getInt("zipCode"));
				
				System.out.println("Event found");

				
				events.add(event);
			}
			
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return events;
	}
}
