package egovframework.example.sample.service;

import java.io.Serializable;

public class UserVO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String userId;
	private String userPw;
	private String userName;
	private String userType;
	private String userPhone;
	
	private int userLevel; // 0: 고객, 1: 사원, 2: 대리, 3: 과장, 4: 차장, 5: 부장, 6: 사장
	private int userDept; // 0: 없음, 1: 기획제안본부, 2: 사업관리본부, 3: 대표이사
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public int getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}
	public int getUserDept() {
		return userDept;
	}
	public void setUserDept(int userDept) {
		this.userDept = userDept;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", userType=" + userType
				+ ", userPhone=" + userPhone + ", userLevel=" + userLevel + ", userDept=" + userDept + "]";
	}
}
