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
        	
        	// Execute SQL query and success boolean will determine output
        	ResultSet rs = ps.executeQuery();
        	valid_status = rs.next();
        	
        	ps.close();
        	con.close();	
        } catch (Exception e) {
        	System.out.println(e);
        }
        
		return valid_status;
	}
	
	
	/**
	 * Function to retrieve payment methods for a given user
	 * @param username
	 * @return A list of payment methods user has
	 */
	public java.util.ArrayList<PaymentMethodBean> retrievePaymentMethods(String username) {
		java.util.ArrayList<PaymentMethodBean> cards = new java.util.ArrayList<PaymentMethodBean>();
		
		try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement pmquery = con.prepareStatement("SELECT PaymentMethod.name, cardNum, expDate, cardType\n" + 
					"FROM PaymentMethod\n" + 
					"INNER JOIN Users ON PaymentMethod.userId = Users.userId\n" + 
					"WHERE Users.username = ?;");
			pmquery.setNString(1, username);
			ResultSet pmr = pmquery.executeQuery();
			
			while (pmr.next()) {
				PaymentMethodBean pmb = new PaymentMethodBean();
				pmb.setCardName(pmr.getNString("PaymentMethod.name"));
				pmb.setCardNo(pmr.getNString("cardNum"));
				pmb.setExpDate("expDate");
				pmb.setCardType(CardType.valueOf(pmr.getNString("cardType")));
				cards.add(pmb);
			}
	        
			pmr.close();
			pmquery.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return cards;
	}
	
	public boolean changeEmail(String email) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement updateemail = con.prepareStatement("");
			
			updateemail.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
	
}
