package egovframework.example.sample.service;

public class GuestsVO {
	private int resId;
	private String guestName;
	private int guestGender;
	private int guestType;
	private int isDisabled;
	private int isForeigner;
	private int guestNo;
	private int groupId;
	private String guestSido;
	private String guestGugun;
	
	public int getResId() {
		return resId;
	}
	public void setResId(int resId) {
		this.resId = resId;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public int getGuestGender() {
		return guestGender;
	}
	public void setGuestGender(int guestGender) {
		this.guestGender = guestGender;
	}
	public int getIsDisabled() {
		return isDisabled;
	}
	public void setIsDisabled(int isDisabled) {
		this.isDisabled = isDisabled;
	}
	public int getIsForeigner() {
		return isForeigner;
	}
	public void setIsForeigner(int isForeigner) {
		this.isForeigner = isForeigner;
	}
	public int getGuestNo() {
		return guestNo;
	}
	public void setGuestNo(int guestNo) {
		this.guestNo = guestNo;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public String getGuestSido() {
		return guestSido;
	}
	public void setGuestSido(String guestSido) {
		this.guestSido = guestSido;
	}
	public String getGuestGugun() {
		return guestGugun;
	}
	public void setGuestGugun(String guestGugun) {
		this.guestGugun = guestGugun;
	}
	public int getGuestType() {
		return guestType;
	}
	public void setGuestType(int guestType) {
		this.guestType = guestType;
	}
	@Override
	public String toString() {
		return "GuestsVO [resId=" + resId + ", guestName=" + guestName + ", guestGender=" + guestGender + ", guestType="
				+ guestType + ", isDisabled=" + isDisabled + ", isForeigner=" + isForeigner + ", guestNo=" + guestNo
				+ ", groupId=" + groupId + ", guestSido=" + guestSido + ", guestGugun=" + guestGugun + "]";
	}
}
