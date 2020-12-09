package src;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Bean for retrieving performer information
 * @author jalend
 * 
 */
public class PerformerBean extends CreateUserBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private PerformerType ptype;
	private String about;
	private ArrayList<String> eventNames;	// use EventBeans or create fields for all necessary event info?? -- if EventBeans, rest unnecessary v.
	private ArrayList<java.util.Date> eventTimes;
	private ArrayList<String> eventVenues;
	private Integer adminCode;
	private Integer performerId;
	
	
	public PerformerBean(String name) {
		this.name = name;
	}
	
	public PerformerBean(Integer adminCode) {
		this.adminCode = adminCode;
	}
	
	public String getName() {
		return name;
	}
	
	public String getAbout() {
		return about;
	}
	
	public Integer getAdminCode() {
		return adminCode;
	}
	
	public Integer performerId() {
		return performerId;
	}
	
	public PerformerType getPerformerType() {
		return ptype;
	}
	
	public ArrayList<String> getEventsNames(){
		return eventNames;
	}
	
	public ArrayList<java.util.Date> getEventTimes(){
		return eventTimes;
	}
	
	public ArrayList<String> getEventVenues(){
		return eventVenues;
	}
	
	public void setAdminCode(Integer adminCode) {
		this.adminCode = adminCode;
	}
	
	public void setPerformerId(Integer performerId) {
		this.performerId = performerId;
	}
	
	public void setAbout(String about) {
		this.about = about;
	}
	
	public void setPerformerType(PerformerType ptype) {
		this.ptype = ptype;
	}
	
	public void addEvents(ArrayList<String> eventNames) {
		this.eventNames = eventNames;
	}
	
	public void addTimes(ArrayList<java.util.Date> eventTimes) {
		this.eventTimes = eventTimes;
	}
	
	public void addVenues(ArrayList<String> eventVenues) {
		this.eventVenues = eventVenues;
	}
}
