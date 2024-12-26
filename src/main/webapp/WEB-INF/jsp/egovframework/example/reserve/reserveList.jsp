<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 확인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
	#reserveListContainer {
		width: 90%;
		margin: 120px auto;
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
	
	.detail-btn {
		background-color: dodgerblue;
		color: white;
	}
	.cancel-btn {
		background-color: orange;
		color: white;
	}
	
	.button-section {
	    margin-top: 20px;
	    text-align: right;
	}
	.back-btn {
	    background-color: #333;
	    color: #fff;
	    float: left;
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
	
	.user-detail-table {
	    width: 100%;
	    border-collapse: collapse;
	    border-top: 2px solid black;
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
	<div id="reserveListContainer">
		<h1>예약 정보 확인</h1>
		<div class="user-table-container">
			<table class="user-table">
				<thead>
					<tr>
						<th>No</th>
						<th>체험명</th>
						<th>예약시간</th>
						<th>예약자수</th>
						<th>확인</th>
						<th>취소</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="info" items="${reservedInfos }" varStatus="status">
					<tr>
						<td>${status.count }</td>
						<td>${info.resTitle }</td>
						<td>${info.resDate } (${info.resTime })</td>
						<td>${info.resCount }</td>
						<td><button class="btn detail-btn" onclick="checkGuestsInfo(${info.groupId})">예약정보</button></td>
						<td><button type="button" class="btn cancel-btn" onclick="cancelReservation(${info.resId}, ${info.groupId })">예약취소</button></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="button-section">
	            <button type="button" class="btn back-btn" onclick="location.href='userCalendar.do'">돌아가기</button>
	        </div>
		</div>
	</div>
	<!-- 예약자 확인(팝업창) -->
	<div id="overlay"></div>
	<div id="show-reserved-users" class="hidden">
		<h1>예약 확인</h1>
		<h2>예약 정보</h2>
		<div class="detail-table-container">
	        <table class="user-detail-table"></table>
	    </div>
	    
	    <button type="button" class="btn confirm-btn" id="confirmBtn">확인</button>
	</div>
</body>
<script>
	function cancelReservation(resId, groupId) {
		if (confirm("예약을 취소하시겠습니까?")) {
			location.href = "cancelReservation.do?resId=" + resId + "&groupId=" + groupId;
		}
	}
	
	// 팝업창 띄워서 예약 정보 확인
	function checkGuestsInfo(id) { 
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
	    	userDetailTable.html("");
	    });

	    // 팝업창 이외에 클릭 시 닫기
	    overlay.on('click', function() {
	    	popup.addClass("hidden");
	    	popup.css("display", "none");
	    	overlay.addClass("hidden");
	    	overlay.css("display", "none");
	    	userDetailTable.html("");
	    });
	    
	 	// 일행 테이블 출력
	 	let userDetailTable = $('.user-detail-table');
	 	let groupId = $('#representGroup_' + id).val();
	 	
	 	$.ajax({
	 		url: 'api/getUserInfos.do',
	 		type: 'GET',
	 		data: { groupId: id },
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
</script>
</html>