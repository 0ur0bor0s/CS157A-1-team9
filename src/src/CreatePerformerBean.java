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
	private Integer performerId;

	
	public String getName() {
		return name;
	}
	
	public PerformerType getPerformerType() {
		return ptype;
	}
	
	public Integer getPerformerId() {
		return performerId;
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
	
	public void setPerformerId(Integer performerId) {
		this.performerId= performerId;
	}
}
