package egovframework.example.sample.service;

public class LineVO {
	private int lineNo;
	private String lineTitle;
	private String lineDate;
	private String userId;
	
	private int memberNo;
	private String memberInfo;
	private int memberType;
	private String memberId;
	
	public int getLineNo() {
		return lineNo;
	}
	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}
	public String getLineTitle() {
		return lineTitle;
	}
	public void setLineTitle(String lineTitle) {
		this.lineTitle = lineTitle;
	}
	public String getLineDate() {
		return lineDate;
	}
	public void setLineDate(String lineDate) {
		this.lineDate = lineDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberInfo() {
		return memberInfo;
	}
	public void setMemberInfo(String memberInfo) {
		this.memberInfo = memberInfo;
	}
	public int getMemberType() {
		return memberType;
	}
	public void setMemberType(int memberType) {
		this.memberType = memberType;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	@Override
	public String toString() {
		return "LineVO [lineNo=" + lineNo + ", lineTitle=" + lineTitle + ", lineDate=" + lineDate + ", userId=" + userId
				+ ", memberNo=" + memberNo + ", memberInfo=" + memberInfo + ", memberType=" + memberType + ", memberId="
				+ memberId + "]";
	}
}
