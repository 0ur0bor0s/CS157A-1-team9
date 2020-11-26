package src;
import java.io.Serializable;
import java.util.ArrayList;

/**
 * Bean for retrieving Event information
 * @author ben
 *
 */
public class EventBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String eventName;
	private String venueName;
	private java.util.Date datetime;
	private ArrayList<String> performers;
	private PerformerType ptype;
	private String address;
	private String city;
	private String district;
	private int zipcode;
	private String country;
	
	
	public String getEventName() {
		return eventName;
	}
	
	public String getVenueName() {
		return venueName;
	}
	
	public java.util.Date getDatetime() {
		return datetime;
	}

	public ArrayList<String> getPerformers() {
		return performers;
	}
	
	public PerformerType getPerformerType() {
		return ptype;
	}
	
	public String getAddress() {
		return address;
	}
	
	public String getCity() {
		return city;
	}
	
	public String getDistrict() {
		return district;
	}
	
	public int getZipcode() {
		return zipcode;
	}
	
	public String getCountry() {
		return country;
	}
	
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	
	public void setVenueName(String venueName) {
		this.venueName = venueName;
	}
	
	public void setDatetime(java.util.Date datetime) {
		this.datetime = datetime;
	}

	
	public void setPerformers(ArrayList<String> performers) {
		this.performers = performers;
	}
	
	public void setPerformerType(PerformerType ptype) {
		this.ptype = ptype;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public void setDistrict(String district) {
		this.district = district;
	}
	
	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	
	public void setCountry(String country) {
		this.country = country;
	}

}
	