<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약정보 상세 및 변경</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
	#reservePostForm {
		max-width: 1600px;
		margin: 120px auto;
	}
	.reserve-table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	}
	
	.reserve-table th, .reserve-table td {
	    border: 1px solid #ddd;
	    padding: 12px;
	}
	
	.reserve-table th {
	    background-color: #f4f4f4;
	    width: 20%;
	    color: #555;
	}
	
	.reserve-table td input {
	    width: 90%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	.button-section {
	    margin-top: 20px;
	    text-align: right;
	}
	
	.btn {
	    padding: 10px 20px;
	    font-size: 14px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-weight: bold;
	}
	.btn:hover {
		opacity: 0.6;
	}
	
	.finish-btn {
		background-color: #000;
		color: #fff;
	}
	.requested-btn {
		background-color: #000;
		opacity: 0.6;
		color: #fff;
	}
	.delete-btn {
		float: left;
		background-color: red;
		color: #fff;
	}
	
	.back-btn {
	    background-color: #333;
	    color: #fff;
	    float: left;
	}	
	.save-btn {
	    background-color: #ff4500;
	    color: #fff;
	}
	.add-user-btn {
		background-color: blue;
		color: #fff;
	}
	
	.user-table-container {
		margin: 30px 0;
		border-top: 2px solid #000;
	}
	.user-table {
	    width: 100%;
	    border-collapse: collapse;
	}	
	.user-table th {
	    background-color: #f4f4f4;
	    border-bottom: 1px solid #ddd;
	    height: 50px;
	    color: #555;
	}
	.user-table td {
		border-bottom: 1px solid #ddd;
		height: 60px;
		text-align: center;
	}
	.user-table td input {
	    width: 90%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	.checkUserBtn {
	    background-color: #ddd;
    	color: #000;
	}
	.deleteResBtn {
		background-color: coral;
		color: #fff;
	}
	.printGradBtn {
	    background-color: #333;
	    color: #fff;
	}
	
	#show-reserved-users {
		position: fixed;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background: white;
	    border-radius: 8px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    z-index: 1000;
	    display: none;
	    width: 1200px;
	    height: 1000px;
	    padding: 30px;
	}
	
	#overlay {
		position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5);
	    z-index: 999;
	    display: none;
	}
	.hidden {
		display: none;
	}
	.confirm-btn {
		position: absolute;
	    bottom: 15px;
	    right: 15px;
	    background-color: coral;
	    padding: 15px 30px;
	    color: white;
	}
	
	.represent-detail-table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	.represent-detail-table th, .represent-detail-table td {
	    border: 1px solid #ddd;
	    padding: 12px;
	}
	
	.represent-detail-table th {
	    background-color: #f4f4f4;
	    width: 20%;
	    color: #555;
	}
	
	.represent-detail-table td input {
	    width: 90%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	.detail-table-container {
		margin-top: 30px;
	}
	.user-detail-table {
	    width: 100%;
	    border-collapse: collapse;
	}	
	.user-detail-table th {
	    background-color: #f4f4f4;
	    border-bottom: 1px solid #ddd;
	    height: 50px;
	    color: #555;
	}
	.user-detail-table td {
		border-bottom: 1px solid #ddd;
		height: 40px;
		text-align: center;
	}
	.user-detail-table td input {
	    width: 90%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
</style>
<body>
	<form id="reservePostForm" action="reservePost.do" method="POST">
		<h1>예약정보 변경</h1>
		<h2>예약정보 확인</h2>
		<input type="hidden" id="resId" value="${resInfo.resId }" />
		<table class="reserve-table">
            <tr>
                <th>체험명</th>
                <td>${resInfo.resTitle }</td>
                <th>날짜</th>
                <td>${resInfo.resDate }</td>
            </tr>
            <tr>
                <th>시간</th>
                <td>${resInfo.resTime }</td>
                <th>제한인원수</th>
                <td>
                	<div>
	                	<input type="number" id="max-input" name="maxPeople" placeholder="제한 인원 입력" value="${resInfo.resMax }" />
	                	<p style="margin-bottom: 0;">(예약 건수: ${fn:length(resRepreInfos)}, 예약 인원: ${resCount })</p>
                	</div>
                </td>
            </tr>
        </table>
        <div class="button-section">
            <c:if test="${resInfo.isRequested eq 0 }">
            	<button type="button" class="btn finish-btn" id="finishBtn">예약마감</button>
        		<button type="button" class="btn delete-btn" id="deleteBtn">예약삭제</button>
            	<button type="button" class="btn save-btn" id="saveBtn">저장</button>
            </c:if>
            <c:if test="${resInfo.isRequested eq 1 }">
            	<button type="button" class="btn requested-btn" disabled>마감신청 중</button>
            </c:if>
            <c:if test="${isApprover.draftType eq 0 && resInfo.isRequested eq 1}">
            	<button type="button" class="btn finish-btn" id="approve-btn">결재</button>
            </c:if>
            <c:if test="${resInfo.isRequested eq 2 }">
            	<p style="margin: 0; color: red; font-weight: bold;">마감된 예약입니다.</p>
            </c:if>
        </div>
        <div class="user-table-container">
	        <table class="user-table">
	        	<thead>
		        	<tr>
		        		<th>번호</th>
		        		<th>체험명</th>
		        		<th>예약구분</th>
		        		<th>예약시간</th>
		        		<th>예약자명</th>
		        		<th>예약자수</th>
		        		<th>예약자확인</th>
		        		<th>삭제</th>
		        		<th>수료증</th>
		        	</tr>
	        	</thead>
	        	<tbody>
        		<c:forEach var="info" items="${resRepreInfos }" varStatus="status">
        			<tr>
	        			<td>${status.count }</td>
	        			<td>${resInfo.resTitle }</td>
	        			<td>
	        				<c:choose>
	        					<c:when test="${info.resCount < 1 }">
	        						개인
	        					</c:when>
	        					<c:otherwise>
	        						단체
	        					</c:otherwise>
	        				</c:choose>
	        			</td>
	        			<td>${resInfo.resDate } (${resInfo.resTime })</td>
	        			<td>${info.userName }</td>
	        			<td>${info.resCount }</td>
	        			<td><button type="button" class="btn checkUserBtn" onclick="checkUsersInfo(${info.groupId})">확인</button></td>
	        			<td><button type="button" class="btn deleteResBtn" onclick="deleteGroup(${info.groupId})">삭제</button></td>
	        			<td><button type="button" class="btn printGradBtn">출력</button></td>
        			</tr>
        			<input type="hidden" id="representName_${info.groupId }" value="${info.userName }" />
        			<input type="hidden" id="representPhone_${info.groupId }" value="${info.userPhone }" />
        			<input type="hidden" id="representDate_${info.groupId }" value="${resInfo.resDate } (${resInfo.resTime })" />
        			<input type="hidden" id="representTitle_${info.groupId }" value="${resInfo.resTitle }" />
        			<input type="hidden" id="representGroup_${info.groupId }" value="${info.groupId }" />
        		</c:forEach>
	        	</tbody>
	        </table>
        </div>
        <div class="button-section">
            <button type="button" class="btn back-btn" onclick="goBackCalendar()">돌아가기</button>
            <button type="button" class="btn add-user-btn" id="add-user-btn">예약자 추가</button>
        </div>
	</form>
	
	<!-- 예약자 확인(팝업창) -->
	<div id="overlay"></div>
	<div id="show-reserved-users" class="hidden">
		<h1>예약 확인</h1>
		<h2>예약 정보</h2>
		<div class="user-table-container">
			<table class="represent-detail-table"></table>
		</div>
		<div class="detail-table-container">
	        <table class="user-detail-table"></table>
	    </div>
	    
	    <button type="button" class="btn confirm-btn" id="confirmBtn">확인</button>
	</div>
</body>
<script>
	// 돌아가기 버튼
	function goBackCalendar() {
		location.href = 'adminCalendar.do';
	}
	
	let resId = $('#resId').val();
	
	// 예약자 추가 버튼
	$('#add-user-btn').on('click', function() {
		location.href = "requestReserve.do?resId=" + resId;
	});
	
	// 예약 삭제 버튼
	$('#deleteBtn').on('click', function() {
		if (confirm("예약을 삭제하시겠습니까?")) {			
			location.href = "deleteReserve.do?resId=" + resId;
		}
	});
	
	// 팝업창 띄워서 예약 정보 확인
	function checkUsersInfo(id) { 
		let confirmBtn = $('#confirmBtn');
		let popup = $('#show-reserved-users');
		let overlay = $('#overlay');

	    // 팝업창 열기
	    popup.removeClass("hidden");
	    popup.css("display", "block");
	    overlay.removeClass("hidden");
	    overlay.css("display", "block");

	    // 팝업창 닫기
	    confirmBtn.on('click', function() {
	    	popup.addClass("hidden");
	    	popup.css("display", "none");
	    	overlay.addClass("hidden");
	    	overlay.css("display", "none");
	        representDetailTable.html("");
	    });

	    // 팝업창 이외에 클릭 시 닫기
	    overlay.on('click', function() {
	    	popup.addClass("hidden");
	    	popup.css("display", "none");
	    	overlay.addClass("hidden");
	    	overlay.css("display", "none");
	        representDetailTable.html("");
	    });
	    
	 	// 대표자 테이블 출력
	 	let representDetailTable = $(".represent-detail-table");

	    let repHtml = '';
	    repHtml += '<tr><th>대표자명</th><td>' + $('#representName_' + id).val() + '</td></tr>';
	    repHtml += '<tr><th>대표 연락처</th><td>' + $('#representPhone_' + id).val() + '</td></tr>';
	    repHtml += '<tr><th>날짜</th><td>' + $('#representDate_' + id).val() + '</td></tr>';
	    repHtml += '<tr><th>프로그램명</th><td>' + $('#representTitle_' + id).val() + '</td></tr>';

	    // innerHTML을 사용하여 태그를 파싱
	    representDetailTable.html(repHtml);

	 	// 대표자 제외 예약자 테이블 출력
	 	let guestDetailTable = $('.user-detail-table');
	 	let groupId = $('#representGroup_' + id).val();
	 	
	 	$.ajax({
	 		url: 'api/getUserInfos.do',
	 		type: 'GET',
	 		data: { groupId: groupId },
	 		dataType: 'json',
	 		success: function(data) {
	 			// console.log(data);
	 			generateUserTable(data);
	 		},
	 		error: function(error) {
	 			console.error("에러: ", error);
	 		}
	 	});
	}
	
	// 대표자 외 유저 정보 출력
	function generateUserTable(data) {
		let userDetailTable = $('.user-detail-table');
	 	
		let userHtml = '';
		userHtml += '<thead><tr><th>번호</th><th>이름</th><th>성별</th><th>시 / 도</th><th>구 / 군</th><th>장애여부</th><th>외국인</th></tr></thead>';
		userHtml += '<tbody>';
	 	for (let i = 0; i < data.length; i++) {
 			userHtml += '<tr><td>' + (i + 1) + '</td>';
 			userHtml += '<td>' + data[i].guestName + '</td>';
 			userHtml += '<td>';
 			if (data[i].guestGender == '1') {
 				userHtml += '여자';
 			} else {
 				userHtml += '남자';
 			}
 			userHtml += '</td>';
 			
 			userHtml += '<td>' + data[i].guestSido + '</td>';
 			userHtml += '<td>' + data[i].guestGugun + '</td>';
 			
 			userHtml += '<td>';
 			if (data[i].isDisabled == '1') {
 				userHtml += 'O';
 			} else {
 				userHtml += 'X';
 			}
 			userHtml += '</td>';
 			
 			userHtml += '<td>';
 			if (data[i].isForeigner == '1') {
 				userHtml += '외국인';
 			} else {
 				userHtml += '내국인';
 			}
 			userHtml += '</td>';
 			
 			userHtml += '</tr>';
		}
	 	userHtml += '</tbody>';
	 	
	 	userDetailTable.html(userHtml);
	}
	
	// 대표자 그룹 삭제
	function deleteGroup(id) {
		if (confirm("그룹을 삭제하시겠습니까?")) {
			location.href = "deleteGroup.do?groupId=" + id + "&resId=" + resId;
		}
	}
	
	// 수정 저장
	$('#saveBtn').on('click', function() {
		let maxInputVal = $('#max-input').val();
		
		if (confirm("저장하시겠습니까?")) {
			$.ajax({
				url: 'api/updateReserveDetail.do',
				data: { resMax: maxInputVal, resId: resId },
				success: function(response) {
					if (response.success) {
	                    alert(response.message); // 성공 메시지
	                    location.reload(true);
	                } else {
	                    alert(response.message); // 에러 메시지
	                    location.reload(true);
	                }
				},
				error: function(err) {
					console.log("에러: ", err);
				}
			});
		}
	});
	
	// 예약 마감
	$('#finishBtn').on('click', function() {
		location.href = "reserveDraft.do?resId=" + resId;
	});
	
	// 결재
	$('#approve-btn').on('click', function() {		
		if (confirm("결재하시겠습니까?")) {
			location.href = "approveDraft.do?resId=" + resId;	
		}
	});
</script>
</html>