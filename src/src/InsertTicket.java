package src;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import configs.DatabaseProperties;

/**
 * Class to insert ticket into database
 * @author ben
 *
 */
public class InsertTicket {
	
	/**
	 * Insert ticket into database
	 * @param tb
	 */
	public boolean insert(TicketBean tb) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Formatter for dates
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			// Connect to database
			DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Search if event data already exists in database and if it doesn't then add it
			PreparedStatement eventquery = con.prepareStatement("SELECT Events.name " + 
				"FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId " + 
				"			INNER JOIN Addresses ON Venues.addressId = Addresses.addressId " + 
				"			INNER JOIN Cities ON Addresses.cityId = Cities.cityId " + 
				"			INNER JOIN Performs ON Events.eventId = Performs.eventId " + 
				"			INNER JOIN Performers ON Performs.performId = Performers.performId " + 
				"WHERE Events.name = ? AND time = ? AND venueName = ? " + 
				"AND address = ? AND city = ? AND district = ? AND zipCode = ?");			
			eventquery.setNString(1, tb.getEventName());
			eventquery.setNString(2, dateFormat.format(tb.getDatetime()));
			eventquery.setNString(3, tb.getVenueName());
			eventquery.setNString(4, tb.getAddress());
			eventquery.setNString(5, tb.getCity());
			eventquery.setNString(6, tb.getDistrict());
			eventquery.setInt(7, tb.getZipcode());
			ResultSet eventResult = eventquery.executeQuery();
			
