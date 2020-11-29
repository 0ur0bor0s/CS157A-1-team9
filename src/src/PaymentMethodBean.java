package src;

import java.io.Serializable;

public class PaymentMethodBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String cardNo;
	private String expDate;
	private CardType cardType;
	
	public String getCardName() {
		return name;
	}
	
	public String getCardNo() {
		return cardNo;
	}
	
	public String getExpDate() {
		return expDate;
	}
	
	public CardType getCardType() {
		return cardType;
	}
	
	public void setCardName(String name) {
		this.name = name;
	}
	
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	
	public void setCardType(CardType cardType) {
		this.cardType = cardType;
	}
	
}
