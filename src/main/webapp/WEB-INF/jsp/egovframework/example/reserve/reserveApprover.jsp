<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재라인 선택</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
    .container {
        width: 100%;
		height: 1000px;
		margin: 50px auto;
        max-width: 1200px;
        background: #fff;
        border: 1px solid #ddd;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .header {
        display: flex;
        justify-content: space-between;
        padding: 10px 10px 40px 10px;
        border-bottom: 1px solid #ddd;
        font-size: 14px;
    	overflow-y: scroll;
    }
    .header .right {
        color: white;
        background-color: #6c8b3d;
        padding: 5px 10px;
        border-radius: 5px;
    }

    .search-section {
        /* display: flex;
        justify-content: space-between;
        align-items: center; */
        margin: 15px;
        width: 50%;
    }
    .search-section select, .search-section input[type="text"] {
        padding: 5px;
        font-size: 14px;
        border: 1px solid #ddd;
    	border-radius: 4px;
    }
    .search-section button {
        padding: 5px 10px;
        background-color: #2b7abf;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
    }
    .search-section button:hover {
        opacity: 0.6;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }
    table th, table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
        font-size: 14px;
    }
    table th {
        background-color: #f0f8ff;
    }

    .approval-section {
        /* display: flex;
        justify-content: space-between;
        margin-top: 15px; */
        width: 50%;
    }
    .approval-area {
    	display: flex;
    	justify-content: space-evenly;
    }
    .approval-box {
        width: 80%;
    }
    .approval-box h3 {
        font-size: 14px;
        text-align: center;
        margin-bottom: 5px;
    }
    .selectList {
    	width: 100%;
    	height: 130px;
    	border-radius: 4px;
    	border: 1px solid #ddd;
    }
    /* .approval-box textarea {
        width: 100%;
        height: 120px;
        resize: none;
        border: 1px solid #ddd;
    } */
    .approval-buttons {
        display: flex;
        flex-direction: column;
        justify-content: center;
        margin-top: 32px;
    }
    .approval-buttons button {
        margin: 2px 0;
        padding: 7px;
        font-size: 10pt;
        cursor: pointer;
        background-color: gray;
        color: white;
        border: none;
        border-radius: 5px;
    }
    .approval-buttons button:hover {
        opacity: 0.6;
    }

    .footer-buttons {
        margin-top: 8px;
        text-align: center;
        display: flex;
    	justify-content: end;
    }
    .footer-buttons button {
        padding: 5px 15px;
        margin: 0 10px;
        font-size: 14px;
        border: none;
        cursor: pointer;
        border-radius: 4px;
    }
    .footer-buttons button:hover {
    	opacity: 0.6;
    }
    .footer-buttons .reset {
        background-color: #6c757d;
        color: white;
    }
    .footer-buttons .save {
        background-color: #2e8540;
        color: white;
        margin-right: 250px;
    }
    .footer-buttons .update {
    	display: none;
    	background-color: orange;
        color: white;
        margin-right: 10px;
    }
    .footer-buttons .delete {
    	display: none;
    	background-color: red;
    	color: white;
    	margin-right: 170px;
    }
    .footer-buttons .submit {
        background-color: #007bff;
        color: white;
        margin-right: 22px;
    }
    
    .content-section {
    	display: flex;
    }
    
    .paging {
		text-align: center;
	    margin-top: 10px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	}
	.paging a {
		text-decoration: none;
	}
	
	.paging-number-on {
		background-color: darkgray;
	    display: inline-block;
	    color: white;
	    font-size: 13pt;
	    width: 25px;
	    height: 25px;
	    margin: 5px;
	    border-radius: 5px;
	}
	
	.paging-number-off {
		display: inline-block;
	    color: black;
	    font-size: 13pt;
	    width: 25px;
	    height: 25px;
	    margin: 5px;
	    border-radius: 5px;
	    border: 1px solid darkgray;
	}
	.paging-number-off:hover {
		text-decoration: none;
		background-color: darkgray;
	    color: white;
	}
	
	.paging-move-btn {
		display: inline-block;
	    color: black;
	    font-size: 12pt;
	    width: 25px;
	    height: 25px;
	    margin: 5px;
	    border-radius: 5px;
	    border: 1px solid darkgray;
	}
	.paging-move-btn:hover {
		text-decoration: none;
		background-color: darkgray;
	    color: white;
	}
	
	.userListRow {
		cursor: pointer;
	}
	.userListRow:hover {
		background-color: #ddd;
	}
	.userListRow.selected {
		background-color: #ddd;
	}
	
	.approval-title-area {
		margin-top: 15px;
	}
	.approval-title-input {
		width: 95%;
	    padding: 6px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	}
	
	.savedLineInfoRow {
		cursor: pointer;
	}
	.savedLineInfoRow:hover {
		background-color: #ddd;
	}
	.savedLineInfoRow.selected {
		background-color: #ddd;
	}
