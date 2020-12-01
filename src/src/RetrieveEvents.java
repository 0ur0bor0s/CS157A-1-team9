package src;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
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
			PreparedStatement eventquery = con.prepareStatement("SELECT Events.name, time, venueName, address, city, district, country, zipCode, GROUP_CONCAT(Performers.name) perfs , GROUP_CONCAT(performerType) types\n" + 
					"FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId\n" + 
					"INNER JOIN Addresses ON Venues.addressId = Addresses.addressId \n" + 
					"INNER JOIN Cities ON Addresses.cityId = Cities.cityId\n" + 
					"INNER JOIN Performs ON Events.eventId = Performs.eventId \n" + 
					"INNER JOIN Performers ON Performs.performId = Performers.performId \n" + 
					"WHERE Events.eventId NOT IN (SELECT Tickets.eventId FROM Buys \n" + 
					"INNER JOIN Tickets ON Buys.ticketId = Tickets.ticketId ) GROUP BY Events.name, time, venueName, address, city, district, country, zipCode " +
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
				String CSV_perfs = eqr.getNString("perfs");
				String[] perfArray = CSV_perfs.split(",");
				ArrayList<String> performList = new ArrayList<String>(Arrays.asList(perfArray));
				event.setPerformers(performList);
				
				String CSV_types = eqr.getNString("types");
				String[] typeStrArray = CSV_types.split(",");
				ArrayList<PerformerType> typeList = new ArrayList<PerformerType>();
				for (String s : typeStrArray) {
					typeList.add(PerformerType.valueOf(s));
				}
				event.setPerformerTypes(typeList);
				
				event.setCity(eqr.getString("city"));
				event.setDistrict(eqr.getString("district"));
				event.setCountry(eqr.getString("country"));
				event.setZipcode(eqr.getInt("zipCode"));
				
				
				eventList.add(event);
			}
			
			eqr.close();
			con.close();
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
			PreparedStatement eventquery = con.prepareStatement("SELECT Events.name, time, venueName, address, city, district, country, zipCode, GROUP_CONCAT(Performers.name) perfs, GROUP_CONCAT(performerType) types\n" + 
					"FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId\n" + 
					"INNER JOIN Addresses ON Venues.addressId = Addresses.addressId\n" + 
					"INNER JOIN Cities ON Addresses.cityId = Cities.cityId\n" + 
					"INNER JOIN Performs ON Events.eventId = Performs.eventId\n" + 
					"INNER JOIN Performers ON Performs.performId = Performers.performId\n" + 
					"WHERE Events.eventId NOT IN (SELECT Tickets.eventId FROM Buys\n" + 
					"INNER JOIN Tickets ON Buys.ticketId = Tickets.ticketId )\n" + 
					"AND (Events.name LIKE ? OR venueName LIKE ? \n" + 
					"OR Events.name LIKE ? OR address LIKE ? \n" + 
					"OR district LIKE ? OR country LIKE ? \n" + 
					"OR zipCode LIKE ? OR Performers.name LIKE ?) GROUP BY Events.name, time, venueName, address, city, district, country, zipCode;");
			eventquery.setNString(1, "%" + keyword + "%");
			eventquery.setNString(2, "%" + keyword + "%");
			eventquery.setNString(3, "%" + keyword + "%");
			eventquery.setNString(4, "%" + keyword + "%");
			eventquery.setNString(5, "%" + keyword + "%");
			eventquery.setNString(6, "%" + keyword + "%");
			eventquery.setNString(7, "%" + keyword + "%");
			eventquery.setNString(8, "%" + keyword + "%");
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
				
				String CSV_perfs = eqr.getNString("perfs");
				String[] perfArray = CSV_perfs.split(",");
				ArrayList<String> performList = new ArrayList<String>(Arrays.asList(perfArray));
				event.setPerformers(performList);
				
				String CSV_types = eqr.getNString("types");
				String[] typeStrArray = CSV_types.split(",");
				ArrayList<PerformerType> typeList = new ArrayList<PerformerType>();
				for (String s : typeStrArray) {
					typeList.add(PerformerType.valueOf(s));
				}
				event.setPerformerTypes(typeList);
				
				event.setCity(eqr.getString("city"));
				event.setDistrict(eqr.getString("district"));
				event.setCountry(eqr.getString("country"));
				event.setZipcode(eqr.getInt("zipCode"));
				
				System.out.println("Event found");

				
				events.add(event);
			}
			
			eqr.close();
			eventquery.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return events;
	}
}
