package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	 * @throws ClassNotFoundException 
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
				EventBean event = new EventBean();
				
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
								
				eventList.add(event);
			}
			
			eventquery.close();
		} catch (Exception e) {
			System.out.println(e);
	  }
		
	return eventList;
	}
}