			// If the result is empty then add event to database
			if (!eventResult.isBeforeFirst()) {
				// Insert city
				PreparedStatement insertCity = con.prepareStatement("INSERT INTO Cities(city, district, country) " + 
					"SELECT ?, ?, ? " + 
					"FROM dual " + 
					"WHERE NOT EXISTS ( " + 
					"SELECT * " + 
					"FROM Cities " + 
					"WHERE city = ? AND district = ? AND country = ?)");
				insertCity.setNString(1, tb.getCity());
				insertCity.setNString(4, tb.getCity());
				insertCity.setNString(2, tb.getDistrict());
				insertCity.setNString(5, tb.getDistrict());
				insertCity.setNString(3, tb.getCountry());
				insertCity.setNString(6, tb.getCountry());
				insertCity.execute();
				
				// Insert address
				PreparedStatement insertAddress = con.prepareStatement("INSERT INTO Addresses(address, cityId, zipCode) " + 
					"SELECT ?, (SELECT cityId FROM Cities WHERE city = ? AND district = ? AND country = ?), ? " + 
					"FROM dual " + 
					"WHERE NOT EXISTS ( " + 
					"SELECT * " + 
					"FROM Addresses WHERE address = ? AND cityId = (SELECT cityId FROM Cities " + 
					"												WHERE city = ? AND district = ? AND country = ?) AND zipCode = ?)");
				insertAddress.setNString(1, tb.getAddress());
				insertAddress.setNString(2, tb.getCity());
				insertAddress.setNString(3, tb.getDistrict());
				insertAddress.setNString(4, tb.getCountry());
				insertAddress.setInt(5, tb.getZipcode());
				insertAddress.setNString(6, tb.getAddress());
				insertAddress.setNString(7, tb.getCity());
				insertAddress.setNString(8, tb.getDistrict());
				insertAddress.setNString(9, tb.getCountry());
				insertAddress.setInt(10, tb.getZipcode());
				insertAddress.execute();
				
				// Insert venue
				PreparedStatement insertVenue = con.prepareStatement("INSERT INTO Venues(venueName, addressId) " + 
					 "SELECT ?, (SELECT addressId FROM Addresses " + 
					 "			 INNER JOIN Cities ON Addresses.cityId = Cities.cityId " + 
					 "           WHERE address = ? AND city = ? AND district = ? AND country = ?) " + 
					 "FROM dual " + 
					 "WHERE NOT EXISTS ( " + 
					 "SELECT * " + 
					 "FROM Venues WHERE venueName = ? AND addressId = (SELECT addressId FROM Addresses " + 
					 "						  INNER JOIN Cities ON Addresses.cityId = Cities.cityId " + 
					 "                        WHERE address = ? AND city = ? AND district = ? AND country = ?))");
				insertVenue.setNString(1, tb.getVenueName());
				insertVenue.setNString(2, tb.getAddress());
				insertVenue.setNString(3, tb.getCity());
				insertVenue.setNString(4, tb.getDistrict());
				insertVenue.setNString(5, tb.getCountry());
				insertVenue.setNString(6, tb.getVenueName());
				insertVenue.setNString(7, tb.getAddress());
				insertVenue.setNString(8, tb.getCity());
				insertVenue.setNString(9, tb.getDistrict());
				insertVenue.setNString(10, tb.getCountry());
				insertVenue.execute();
				
				// Update address with new venueId
				PreparedStatement updateVenueId = con.prepareStatement("UPDATE Addresses, Venues " + 
				   "SET Addresses.venueId = Venues.venueId " + 
				   "WHERE Addresses.addressId = Venues.venueId");
				updateVenueId.execute();
				
				
				// Insert event
				PreparedStatement insertEvent = con.prepareStatement("INSERT INTO Events(venueId, name, time)\n" + 
						"SELECT (SELECT Venues.venueId FROM Venues\n" + 
						"							INNER JOIN Addresses ON Venues.addressId = Addresses.addressId\n" + 
						"							WHERE venueName = ? AND address = ? \n" + 
						"							AND zipCode = ?), ?, ?\n" + 
						"FROM dual\n" + 
						"WHERE NOT EXISTS (\n" + 
						"	SELECT *\n" + 
						"    FROM Events \n" + 
						"    WHERE venueId = (SELECT Venues.venueId FROM Venues\n" + 
						"							INNER JOIN Addresses ON Venues.addressId = Addresses.addressId\n" + 
						"							WHERE venueName = ? AND address = ? \n" + 
						"							AND zipCode = ?) AND name = ? AND time = ?\n" + 
						");");

				
				insertEvent.setNString(1, tb.getVenueName());
				insertEvent.setNString(2, tb.getAddress());
				insertEvent.setInt(3, tb.getZipcode());
				insertEvent.setNString(4, tb.getEventName());
				insertEvent.setNString(5, dateFormat.format(tb.getDatetime()));
				insertEvent.setNString(6, tb.getVenueName());
				insertEvent.setNString(7, tb.getAddress());
				insertEvent.setInt(8, tb.getZipcode());
				insertEvent.setNString(9, tb.getEventName());
				insertEvent.setNString(10, dateFormat.format(tb.getDatetime()));
				insertEvent.execute();
				
				// Iterate through each performer
				for (String perfName : tb.getPerformers()) {
					// Insert performer
					PreparedStatement insertPerformer = con.prepareStatement("INSERT INTO Performers(name, performerType) " + 
						"SELECT ?, ? " + 
						"FROM dual " + 
						"WHERE NOT EXISTS ( " + 
						"SELECT * " + 
						"FROM Performers WHERE name = ? AND performerType = ?)");
					insertPerformer.setNString(1, perfName);
					insertPerformer.setNString(2, tb.getPerformerType().name());
					insertPerformer.setNString(3, perfName);
					insertPerformer.setNString(4, tb.getPerformerType().name());
					insertPerformer.execute();
					
					
					// Insert performance
					PreparedStatement insertPerformance = con.prepareStatement("INSERT INTO Performs(performId, eventId)\n" + 
						"SELECT (SELECT performId FROM Performers WHERE name = ? AND performerType = ?), " + 
						"	   (SELECT eventId FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId " + 
						"							INNER JOIN Addresses ON Venues.addressId = Addresses.addressId " + 
						"							WHERE Events.name = ? AND time = ? AND venueName = ? AND address = ? AND zipCode = ? LIMIT 1) " + 
						"FROM dual " + 
						"WHERE NOT EXISTS ( " + 
						"SELECT * " + 
						"FROM Performs WHERE performId = (SELECT performId FROM Performers WHERE name = ? AND performerType = ?) " + 
						"AND eventId = (SELECT eventId FROM Events INNER JOIN Venues ON Events.venueId = Venues.venueId " + 
						"			   INNER JOIN Addresses ON Venues.addressId = Addresses.addressId " + 
						"			   WHERE Events.name = ? AND time = ? AND venueName = ? AND address = ? AND zipCode = ? LIMIT 1) " + 
						")");
					insertPerformance.setNString(1, perfName);
					insertPerformance.setNString(2, tb.getPerformerType().name());
					insertPerformance.setNString(3, tb.getEventName());
					insertPerformance.setNString(4, dateFormat.format(tb.getDatetime()));
					insertPerformance.setNString(5, tb.getVenueName());
					insertPerformance.setNString(6, tb.getAddress());
					insertPerformance.setInt(7, tb.getZipcode());
					insertPerformance.setNString(8, perfName);
					insertPerformance.setNString(9, tb.getPerformerType().name());
					insertPerformance.setNString(10, tb.getEventName());
					insertPerformance.setNString(11, dateFormat.format(tb.getDatetime()));
					insertPerformance.setNString(12, tb.getVenueName());
					insertPerformance.setNString(13, tb.getAddress());
					insertPerformance.setInt(14, tb.getZipcode());
					insertPerformance.execute();
				}
				
				System.out.println("New event created.");
			} else {
				System.out.println("Event already exists.");
			}
			eventResult.close();
			
