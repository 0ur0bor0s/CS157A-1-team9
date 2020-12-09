package src;

import java.io.Serializable;

public class CreatePerformerBean extends CreateUserBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String name;
	private Integer adminCode;
	
	public String getName() {
		return name;
	}
	
	public Integer getAdminCode() {
		return adminCode;
	}
	
	public void setAdminCode(Integer adminCode) {
		this.adminCode = adminCode;
	}
	
	public void setName(String name) {
		this.name = name;
	}
}
