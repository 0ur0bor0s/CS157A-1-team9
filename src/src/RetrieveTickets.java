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
			PreparedStatement ticketQuery = con.prepareStatement("SELECT ticketId, price\n" + 
					"FROM Tickets \n" + 
					"INNER JOIN Events ON Tickets.eventId = Events.eventId\n" + 
					"INNER JOIN Venues ON Events.venueId = Venues.venueId \n" + 
					"INNER JOIN Addresses ON Venues.addressId = Addresses.addressId\n" + 
					"WHERE  Tickets.ticketId NOT IN (SELECT ticketId FROM Buys)\n" + 
					"AND Events.name LIKE ? AND time LIKE ? AND venueName LIKE ? AND Address LIKE ? AND zipCode LIKE ? \n" + 
					"LIMIT 50;");
			ticketQuery.setNString(1, eb.getEventName());
			ticketQuery.setNString(2, dateFormat.format(eb.getDatetime()));
			ticketQuery.setNString(3, eb.getVenueName());
			ticketQuery.setNString(4, eb.getAddress());
			ticketQuery.setInt(5, eb.getZipcode());
			ResultSet tr = ticketQuery.executeQuery();
			
			while (tr.next()) {
				TicketBean tb = new TicketBean(eb);
				tb.setTicketId(tr.getInt("ticketId"));
				tb.setPrice(tr.getFloat("price"));
				tickets.add(tb);
			}

			tr.close();
			ticketQuery.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace();
		}
		
		return tickets;
	}
	
	/**
	 * Function to return a list of tickets the user has listed
	 * @param username
	 * @return
	 */
	public java.util.ArrayList<TicketBean> retrieveUserListed(String username) {
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

			PreparedStatement ticketQuery = con.prepareStatement("SELECT Tickets.ticketId, price, Events.name, time, venueName, address, zipCode, city, district, country, GROUP_CONCAT(Performers.name) perfs, GROUP_CONCAT(performerType) types\n" + 
					"					FROM Tickets\n" + 
					"					INNER JOIN Lists ON Tickets.ticketId = Lists.ticketId \n" + 
					"					INNER JOIN Users ON Lists.userId = Users.userId\n" + 
					"					INNER JOIN Events ON Tickets.eventId = Events.eventId \n" + 
					"					INNER JOIN Venues ON Events.venueId = Venues.venueId \n" + 
					"					INNER JOIN Addresses ON Venues.addressId = Addresses.addressId \n" + 
					"					INNER JOIN Cities ON Addresses.cityId = Cities.cityId\n" + 
					"					INNER JOIN Performs ON Events.eventId = Performs.eventId \n" + 
					"					INNER JOIN Performers ON Performs.performId = Performers.performId \n" + 
					"					WHERE username LIKE ? AND NOT EXISTS(SELECT * FROM Buys WHERE Buys.ticketId IN (SELECT ticketId \n" + 
					"																											 FROM Lists \n" + 
					"																											 INNER JOIN Users ON Lists.userId = Users.userId \n" + 
					"					                                                                                         WHERE username LIKE ?))\n" + 
					"					GROUP BY Tickets.ticketId;");
			ticketQuery.setNString(1, "%" + username + "%");
			ticketQuery.setNString(2, "%" + username + "%");
			ResultSet tr = ticketQuery.executeQuery();
			
			while (tr.next()) {
				TicketBean tb = new TicketBean();
				
				tb.setEventName(tr.getNString("Events.name"));
				tb.setVenueName(tr.getNString("venueName"));
				tb.setDatetime(tr.getTimestamp("time"));
				tb.setAddress(tr.getString("address"));
				
				String CSV_perfs = tr.getNString("perfs");
				String[] perfArray = CSV_perfs.split(",");
				ArrayList<String> performList = new ArrayList<String>(Arrays.asList(perfArray));
				tb.setPerformers(performList);
				
				String CSV_types = tr.getNString("types");
				String[] typeStrArray = CSV_types.split(",");
				ArrayList<PerformerType> typeList = new ArrayList<PerformerType>();
				for (String s : typeStrArray) {
					typeList.add(PerformerType.valueOf(s));
				}
				tb.setPerformerTypes(typeList);

				tb.setCity(tr.getString("city"));
				tb.setDistrict(tr.getString("district"));
				tb.setCountry(tr.getString("country"));
				tb.setZipcode(tr.getInt("zipCode"));
				tb.setPrice(tr.getFloat("price"));
				tb.setTicketId(tr.getInt("ticketId"));
				tb.setSellerUsername(username);
				tickets.add(tb);
			}
			
			tr.close();
			ticketQuery.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		
		return tickets;
	}
	
	/**
	 * Function to return a list of tickets the user has purchased
	 * @param username
	 * @return
	 */
	public java.util.ArrayList<TicketBean> retrieveUserBought(String username) {
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

			PreparedStatement ticketQuery = con.prepareStatement("SELECT Tickets.ticketId, time, price, Events.name, venueName, address, zipCode, city, district, country, GROUP_CONCAT(Performers.name) perfs, GROUP_CONCAT(DISTINCT performerType) types\n" + 
					"					FROM Tickets\n" + 
					"					INNER JOIN Buys ON Tickets.ticketId = Buys.ticketId\n" + 
					"					INNER JOIN Users ON Buys.userId = Users.userId \n" + 
					"					INNER JOIN Events ON Tickets.eventId = Events.eventId \n" + 
					"					INNER JOIN Venues ON Events.venueId = Venues.venueId \n" + 
					"					INNER JOIN Addresses ON Venues.addressId = Addresses.addressId \n" + 
					"					INNER JOIN Cities ON Addresses.cityId = Cities.cityId\n" + 
					"					INNER JOIN Performs ON Events.eventId = Performs.eventId \n" + 
					"					INNER JOIN Performers ON Performs.performId = Performers.performId \n" + 
					"					WHERE username LIKE ?\n" + 
					"                    GROUP BY Tickets.ticketId;");
			ticketQuery.setNString(1, "% " + username + "%");
			ResultSet tr = ticketQuery.executeQuery();
			
			while (tr.next()) {
				TicketBean tb = new TicketBean();
				
				tb.setEventName(tr.getNString("Events.name"));
				tb.setVenueName(tr.getNString("venueName"));
				tb.setDatetime(tr.getTimestamp("time"));
				tb.setAddress(tr.getString("address"));
				
				String CSV_perfs = tr.getNString("perfs");
				String[] perfArray = CSV_perfs.split(",");
				ArrayList<String> performList = new ArrayList<String>(Arrays.asList(perfArray));
				tb.setPerformers(performList);
				
				String CSV_types = tr.getNString("types");
				String[] typeStrArray = CSV_types.split(",");
				ArrayList<PerformerType> typeList = new ArrayList<PerformerType>();
				for (String s : typeStrArray) {
					typeList.add(PerformerType.valueOf(s));
				}
				tb.setPerformerTypes(typeList);
				
				tb.setCity(tr.getString("city"));
				tb.setDistrict(tr.getString("district"));
				tb.setCountry(tr.getString("country"));
				tb.setZipcode(tr.getInt("zipCode"));
				tb.setPrice(tr.getFloat("price"));
				tb.setTicketId(tr.getInt("ticketId"));
				tb.setSellerUsername(username);
				tickets.add(tb);
			}
			
			tr.close();
			ticketQuery.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		
		return tickets;
	}
	
}
