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