			// List the desired number of tickets
			for (int i=0; i<tb.getNumberTickets(); i++) {
				// Add ticket to Tickets table
				PreparedStatement insertTicket = con.prepareStatement("INSERT INTO Tickets(price, eventId) " + 
				  "VALUES (?, (SELECT eventId FROM Events " + 
				  "				INNER JOIN Venues ON Events.venueId = Venues.venueId " + 
				  "             INNER JOIN Addresses ON Venues.addressId = Addresses.addressId " + 
				  "             WHERE Events.name = ? AND time = ? AND venueName = ? AND address = ? AND zipCode = ?))");
				insertTicket.setFloat(1, tb.getPrice());
				insertTicket.setNString(2,  tb.getEventName());
				insertTicket.setNString(3, dateFormat.format(tb.getDatetime()));
				insertTicket.setNString(4, tb.getVenueName());
				insertTicket.setNString(5,  tb.getAddress());
				insertTicket.setInt(6, tb.getZipcode());
				insertTicket.execute();
				
				// Insert ticket into listing
				PreparedStatement insertList = con.prepareStatement("INSERT INTO Lists(userId, ticketId, timestamp) " + 
					"VALUES ((SELECT userId FROM Users Where username = ?), (SELECT ticketId " + 
					"			FROM Tickets ORDER BY ticketId DESC LIMIT 1), ?)");
				insertList.setNString(1, tb.getSellerUsername());
				java.util.Date now = new java.util.Date();
				java.sql.Timestamp timestamp = new java.sql.Timestamp(now.getTime());
				insertList.setTimestamp(2, timestamp);
				insertList.execute();
				
				System.out.println("Ticket was successfully listed.");
				status = true;
			}
		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace();
		}
		
		return status;
	}
	
	/**
	 * Function for user to purchase ticket
	 * @param ticketId
	 * @param username
	 * @return a boolean status on the success of the insertion
	 */
	public boolean buyTicket(int ticketId, String username) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Connect to database
			DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			PreparedStatement buyticket = con.prepareStatement("INSERT INTO Buys(userId, ticketId, timestamp) VALUES (?, ?, NOW())");
			buyticket.setInt(1, ticketId);
			buyticket.setNString(2, username);
			status = buyticket.execute();
			
			buyticket.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
	
	/**
	 * Function to delete listing of ticket which a user owns
	 * @param ticketId
	 */
	public void deleteTicket(int ticketId) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect to database
			DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			PreparedStatement deleteTicket = con.prepareStatement("DELETE FROM Tickets WHERE ticketId = ?;\n");
			deleteTicket.setInt(1, ticketId);
			PreparedStatement safemodeoff = con.prepareStatement("SET_SQL_SAFE_UPDATES = 0;");
			PreparedStatement deleteBuys = con.prepareStatement("DELETE FROM Buys WHERE ticketId = ?;");
			deleteBuys.setInt(1, ticketId);
			PreparedStatement safemodeon = con.prepareStatement("SET SQL_SAFE_UPDATES = 1;");
			
			deleteTicket.execute();
			safemodeoff.execute();
			deleteBuys.execute();
			safemodeon.execute();
			
			deleteTicket.close();
			safemodeoff.execute();
			deleteBuys.execute();
			safemodeon.execute();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return;
	}
	
	
	public void changeTicketPrice(int ticketId, float price) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect to database
			DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			PreparedStatement deleteTicket = con.prepareStatement("UPDATE Tickets\n" + 
					"SET price = ?\n" + 
					"WHERE ticketId = ?");
			deleteTicket.setFloat(1, price);
			deleteTicket.setInt(2, ticketId);
			deleteTicket.execute();
			
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return;
	}
}
