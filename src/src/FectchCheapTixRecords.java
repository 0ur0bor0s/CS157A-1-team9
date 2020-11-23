package src;
import java.sql.*;

import configs.DatabaseProperties;

/**
 * Fetch usernames
 * @author ben
 *
 */
public class FectchCheapTixRecords {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try { Class.forName("com.mysql.cj.jdbc.Driver");
			
			// Database config
			DatabaseProperties dp = new DatabaseProperties();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:"+dp.port+"/"+dp.name+"?serverTimezone=UTC", dp.username, dp.password);
			
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Users");
			while (rs.next()) {
				System.out.println(rs.getInt(1)+" "+rs.getString(2));
			}
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
