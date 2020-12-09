package src;

import java.io.Serializable;

/**
 * 
 * @author jalend
 *
 */
public class CreatePerformerBean extends CreateUserBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String name;
	private Integer adminCode;
	private PerformerType ptype;
	
	public String getName() {
		return name;
	}
	
	public PerformerType getPerformerType() {
		return ptype;
	}
	
	public Integer getAdminCode() {
		return adminCode;
	}
	
	public void setPerformerType(PerformerType ptype) {
		this.ptype = ptype;
	}
	
	public void setAdminCode(Integer adminCode) {
		this.adminCode = adminCode;
	}
	
	public void setName(String name) {
		this.name = name;
	}
}
