package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import configs.DatabaseProperties;

/**
 * create performer and add to db
 * @author jalend
 */
public class CreatePerformer {
	public String create(CreatePerformerBean performerBean) throws ClassNotFoundException {
		String status = ""; // represents bit flags of |username_status|adminCode_status|performerName_status| 
		
        Class.forName("com.mysql.cj.jdbc.Driver");
		
		try {
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			PreparedStatement check;
			ResultSet checkResults;
			
			System.out.println("attempting to create performer user");
			// Check if username is already in database
			check = con.prepareStatement("SELECT * FROM Users WHERE username = ?");
			check.setNString(1, performerBean.getUsername());
			checkResults = check.executeQuery();
			if (!checkResults.next()) {
				System.out.println("username available");
				status += "1";
			} else {
				status += "0";
			}
			
			// check if adminCode is already in database
			check = con.prepareStatement("SELECT * FROM Users WHERE adminCode = ?");
			check.setInt(1, performerBean.getAdminCode());
			checkResults = check.executeQuery();
			if (!checkResults.next()) {
				System.out.println("admin code valid");
				status += "1";
			} else {
				status += "0";
			}
			
			// check if performer name is already in database
			check = con.prepareStatement("SELECT * FROM Performers WHERE name = ?");
			check.setNString(1, performerBean.getName());
			checkResults = check.executeQuery();
			if (!checkResults.next()) {
				System.out.println("name available");
				status += "1";
			} else {
				status += "0";
			}
			checkResults.close();
			check.close();
			
			System.out.println("performer creation status: " + status);
			System.out.println("adminCode to be inserted: " + performerBean.getAdminCode());
			if (!status.equals("111")) {	// at least one of the fields already exist in the db
				return status;
			} else {
				PreparedStatement create;
				System.out.println("phone #: " + performerBean.getPhoneNumber());
        		if (performerBean.getPhoneNumber() != "") {	// might need to include userId and performerId and make userId = adminCode = performerId
            		create = con.prepareStatement("INSERT INTO Users (username, password, email, phoneNumber, adminCode) VALUES ('"
            										+performerBean.getUsername()+"', '"
						    						+performerBean.getPassword()+"', '"
						    						+performerBean.getEmail()+"', '"
						    						+performerBean.getPhoneNumber()+"', '"
						    						+performerBean.getAdminCode()+"')");    		          		
        		} else {
        			create = con.prepareStatement("INSERT INTO Users (username, password, email, adminCode) VALUES ('"
        											+performerBean.getUsername()+"', '"
        											+performerBean.getPassword()+"', '"
        											+performerBean.getEmail()+"', '"
        											+performerBean.getAdminCode()+"')");
          		}
        		
        		create.executeUpdate();
        		
        		//**** THIS NEEDS TO BE EDITED TO UPDATE USERS.PERFORMERID TO PERFORMERS.PERFORMERID ****//
        		create = con.prepareStatement("INSERT INTO Performers (name, performerType) VALUES ('"
						+performerBean.getName()+"', '"
						+performerBean.getPerformerType()+"')");
        		create.executeUpdate();
        		create = con.prepareStatement("UPDATE USERS SET perfromerId = Performers.performerId WHERE Performers.performerId = Peformers.performerId");
        		
        		create.close();
            	con.close();
        		return status;
			}        	
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return status;
	}
}
