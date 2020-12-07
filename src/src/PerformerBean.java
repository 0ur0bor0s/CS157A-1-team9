package src;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Bean for retrieving performer information
 * @author jalend
 * 
 */
public class PerformerBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private PerformerType ptype;
	private String about;
	private ArrayList<String> eventNames;	// use EventBeans or create fields for all necessary event info?? -- if EventBeans, rest unnecessary v.
	private ArrayList<String> eventTimes;
	private ArrayList<String> eventVenues;
	
	public PerformerBean(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public String getAbout() {
		return about;
	}
	
	public PerformerType getPerformerType() {
		return ptype;
	}
	
	public ArrayList<String> getEventsNames(){
		return eventNames;
	}
	
	public ArrayList<String> getEventTimes(){
		return eventTimes;
	}
	
	public ArrayList<String> getEventVenues(){
		return eventVenues;
	}
	
	public void setAbout(String about) {
		this.about = about;
	}
	
	public void setPerformerType(PerformerType ptype) {
		this.ptype = ptype;
	}
	
	public void addEvent(String eventName) {
		this.eventNames.add(eventName);
	}
	
	public void addTime(String eventTime) {
		this.eventTimes.add(eventTime);
	}
	
	public void addVenue(String eventVenue) {
		this.eventVenues.add(eventVenue);
	}
}
