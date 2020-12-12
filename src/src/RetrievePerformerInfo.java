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
		
		// Formatter for dates
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			System.out.println("querying info for performer");
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
			
			pqr.next();

			p.setPerformerType(PerformerType.valueOf((pqr.getString("Performers.performerType"))));
			
			TimeZone.setDefault(TimeZone.getTimeZone("UTC"));	// necessary?
						
			p.setAbout(pqr.getString("Performers.about"));
			System.out.println("about: " + p.getAbout());

			String groupedEvents = pqr.getNString("events");
			String[] eventsArray = groupedEvents.split(",");
			ArrayList<String> events = new ArrayList<String>(Arrays.asList(eventsArray));
			p.addEvents(events);
			System.out.println("#events: " + events.size());
			
			String groupedVenues = pqr.getString("venues");
			String[] venuesArray = groupedVenues.split(",");
			ArrayList<String> venues = new ArrayList<String>(Arrays.asList(venuesArray));
			p.addVenues(venues);
			System.out.println("#venues: " + venues.size());
			
			String groupedTimes = pqr.getString("times");
			String[] timesStringArray = groupedTimes.split(",");
			ArrayList<java.util.Date> times = new ArrayList<java.util.Date>();
			for(String t: timesStringArray) {
				times.add(dateFormat.parse(t));
			}
			p.addTimes(times);
			System.out.println("#times: " + times.size());
			
			pqr.close();
			con.close();
			performerquery.close();
			
			
		} catch (Exception e) {
			System.err.println(e);
		}	
		return p;
	}
	
	
	public PerformerBean retrievePerformerName(Integer adminCode){
		
		PerformerBean p = new PerformerBean(adminCode);
		
		// Formatter for dates
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Query database for event info
			PreparedStatement performerquery = con.prepareStatement("SELECT Performers.name\n" + 
					"FROM Performers, Users\n" + 
					"WHERE Performers.performId = Users.performerId AND Users.adminCode = ?" +
					"GROUP BY Events.name;");
			performerquery.setInt(1, adminCode);
			ResultSet pqr = performerquery.executeQuery();
			
			pqr.next();
			p.setName(pqr.getString("Performers.name"));
			
			pqr.close();
			con.close();
			performerquery.close();
			
		} catch (Exception e) {
			System.err.println(e);
		}
		return p;
	}
	
}