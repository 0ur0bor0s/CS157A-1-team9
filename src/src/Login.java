package src;

import java.sql.*;

import configs.DatabaseProperties;


/**
 * Server login logic
 * @author ben
 *
 */
public class Login {
	
	/**
	 * 
	 * @param loginBean
	 * @return valid_status
	 * @throws ClassNotFoundException
	 */
	public boolean validate(LoginBean loginBean) throws ClassNotFoundException {
		boolean valid_status = false;	
		
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        try {
            // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
        	// Query database for user
        	PreparedStatement ps = con.prepareStatement("SELECT * FROM Users WHERE username = ? AND password = ?");
        	ps.setNString(1, loginBean.getUsername());
        	ps.setNString(2, loginBean.getPassword());
        	System.out.println(ps);
        	
        	// Execute SQL query and success boolean will determine output
        	ResultSet rs = ps.executeQuery();
        	valid_status = rs.next();
        	
        } catch (Exception e) {
        	System.out.println(e);
        }
        
		return valid_status;
	}
	
	
}
