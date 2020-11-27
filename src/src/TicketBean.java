package src;

import java.io.Serializable;
import java.util.Date;
import java.util.ArrayList;

/**
 * A bean for ticket data, extends EventBean for event data
 * @author ben
 *
 */
public class TicketBean extends EventBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int numberTickets;
	private float price;
	private boolean isPurchased = false;
	private int sellerId;
	
	public TicketBean(EventBean eb) {
		super.setEventName(eb.getEventName());
		super.setVenueName(eb.getVenueName());
		super.setDatetime(eb.getDatetime());
		super.setPerformers(eb.getPerformers());
		super.setPerformerType(eb.getPerformerType());
		super.setAddress(eb.getAddress());
		super.setCity(eb.getCity());
		super.setDistrict(eb.getDistrict());
		super.setZipcode(eb.getZipcode());
		super.setCountry(eb.getCountry());
	}
	
	public void setNumberTickets(int numberTickets) {
		this.numberTickets = numberTickets;
	}
	
	public void setPrice(float price) {
		this.price = price;
	}
	
	public void setIsPurchased(boolean isPurchased) {
		this.isPurchased = isPurchased;
	}
	
	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}
	
	public float getPrice() {
		return price;
	}
	
	public boolean getIsPurchased() {
		return isPurchased;
	}
	
	public int getSellerId() {
		return sellerId;
	}
	
	public int getNumberTickets() {
		return numberTickets;
	}
	
}