</style>
<body>
	<div class="container">
		<h1>결재라인 선택</h1>
        <div class="header">
        	<table>
        		<thead>
        			<tr>
        				<th>나의 결재 라인</th>
        				<th>수정일자</th>
        			</tr>
        		</thead>
        		<tbody id="savedLineInfo">
        			<c:forEach var="line" items="${lineList }" varStatus="status">
        				<input type="hidden" value="${line.lineNo }" id="lineNo_${line.lineNo }" />
        				<tr class="savedLineInfoRow" id="saved-line-row_${line.lineNo }" onclick="showSavedLineInfo(${line.lineNo})">
        					<td>${line.lineTitle }</td>
        					<td>${line.lineDate }</td>
        				</tr>
        			</c:forEach>
        		</tbody>
        		<c:forEach var="member" items="${memberList }" varStatus="status">
        			<input type="hidden" value="${member.memberNo }" id="memberNo_${member.lineNo }" />
        			<input type="hidden" class="memberIdList" value="${member.memberId }" id="memberId_${member.lineNo }" />
       				<input type="hidden" class="memberNameList" value="${member.memberInfo }" id="memberInfo_${member.lineNo }" />
       				<input type="hidden" class="memberTypeList" value="${member.memberType }" id="memberType_${member.lineNo }" />
        		</c:forEach>
        	</table>
        	<%-- <p>${memberList }</p> --%>
        </div>
        
        <div class="content-section">
        
	        <!-- 부서 직원 테이블 구역 -->
	        <div class="search-section">
                <table>
                	<colgroup>
                        <col width="10">
                        <col width="30">
                        <col width="10">
                        <col width="40">
                        <col width="10">
                       </colgroup>
                       <tbody>
                       	<tr>
                            <th>
                            	<label for="searchDept">부서</label>
                            </th>
                            <td colspan="4" style="text-align: start;">
                                <select id="searchDept" name="searchDept" style="width: 40%">
	                                <option value="0" selected="selected">전체</option>
	                                <option value="3">대표이사</option>
	                                <option value="2">사업관리본부</option>
	                                <option value="1">기획제안본부</option>
                                </select>
                            </td>
                        </tr> 
                        <tr>
                            <th style="width: 30px;">
                            	<label for="searchName">이름</label>
                            </th>
                            <td style="text-align: start;">
                                <input type="text" id="searchName" name="searchName">
                            </td>
                            <th style="width: 30px;">
                            	<label for="searchLevel">직급</label>
                            </th>
                            <td style="width: 80px;">
                                <select id="searchLevel" name="searchLevel" style="width: 98%">
	                                <option value="" selected="selected">전체</option>
	                                <option value="6">사장</option>
	                                <option value="5">부장</option>
	                                <option value="4">차장</option>
	                                <option value="3">과장</option>
	                                <option value="2">대리</option>
	                                <option value="1">사원</option>
                                </select>
                            </td>   
                            <td style="text-align: center;">
                            	<div>
                            		<button type="button" onclick="movePage(1)">검색</button>
                            	</div>
                            </td>
                        </tr>                   
                    </tbody>
                </table>
	            
		        <table>
		            <thead>
		                <tr>
		                    <th style="width: 50%;">부서</th>
		                    <th style="width: 50%;">이름</th>
		                </tr>
		            </thead>
		            <tbody id="userListBody">
	        			<c:forEach var="userInfo" items="${userList }" varStatus="status">
	        				<tr class="userListRow" id="user-row_${status.index }" onclick="selectUserRow(${status.index})">
	        					<td style="display: none;">${userInfo.userId }</td>
	        					<td>
	        						<c:choose>
	        							<c:when test="${userInfo.userDept eq 1}">
	        								기획제안본부
	        							</c:when>
	        							<c:when test="${userInfo.userDept eq 2 }">
	        								사업관리본부
	        							</c:when>
	        							<c:when test="${userInfo.userDept eq 3 }">
	        								대표이사
	        							</c:when>
	        						</c:choose>
	        					</td>
	        					<td>${userInfo.userName } 
	        						<c:choose>
	        							<c:when test="${userInfo.userLevel eq 1}">
	        								(사원)
	        							</c:when>
	        							<c:when test="${userInfo.userLevel eq 2 }">
	        								(대리)
	        							</c:when>
	        							<c:when test="${userInfo.userLevel eq 3 }">
	        								(과장)
	        							</c:when>
	        							<c:when test="${userInfo.userLevel eq 4 }">
	        								(차장)
	        							</c:when>
	        							<c:when test="${userInfo.userLevel eq 5 }">
	        								(부장)
	        							</c:when>
	        							<c:when test="${userInfo.userLevel eq 6 }">
	        								(사장)
	        							</c:when>
	        						</c:choose>
	        					</td>
	        				</tr>
	        			</c:forEach>
		            </tbody>
		        </table>
		        
		        <!-- 페이징 -->
				<div class="paging">
					<%-- <c:choose>
						<c:when test="${paginationInfo.currentPageNo > 1}">
							<a class="paging-move-btn" href="javascript:movePage(1)">&laquo;</a>
				        	<a class="paging-move-btn" href="javascript:movePage(${paginationInfo.currentPageNo - 1})">&lt;</a>
						</c:when>
						<c:otherwise>
							<a class="paging-move-btn" href="#">&laquo;</a>
				        	<a class="paging-move-btn" href="#">&lt;</a>
						</c:otherwise>
					</c:choose>
				    
				    <c:forEach var="pageNo" begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}">
				        <c:choose>
				            <c:when test="${pageNo == paginationInfo.currentPageNo}">
				                <span class="paging-number-on">${pageNo}</span>
				            </c:when>
				            <c:otherwise>
				                <a class="paging-number-off" href="javascript:movePage(${pageNo})">${pageNo}</a>
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				    
				    <c:choose>
				    	<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
				    		<a class="paging-move-btn" href="javascript:movePage(${paginationInfo.currentPageNo + 1})">&gt;</a>
				        	<a class="paging-move-btn" href="javascript:movePage(${paginationInfo.totalPageCount})">&raquo;</a>
				    	</c:when>
				    	<c:otherwise>
				    		<a class="paging-move-btn" href="#">&gt;</a>
				        	<a class="paging-move-btn" href="#">&raquo;</a>
				    	</c:otherwise>
				    </c:choose> --%>
				</div>
				
	        </div>
	        
	        <!-- 결재라인 구역 -->
	        <div class="approval-section">
	        	<div class="approval-title-area">
	        		<table>
	        			<tbody>
	        				<tr>
	        					<th style="width: 25%;">결재 라인 명</th>
	        					<td><input class="approval-title-input" id="lineTitle" type="text" /></td>
	        				</tr>
	        			</tbody>
	        		</table>
	        	</div>
	        	<div class="approval-area">
		            <div class="approval-buttons">
		                <button type="button" id="addApprovalBtn">▶ 추가</button>
		                <button type="button" id="deleteApprovalBtn">◀ 삭제</button>
		                <button type="button" id="upApprovalBtn">▲ 위로</button>
		                <button type="button" id="downApprovalBtn">▼ 아래</button>
		            </div>
		            <div class="approval-box">
		                <h3>결재자</h3>
		                <select id="approveList" class="selectList" name="approveList" multiple="multiple">
		                	<!-- <option>김대리 ( 대리 )</option> -->
		                </select>
		            </div>
	        	</div>
	        	
	        	<div class="approval-area">
		            <div class="approval-buttons">
		                <button type="button" id="addCooperationBtn">▶ 추가</button>
		                <button type="button" id="deleteCooperationBtn">◀ 삭제</button>
		                <button type="button" id="upCooperationBtn">▲ 위로</button>
		                <button type="button" id="downCooperationBtn">▼ 아래</button>
		            </div>
	        		<div class="approval-box">
		                <h3>협조자</h3>
		                <select id="coopList" class="selectList" name="coopList" multiple="multiple">
		                </select>
		            </div>
	        	</div>
	        	
	        	<div class="approval-area">
		            <div class="approval-buttons">
		                <button type="button" id="addReferenceBtn">▶ 추가</button>
		                <button type="button" id="deleteReferenceBtn">◀ 삭제</button>
		                <button type="button" id="upReferenceBtn">▲ 위로</button>
		                <button type="button" id="downReferenceBtn">▼ 아래</button>
		            </div>
	        		<div class="approval-box">
		                <h3>참조자</h3>
		                <select id="referList" class="selectList" name="referList" multiple="multiple">
		                </select>
		            </div>
	        	</div>
	        </div>
        </div>
        
        <div class="footer-buttons">
            <button type="button" class="reset" onclick="resetForm()">초기화</button>
            <button type="button" class="save" id="saveLineMember">등록</button>
            <button type="button" class="update" id="updateLineMember">수정</button>
            <button type="button" class="delete" id="deleteLineMember">삭제</button>
            <button type="button" class="submit" id="submitLineMember">선택</button>
        </div>
    </div>
