package configs;

import java.io.*;
import java.util.*;

/**
 * Class used to manage config file settings
 * @author ben
 *
 */
public class DatabaseProperties {
	public String username = "";
	public String password = "";
	public String name = "";
	public String port = "";
	public String websiteURL = "";
	
	/**
	 * Constructor that reads file and populates config information
	 * @throws IOException
	 */
	public DatabaseProperties() throws IOException {
		
		try {
			Properties prop = new Properties();
			String filename = "configs/config.properties";
			
			// Stream file
			InputStream inputStream = getClass().getClassLoader().getResourceAsStream(filename);
			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("Config file not found: " + filename);
			}
			
			// Load properties into output string array
			username = prop.getProperty("db_username");
			password = prop.getProperty("db_password");
			name = prop.getProperty("db_name");
			port = prop.getProperty("db_port");
			websiteURL = prop.getProperty("url");
			
			// Close stream
			inputStream.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
}
