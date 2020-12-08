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
		System.out.println(performerName);
		PerformerBean p = new PerformerBean(performerName);
		
		// Formatter for dates
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query database for event info
			PreparedStatement performerquery = con.prepareStatement("SELECT Performers.performerType, Performers.about, GROUP_CONCAT(Events.name) events, GROUP_CONCAT(Events.time) times, GROUP_CONCAT(Venues.venueName) venues\n" + 
					"FROM Performers\n" + 
					"INNER JOIN Performs ON Performers.performId = Performs.performId\n" +
					"INNER JOIN Events ON Performs.eventId = Events.eventId\n" +
					"INNER JOIN Venues ON Events.venueId = Venues.venueId\n" +
					"WHERE Performers.name = ?"); //+
					//"GROUP BY Events.name;");
			performerquery.setNString(1, performerName);
			ResultSet pqr = performerquery.executeQuery();
			
			
			// Iterate through each entry
			while (pqr.next()) {
				// Data in Event table
				p.setPerformerType(PerformerType.valueOf((pqr.getString("Performers.performerType"))));
				
				TimeZone.setDefault(TimeZone.getTimeZone("UTC"));	// necessary?
				
				if (pqr.getString("Performers.about") == null) {
					p.setAbout("There is no information about this performer yet.");
				} else {
					p.setAbout(pqr.getString("Performers.about"));
				}
				
				//****** TO GET EVENT INFO, PUT IN EVENT BEAN? OR JUST PUT AS SO: *******//
				
				// these events return successfully
				String groupedEvents = pqr.getNString("events");
				System.out.println(groupedEvents);
				String[] eventsArray = groupedEvents.split(",");
				ArrayList<String> events = new ArrayList<String>(Arrays.asList(eventsArray));
				p.addEvents(events);
//				for (String e: eventsArray) {
//					System.out.println("adding: " + e);
//					p.addEvent(e);
//				}
				System.out.println("all events added");
				
				// problems occurring begin here -- times and venues are not returned.

				String groupedVenues = pqr.getString("venues");
				System.out.println(groupedVenues);
				String[] venuesArray = groupedVenues.split(",");
				ArrayList<String> venues = new ArrayList<String>(Arrays.asList(venuesArray));
//				for(String v: venuesArray) {
//					p.addVenue(v);
//				}
				
				String groupedTimes = pqr.getString("times");
				System.out.println(groupedTimes);
				String[] timesStringArray = groupedTimes.split(",");
				ArrayList<java.util.Date> times = new ArrayList<java.util.Date>();
				for(String t: timesStringArray) {
					times.add(dateFormat.parse(t));
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