</body>
<script>
	$(document).ready(function() {
		movePage(1);
	});
	
	// 페이징 함수
	function movePage(pageNo) {
	    let searchKeyword = $('#searchName').val();
	    let deptCondition = $('#searchDept').val();
	    let levelCondition = $('#searchLevel').val();
	
	    $.ajax({
	        url: 'api/userPaginating.do',
	        data: { 
	            pageNo: pageNo,
	            searchKeyword: searchKeyword,
	            deptCondition: deptCondition,
	            levelCondition: levelCondition
	        },
	        success: function(result) {
	        	let userList = result.userList;
	        	let tbody = $('#userListBody');
	            tbody.empty(); // 기존 데이터 초기화
	            
	            userList.forEach(function(user, index) {
	            	let userDeptText = "";
	            	if (user.userDept == "1") {
	            		userDeptText = "기획제안본부";
	            	} else if (user.userDept == "2") {
	            		userDeptText = "사업관리본부";
	            	} else if (user.userDept == "3") {
	            		userDeptText = "대표이사";
	            	}
	            	
	            	let userLevelText = "";
	            	if (user.userLevel == "1") {
	            		userLevelText = "사원";
	            	} else if (user.userLevel == "2") {
	            		userLevelText = "대리";
	            	} else if (user.userLevel == "3") {
	            		userLevelText = "과장";
	            	} else if (user.userLevel == "4") {
	            		userLevelText = "차장";
	            	} else if (user.userLevel == "5") {
	            		userLevelText = "부장";
	            	} else if (user.userLevel == "6") {
	            		userLevelText = "사장";
	            	}
	            	
	                tbody.append(
	                    '<tr class="userListRow" id="user-row_' + index + '" onclick="selectUserRow(' + index + ')">' +
	                        '<td style="display: none;">' + user.userId + '</td>' + 
	                        '<td>' + userDeptText + '</td>' +
	                        '<td>' + user.userName + ' (' + userLevelText + ')</td>' +
	                    '</tr>'
	                );
	            });
	
	            // 페이지 정보가 있다면 아래 페이징 UI 업데이트 함수 호출
	            updatePagingUI(result.paginationInfo);
	        },
	        error: function(err) {
	            console.error('에러: ', err);
	        }
	    });
	}
	
	// 페이징 UI 업데이트 함수
	function updatePagingUI(paginationInfo) {
	    let pagingDiv = $('.paging');
	    pagingDiv.empty(); // 기존 페이징 초기화
	
	    // 이전 페이지 링크 추가
	    if (paginationInfo.currentPageNo > 1) {
	        pagingDiv.append('<a class="paging-move-btn" href="javascript:movePage(1)">&laquo;</a>');
	        pagingDiv.append('<a class="paging-move-btn" href="javascript:movePage(' + (paginationInfo.currentPageNo - 1) + ')">&lt;</a>');
	    } else {
	        pagingDiv.append('<a class="paging-move-btn" href="#">&laquo;</a><a class="paging-move-btn" href="#">&lt;</a>');
	    }
	
	    // 페이지 번호 추가
	    for (let pageNo = paginationInfo.firstPageNoOnPageList; pageNo <= paginationInfo.lastPageNoOnPageList; pageNo++) {
	        if (pageNo === paginationInfo.currentPageNo) {
	            pagingDiv.append('<span class="paging-number-on">' + pageNo + '</span>');
	        } else {
	            pagingDiv.append('<a href="javascript:movePage(' + pageNo + ')" class="paging-number-off">' + pageNo + '</a>');
	        }
	    }
	
	    // 다음 페이지 링크 추가
	    if (paginationInfo.currentPageNo < paginationInfo.totalPageCount) {
	        pagingDiv.append('<a class="paging-move-btn" href="javascript:movePage(' + (paginationInfo.currentPageNo + 1) + ')">&gt;</a>');
	        pagingDiv.append('<a class="paging-move-btn" href="javascript:movePage(' + paginationInfo.totalPageCount + ')">&raquo;</a>');
	    } else {
	        pagingDiv.append('<a class="paging-move-btn" href="#">&gt;</a><a class="paging-move-btn" href="#">&raquo;</a>');
	    }
	}
	
	
	// 각 배열 선언
	let approvalListArr = []; // 결재자
	let cooperationListArr = []; // 협조자
	let referenceListArr = []; // 참조자

	// 유저 테이블 항목 클릭 및 객체에 담기
	let selectedUserObj = {};
	function selectUserRow(index) {
		$('.userListRow').removeClass('selected');
		$('#user-row_' + index).addClass("selected");
		
		// 선택한 row
		let selectedDatas = $('.userListRow.selected td');
		
		let selectedId = $(selectedDatas[0]).text(); // 아이디
		let selectedDept = $(selectedDatas[1]).text(); // 부서 이름
		let selectedName = $(selectedDatas[2]).text(); // 성함
	    
	    // 객체에 삽입
	    selectedUserObj = {
	    		userId: selectedId,
	    		userDept: selectedDept,
	    		userName: selectedName
	    }
	}
	
	// 결재자 추가
	$('#addApprovalBtn').on('click', function() {
	    addUser(selectedUserObj, approvalListArr, 'approveList');
	});
	// 결재자 삭제
	$('#deleteApprovalBtn').on('click', function() {
	    let selectedIndex = $('#approveList option:selected').index();
	    if (selectedIndex !== -1) {
	    	deleteUser(selectedIndex, approvalListArr, 'approveList');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});
	// 결재자 이동
	$('#upApprovalBtn').on('click', function() {
		let selectedIndex = $('#approveList option:selected').index();
	    if (selectedIndex !== -1) {
		    moveUser(approvalListArr, 'approveList', 'up');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	}); 
	$('#downApprovalBtn').on('click', function() {
	    let selectedIndex = $('#approveList option:selected').index();
	    if (selectedIndex !== -1) {
		    moveUser(approvalListArr, 'approveList', 'down');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});

	// 협조자 추가
	$('#addCooperationBtn').on('click', function() {
	    addUser(selectedUserObj, cooperationListArr, 'coopList');
	});
	// 협조자 삭제
	$('#deleteCooperationBtn').on('click', function() {
	    let selectedIndex = $('#coopList option:selected').index();
	    if (selectedIndex !== -1) {
	    	deleteUser(selectedIndex, cooperationListArr, 'coopList');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});
	// 협조자 이동
	$('#upCooperationBtn').on('click', function() {
	    let selectedIndex = $('#coopList option:selected').index();
	    if (selectedIndex !== -1) {
		    moveUser(cooperationListArr, 'coopList', 'up');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});
	$('#downCooperationBtn').on('click', function() {
		let selectedIndex = $('#coopList option:selected').index();
	    if (selectedIndex !== -1) {
		    moveUser(cooperationListArr, 'coopList', 'down');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});

	// 참조자 추가
	$('#addReferenceBtn').on('click', function() {
	    addUser(selectedUserObj, referenceListArr, 'referList');
	});
	// 참조자 삭제
	$('#deleteReferenceBtn').on('click', function() {
	    let selectedIndex = $('#referList option:selected').index();
	    if (selectedIndex !== -1) {
	    	deleteUser(selectedIndex, referenceListArr, 'referList');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});
	// 참조자 이동
	$('#upReferenceBtn').on('click', function() {
	    let selectedIndex = $('#referList option:selected').index();
	    if (selectedIndex !== -1) {
	    	moveUser(referenceListArr, 'referList', 'up');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});
	$('#downReferenceBtn').on('click', function() {
		let selectedIndex = $('#referList option:selected').index();
	    if (selectedIndex !== -1) {
	    	moveUser(referenceListArr, 'referList', 'down');
	    } else {
	    	alert("직원을 선택하세요.");
	    	return;
	    }
	});

	// 모든 선택란에서 중복된 직원 방지를 위한 Set
	let selectedUsersSet = new Set();
	let listArr = [];
	// 공통: 직원 추가 함수
	function addUser(selectedUserObj, listArr, listId) {
	    if (!selectedUserObj.userId) {
	        alert('직원을 선택해주세요.');
	        return;
	    }

	    // 이미 다른 선택란에 추가된 직원인지 확인
	    if (selectedUsersSet.has(selectedUserObj.userId)) {
	        alert('이미 선택된 직원입니다.');
	        return;
	    }

	    // 배열에 추가
	    listArr.push(selectedUserObj);

	    // Set에 추가
	    selectedUsersSet.add(selectedUserObj.userId);

	    // 선택란 UI 업데이트
	    updateListUI(listArr, listId);

	    // 선택 초기화
	    selectedUserObj = {};
	}

	// 공통: 직원 삭제 함수
	function deleteUser(index, listArr, listId) {
		
	    // Set에서 제거
	    selectedUsersSet.delete(listArr[index].userId);

	    // 배열에서 제거
	    listArr.splice(index, 1);

	    // 선택란 UI 업데이트
	    updateListUI(listArr, listId);
	}

	// UI 업데이트 함수
	function updateListUI(listArr, listId) {
	    let optionsHTML = '';
	    for (let i = 0; i < listArr.length; i++) {
	        optionsHTML += '<option id="' + listId + '_option_' + i + '" value="' + listArr[i].userId + '">' + listArr[i].userName + '</option>';
	    }
	    $('#' + listId).html(optionsHTML);
	}

	// 직원 이동 함수
	function moveUser(listArr, listId, direction) {
	    let selectedOption = $('#' + listId + ' option:selected');
	    let selectedIndex = selectedOption.index();
	    let totalOptions = listArr.length;

	    if (direction === 'up' && selectedIndex > 0) {
	        // 위로 이동
	        [listArr[selectedIndex - 1], listArr[selectedIndex]] = [listArr[selectedIndex], listArr[selectedIndex - 1]];
	        selectedOption.insertBefore(selectedOption.prev());
	    } else if (direction === 'down' && selectedIndex < totalOptions - 1) {
	        // 아래로 이동
	        [listArr[selectedIndex], listArr[selectedIndex + 1]] = [listArr[selectedIndex + 1], listArr[selectedIndex]];
	        selectedOption.insertAfter(selectedOption.next());
	    } else {
	        alert(direction === 'up' ? '더 이상 위로 이동할 수 없습니다.' : '더 이상 아래로 이동할 수 없습니다.');
	    }
	}

	// 결재 라인 등록 버튼
	$('#saveLineMember').on('click', function() {
		let lineTitle = $('#lineTitle').val();
		
		// 라인 명 입력 안 했을 경우
		if (lineTitle == '') {
			alert("결재 라인 명을 입력하세요.");
			return;
		}
		// 결재 라인에 선택된 직원이 하나도 없을 경우
	    if (selectedUsersSet.size === 0) {
	        alert("결재 라인을 최소 1명 이상 지정하세요.");
	        return;
	    }
		
		let saveObject = {
				lineTitle: lineTitle,
				approveLine: approvalListArr,
				coopLine: cooperationListArr,
				referLine: referenceListArr
		};
		
		if (confirm("저장하시겠습니까?")) {
			$.ajax({
				url: 'api/saveLineMember.do',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(saveObject),
				success: function(response) {
					location.reload(true);
				},
				error: function(err) {
					console.error("에러: ", err);
				}
			});
			
			// 초기화 함수
			resetForm();
		}
		
	});
	
	// 초기화 함수 정의
	function resetForm() {
	    $('#lineTitle').val(''); // 제목 초기화
	    $('#approveList').empty(); // 결재자 초기화
	    $('#coopList').empty(); // 협조자 초기화
	    $('#referList').empty(); // 참조자 초기화
		$('.userListRow').removeClass('selected');

	    // 데이터 배열 초기화
	    approvalListArr = [];
	    cooperationListArr = [];
	    referenceListArr = [];
	    selectedUsersSet.clear(); // 선택된 사용자 Set 초기화
	}
	
	// 저장된 결재 라인 클릭하여 출력
	function showSavedLineInfo(index) {
		resetForm();
		$('.save').css("display", "none");
		$('.update').css("display", "inline-block");
		$('.delete').css("display", "inline-block");
		
		$('.savedLineInfoRow').removeClass('selected');
		$('#saved-line-row_' + index).addClass("selected");
		
		$('#lineTitle').val($('.savedLineInfoRow.selected td').eq(0).text());
		
		let inputHtml = "<input type='hidden' id='myLineNo' value='" + index + "' />";
		$('#lineTitle').append(inputHtml);
		
		let memberNameList = $('.memberNameList');
		let memberIdList = $('.memberIdList');
		let memberTypeList = $('.memberTypeList');
		
		for (let i = 0; i < memberNameList.length; i++) {
			if ($(memberTypeList[i]).val() == 0) {
				let optionHtml = "";
				optionHtml += "<option value=''>" + $(memberNameList[i]).val() + "</option>";
				$('#approveList').append(optionHtml);
				
				selectedUserObj = {
						userDept: "대표이사",
						userId: $(memberIdList[i]).val(),
						userName: $(memberNameList[i]).val()
				}
				
				selectedUsersSet.add(selectedUserObj.userId);
				approvalListArr.push(selectedUserObj);
				selectedUserObj = {};
			} else if ($(memberTypeList[i]).val() == 1) {
				let optionHtml = "";
				optionHtml += "<option value=''>" + $(memberNameList[i]).val() + "</option>";
				$('#coopList').append(optionHtml);
				
				selectedUserObj = {
						userDept: "사업관리본부",
						userId: $(memberIdList[i]).val(),
						userName: $(memberNameList[i]).val()
				}
				
				selectedUsersSet.add(selectedUserObj.userId);
				cooperationListArr.push(selectedUserObj);
				selectedUserObj = {};
			} else if ($(memberTypeList[i]).val() == 2) {
				let optionHtml = "";
				optionHtml += "<option value=''>" + $(memberNameList[i]).val() + "</option>";
				$('#referList').append(optionHtml);
				
				selectedUserObj = {
						userDept: "기획제안본부",
						userId: $(memberIdList[i]).val(),
						userName: $(memberNameList[i]).val()
				}
				
				selectedUsersSet.add(selectedUserObj.userId);
				referenceListArr.push(selectedUserObj);
				selectedUserObj = {};
			}
		}
	}
	
	// 저장된 결재 라인 수정
	$('#updateLineMember').on('click', function() {
		let lineTitle = $('#lineTitle').val();
		let lineNo = $('#myLineNo').val();
		
		// 라인 명 입력 안 했을 경우
		if (lineTitle == '') {
			alert("결재 라인 명을 입력하세요.");
			return;
		}
		// 결재 라인에 선택된 직원이 하나도 없을 경우
	    if (selectedUsersSet.size === 0) {
	        alert("결재 라인을 최소 1명 이상 지정하세요.");
	        return;
	    }
		
	 	// ajax로 넘길 객체
		let updateObject = {
				lineNo: lineNo,
				lineTitle: lineTitle,
				approveLine: approvalListArr,
				coopLine: cooperationListArr,
				referLine: referenceListArr
		}
		
		if (confirm("수정하시겠습니까?")) {
			$.ajax({
				url: 'api/updateLineMember.do',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(updateObject),
				success: function(response) {
					location.reload(true);
				},
				error: function(err) {
					console.error("에러: ", err);
				}
			});
		}
	});
	
	$('#deleteLineMember').on('click', function() {
		let lineNo = $('#myLineNo').val();
		
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				url: 'api/deleteLineInfo.do',
				type: 'GET',
				data: { lineNo : lineNo },
				success: function(response) {
					location.reload(true);
				},
				error: function(err) {
					console.error("에러: ", err);
				}
			});
		}
	});
	
	// ajax로 넘길 객체
	let submitObject = {};
	
	$('#submitLineMember').on('click', function() {
		let lineTitle = $('#lineTitle').val();
		let lineNo = $('#myLineNo').val();
		
		// 결재 라인에 선택된 직원이 하나도 없을 경우
	    if (selectedUsersSet.size === 0) {
	        alert("결재 라인을 최소 1명 이상 지정하세요.");
	        return;
	    }
		
		submitObject = {
				lineNo: lineNo,
				lineTitle: lineTitle,
				approveLine: approvalListArr,
				coopLine: cooperationListArr,
				referLine: referenceListArr
		}
		
		if (confirm("결재라인을 선택하시겠습니까?")) {
			$.ajax({
				url: 'reserveDraft.do',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(submitObject),
				success: function(response) {
					if (response.success) {
						// 부모 창에 데이터 전달
						if (window.opener) {
							// 부모 창의 각 태그 초기화
							window.opener.$('#approval-tbody').html('');
		                    window.opener.$('#coop-tbody').html('');
		                    window.opener.$('#refer-tbody').html('');
							
		                    // 부모 창의 특정 DOM에 데이터 추가		                    
		                    // 결재자 데이터
		                    let sendApproveData = "";
		                    for (let i = 0; i < submitObject.approveLine.length; i++) {
			                    sendApproveData += "<tr>";
		                    	sendApproveData += "<td>" + submitObject.approveLine[i].userName + "</td>";
		                    	sendApproveData += "<input type='hidden' class='approveLines' value='" + submitObject.approveLine[i].userId + "' id='approveLineId_" + i + "'/>";
			                    sendApproveData += "</tr>";
		                    }
		                    
		                    // 협조자 데이터
		                    let sendCoopData = "";
		                    for (let i = 0; i < submitObject.coopLine.length; i++) {
			                    sendCoopData += "<tr>";
		                    	sendCoopData += "<td>" + submitObject.coopLine[i].userName + "</td>";
		                    	sendCoopData += "<input type='hidden' class='coopLines' value='" + submitObject.coopLine[i].userId + "' id='coopLineId_" + i + "'/>";
			                    sendCoopData += "</tr>";
		                    }
		                    
		                    // 참조자 데이터
		                    let sendReferData = "";
		                    for (let i = 0; i < submitObject.referLine.length; i++) {
			                    sendReferData += "<tr>";
		                    	sendReferData += "<td>" + submitObject.referLine[i].userName + "</td>";
		                    	sendReferData += "<input type='hidden' class='referLines' value='" + submitObject.referLine[i].userId + "' id='referLineId_" + i + "'/>";
			                    sendReferData += "</tr>";
		                    }
		                    
		                    
		                    window.opener.$('#approval-tbody').append(sendApproveData);
		                    window.opener.$('#coop-tbody').append(sendCoopData);
		                    window.opener.$('#refer-tbody').append(sendReferData);
		                } else {
		                    console.error("부모 창이 없음");
		                }
						
						window.close();
			        }
				},
				error: function(err) {
					console.error("에러: ", err);
				}
			});
		}
	});
</script>
</html>