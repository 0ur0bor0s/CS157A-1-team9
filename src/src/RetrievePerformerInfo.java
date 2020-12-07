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
 * Class to retrieve information about performer(s) from the database
 * @author jalend
 *
 */
public class RetrievePerformerInfo {

	public PerformerBean retrievePerformerInfo(String performerName){
		
		PerformerBean p = new PerformerBean(performerName);
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query database for event info
			PreparedStatement performerquery = con.prepareStatement("SELECT performerType, about, GROUP_CONCAT(events.name) events, GROUP_CONCAT(event.time) times, GROUP_CONCAT(venue.venueName) venues\n" + 
					"FROM Performer\n" + 
					"INNER JOIN Performs ON performers.performerId = performs.performerId\n" +
					"INNER JOIN Events ON performs.eventId = events.eventId\n" +
					"INNER JOIN Venues ON events.venueId = venues.venueId\n" +
					"WHERE performers.name = " + performerName + "\n" +
					"GROUP BY events.name");
//			performerquery.setNString(1, performerName);
			ResultSet pqr = performerquery.executeQuery();
			
			
			// Iterate through each entry
			while (pqr.next()) {
				// Data in Event table
				p.setPerformerType(PerformerType.valueOf(("performerType")));
				
				TimeZone.setDefault(TimeZone.getTimeZone("UTC"));	// necessary?
				
				p.setAbout(pqr.getString("about"));
				
				/****** TO GET EVENT INFO, PUT IN EVENT BEAN? OR JUST PUT AS SO: *******/
				
				String groupedEvents = pqr.getNString("events");
				String[] eventsArray = groupedEvents.split(",");
				for (String e: eventsArray) {
					p.addEvent(e);
				}
				
				String groupedTimes = pqr.getNString("times");
				String[] timesArray = groupedTimes.split(",");
				for(String t: timesArray) {
					p.addTime(t);
				}
				
				String groupedVenues = pqr.getNString("venues");
				String[] venuesArray = groupedVenues.split(",");
				for(String v: venuesArray) {
					p.addVenue(v);
				}
			}
			
			pqr.close();
			con.close();
			performerquery.close();
			
		} catch (Exception e) {
			System.err.println(e);
		}

	return p;
	}
	
}
