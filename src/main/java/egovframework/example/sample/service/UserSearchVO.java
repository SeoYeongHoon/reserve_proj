package egovframework.example.sample.service;

public class UserSearchVO {
	private String searchKeyword = "";    // 검색어
	private String levelCondition = "1"; // 검색 조건 (직급)
    private String deptCondition = "1";  // 검색 조건 (부서)
    private int pageIndex = 1;       // 현재 페이지 번호
    private int pageUnit;            // 한 페이지에 보여줄 게시물 수
    private int pageSize;            // 페이지 네비게이션에 표시할 페이지 수
    private int firstIndex;          // 첫 게시물 인덱스
    private int lastIndex;           // 마지막 게시물 인덱스
    private int recordCountPerPage;  // 한 페이지에 표시할 게시물 수
    
    private int userDept;
    private int userLevel;
    
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getLevelCondition() {
		return levelCondition;
	}
	public void setLevelCondition(String levelCondition) {
		this.levelCondition = levelCondition;
	}
	public String getDeptCondition() {
		return deptCondition;
	}
	public void setDeptCondition(String deptCondition) {
		this.deptCondition = deptCondition;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public int getUserDept() {
		return userDept;
	}
	public void setUserDept(int userDept) {
		this.userDept = userDept;
	}
	public int getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}
	
	@Override
	public String toString() {
		return "UserSearchVO [searchKeyword=" + searchKeyword + ", levelCondition=" + levelCondition
				+ ", deptCondition=" + deptCondition + ", pageIndex=" + pageIndex + ", pageUnit=" + pageUnit
				+ ", pageSize=" + pageSize + ", firstIndex=" + firstIndex + ", lastIndex=" + lastIndex
				+ ", recordCountPerPage=" + recordCountPerPage + ", userDept=" + userDept + ", userLevel=" + userLevel
				+ "]";
	}
}
