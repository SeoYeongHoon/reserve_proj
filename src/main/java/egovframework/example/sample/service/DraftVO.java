package egovframework.example.sample.service;

public class DraftVO {
	private int draftNo;
	private String draftTitle;
	private String draftContent;
	private String userId;
	private String userName;
	private int resId;
	
	private int reqNo;
	private int draftType; // 0: 결재, 1: 협조, 2:참조
	private String requestId; // 결재 신청을 받은 user_id
	
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getReqNo() {
		return reqNo;
	}
	public void setReqNo(int reqNo) {
		this.reqNo = reqNo;
	}
	public int getDraftType() {
		return draftType;
	}
	public void setDraftType(int draftType) {
		this.draftType = draftType;
	}
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	public int getResId() {
		return resId;
	}
	public void setResId(int resId) {
		this.resId = resId;
	}
	
	@Override
	public String toString() {
		return "DraftVO [draftNo=" + draftNo + ", draftTitle=" + draftTitle + ", draftContent=" + draftContent
				+ ", userId=" + userId + ", resId=" + resId + ", reqNo=" + reqNo + ", draftType=" + draftType
				+ ", requestId=" + requestId + "]";
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
