package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import configs.DatabaseProperties;

/**
 * Create user
 * @author ben
 *
 */
public class CreateUser {
	
	public boolean create(CreateUserBean userBean) throws ClassNotFoundException {
		boolean status = false;
		
        Class.forName("com.mysql.cj.jdbc.Driver");
		
		try {
			
			 // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			// Check if user is already in database
			PreparedStatement check = con.prepareStatement("SELECT * FROM Users WHERE username = ?");
			check.setNString(1, userBean.getUsername());
			ResultSet checkResults = check.executeQuery();
			
			if (checkResults.next() == true) {
				checkResults.close();
				check.close();
				con.close();
				return false;
			}
			
			checkResults.close();
			check.close();
			
			// Query database for user
        	PreparedStatement search = con.prepareStatement("SELECT * FROM Users WHERE username = ? AND password = ?");
        	search.setNString(1, userBean.getUsername());
        	search.setNString(2, userBean.getPassword());
        	
        	// Execute SQL query and success boolean will determine output
        	ResultSet searchResults = search.executeQuery();
        	
        	// If user does not currently exist, create user
        	if (!searchResults.next()) {
        		
        		PreparedStatement create;
        		if (userBean.getPhoneNumber() != "") {
            		create = con.prepareStatement("INSERT INTO Users (username, password, email, phoneNumber) VALUES ('"
            										+userBean.getUsername()+"', '"
						    						+userBean.getPassword()+"', '"
						    						+userBean.getEmail()+"', '"
						    						+userBean.getPhoneNumber()+"')");
        		} else {
        			create = con.prepareStatement("INSERT INTO Users (username, password, email) VALUES ('"
        											+userBean.getUsername()+"', '"
        											+userBean.getPassword()+"', '"
        											+userBean.getEmail()+"')");
        		}
        
        		create.executeUpdate();
        		status = true;
        	}
        	searchResults.close();
        	search.close();
        	con.close();
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return status;
	}
}
