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
	 * Return the email from the user
	 * @param username
	 * @return
	 */
	public String getEmail(String username) {
		String email = "";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement emailquery = con.prepareStatement("SELECT email\n" + 
					"FROM Users\n" + 
					"WHERE username = ?;");
			emailquery.setNString(1, username);
			ResultSet er = emailquery.executeQuery();
			
			while (er.next()) {
				email = er.getNString("email");
			}
			
			emailquery.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return email;
	}
	
	/**
	 * Get user's phone number
	 * @param username
	 * @return
	 */
	public String getNumber(String username) {
		String phonenumber = "";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement numquery = con.prepareStatement("SELECT phoneNumber\n" + 
					"FROM Users\n" + 
					"WHERE username = ?;");
			numquery.setNString(1, username);
			ResultSet er = numquery.executeQuery();
			
			while (er.next()) {
				phonenumber = er.getNString("phoneNumber");
			}
			
			numquery.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return phonenumber;
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
				pmb.setExpDate(pmr.getNString("expDate"));
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
	
	/**
	 * Function to change a user's email address
	 * @param username
	 * @param email
	 * @return
	 */
	public boolean changeEmail(String username, String email) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement updateemail = con.prepareStatement("UPDATE Users\n" + 
					"SET email = ?\n" + 
					"WHERE username = ?");
			updateemail.setNString(1, email);
			updateemail.setNString(2, username);
			updateemail.execute();
			
			status = true;
			
			updateemail.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
	/**
	 * Change the phone number of a user
	 * @param username
	 * @param phonenumber
	 * @return
	 */
	public boolean changeNumber(String username, String phonenumber) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement updatenumber = con.prepareStatement("UPDATE Users\n" + 
					"SET phoneNumber = ?\n" + 
					"WHERE username = ?");
			updatenumber.setNString(1, phonenumber);
			updatenumber.setNString(2, username);
			updatenumber.execute();
			
			status = true;
			
			updatenumber.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
	
	/**
	 * Function to change the user's password
	 * @param username
	 * @param password
	 * @return
	 */
	public boolean changePassword(String username, String password) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
        	
			PreparedStatement updatepassword = con.prepareStatement("UPDATE Users\n" + 
					"SET password = ?\n" + 
					"WHERE username = ?");
			updatepassword.setNString(1, password);
			updatepassword.setNString(2, username);
			updatepassword.execute();
			
			status = true;
			
			updatepassword.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
	
	/**
	 * Delete the payment info of a given user
	 * @param username
	 * @param pmb
	 * @return
	 */
	public boolean deletePaymentInfo(String username, PaymentMethodBean pmb) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			PreparedStatement deleteinfo = con.prepareStatement("DELETE FROM PaymentMethod\n" + 
					"WHERE userId = (SELECT userId FROM Users Where username = ?) AND name = ? AND cardNum = ? AND expDate = ?;");
			deleteinfo.setNString(1, username);
			deleteinfo.setNString(2, pmb.getCardName());
			deleteinfo.setNString(3, pmb.getCardNo());
			deleteinfo.setNString(4, pmb.getExpDate());
			deleteinfo.execute();
			
			status = true;
			
			deleteinfo.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
	
	/**
	 * Add payment information for for card
	 * @param username
	 * @param pmb
	 * @return
	 */
	public boolean addPaymentInfo(String username, PaymentMethodBean pmb) {
		boolean status = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Connect to database
    		DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			PreparedStatement addpay = con.prepareStatement("INSERT INTO PaymentMethod\n" + 
					"VALUES ((SELECT userId FROM Users WHERE username = ?), ?, ?, ?, ?);");
			addpay.setNString(1, username);
			addpay.setNString(2, pmb.getCardName());
			addpay.setNString(3, pmb.getCardNo());
			addpay.setNString(4, pmb.getExpDate());
			addpay.setNString(5, pmb.getCardType().name());
			addpay.execute();
			
			status = true;
			
			addpay.close();
			con.close();
		} catch (Exception e) {
			System.err.println(e);
		}
		
		return status;
	}
	
}
