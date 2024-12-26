package egovframework.example.sample.service;

public class ReserveVO {
	private int resId;
	private String resTitle;
	private String resDate;
	private String resTime;
	private Integer resMax;
	private Integer eventNo;
	private String resEndTime;
	
	private String userId;
	private String userName;
	private String isRepresent;
	private int groupId;
	private int resCount;
	private String userPhone;
	
	private String guestName;
	private int guestGender;
	private int isDisabled;
	private int isForeigner;
	
	private int draftNo;
	private String draftTitle;
	private String draftContent;
	
	private int isRequested; // 0: 마감X, 1: 마감신청, 2: 마감 완료
	
	public int getResId() {
		return resId;
	}
	public void setResId(int resId) {
		this.resId = resId;
	}
	public String getResTitle() {
		return resTitle;
	}
	public void setResTitle(String resTitle) {
		this.resTitle = resTitle;
	}
	public String getResDate() {
		return resDate;
	}
	public void setResDate(String resDate) {
		this.resDate = resDate;
	}
	public String getResTime() {
		return resTime;
	}
	public void setResTime(String resTime) {
		this.resTime = resTime;
	}
	public Integer getResMax() {
		return resMax;
	}
	public void setResMax(Integer resMax) {
		this.resMax = resMax;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIsRepresent() {
		return isRepresent;
	}
	public void setIsRepresent(String isRepresent) {
		this.isRepresent = isRepresent;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public int getResCount() {
		return resCount;
	}
	public void setResCount(int resCount) {
		this.resCount = resCount;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
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
	public int getDraftNo() {
		return draftNo;
	}
	public void setDraftNo(int draftNo) {
		this.draftNo = draftNo;
	}
	public String getDraftTitle() {
		return draftTitle;
	}
	public void setDraftTitle(String draftTitle) {
		this.draftTitle = draftTitle;
	}
	public String getDraftContent() {
		return draftContent;
	}
	public void setDraftContent(String draftContent) {
		this.draftContent = draftContent;
	}
	public int getIsRequested() {
		return isRequested;
	}
	public void setIsRequested(int isRequested) {
		this.isRequested = isRequested;
	}
	public Integer getEventNo() {
		return eventNo;
	}
	public void setEventNo(Integer eventNo) {
		this.eventNo = eventNo;
	}
	public String getResEndTime() {
		return resEndTime;
	}
	public void setResEndTime(String resEndTime) {
		this.resEndTime = resEndTime;
	}
	
	@Override
	public String toString() {
		return "ReserveVO [resId=" + resId + ", resTitle=" + resTitle + ", resDate=" + resDate + ", resTime=" + resTime
				+ ", resMax=" + resMax + ", eventNo=" + eventNo + ", resEndTime=" + resEndTime + ", userId=" + userId
				+ ", userName=" + userName + ", isRepresent=" + isRepresent + ", groupId=" + groupId + ", resCount="
				+ resCount + ", userPhone=" + userPhone + ", guestName=" + guestName + ", guestGender=" + guestGender
				+ ", isDisabled=" + isDisabled + ", isForeigner=" + isForeigner + ", draftNo=" + draftNo
				+ ", draftTitle=" + draftTitle + ", draftContent=" + draftContent + ", isRequested=" + isRequested
				+ "]";
	}
}

