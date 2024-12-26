<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 생성</title>
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
	.reserve-table td select {
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
	}
	
	.back-btn {
	    background-color: #333;
	    color: #fff;
	    float: left;
	}
	
	.back-btn:hover {
	    background-color: #555;
	}
	
	.save-btn {
	    background-color: #ff6600;
	    color: #fff;
	}
	
	.save-btn:hover {
	    background-color: #ff4500;
	}
</style>
<body>
	<form id="reservePostForm" action="reservePost.do" method="POST">
		<h1>예약 생성</h1>
		<h2>예약정보 확인</h2>
		<input type="hidden" value="${title }" id="titleInput" name="resTitle" />
		<input type="hidden" value="${year }-${month }-${date }" id="dateInput" name="resDate" />
		<input type="hidden" value="${date }" name="resDate" />
		<input type="hidden" value="${eventNo }" id="eventNo" name="eventNo" />
		<table class="reserve-table">
            <tr>
                <th>체험명</th>
                <td>${title } ( ${eventTime } )</td>
                <th>날짜</th>
                <td id="resDateShow">${year }-${month }-${date }</td>
            </tr>
            <tr>
                <th>시간</th>
                <td>
                	<!-- <input type="time" id="time-input" name="time" placeholder="시간 입력" /> -->
                	<select id="time-input" name="time">
                		<option>시간 선택</option>
                		<option value="09:00">09 : 00</option>
                		<option value="09:30">09 : 30</option>
                		<option value="10:00">10 : 00</option>
                		<option value="10:30">10 : 30</option>
                		<option value="11:00">11 : 00</option>
                		<option value="11:30">11 : 30</option>
                		<option value="12:00">12 : 00</option>
                		<option value="12:30">12 : 30</option>
                		<option value="13:00">13 : 00</option>
                		<option value="13:30">13 : 30</option>
                		<option value="14:00">14 : 00</option>
                		<option value="14:30">14 : 30</option>
                		<option value="15:00">15 : 00</option>
                		<option value="15:30">15 : 30</option>
                		<option value="16:00">16 : 00</option>
                		<option value="16:30">16 : 30</option>
                		<option value="17:00">17 : 00</option>
                		<option value="17:30">17 : 30</option>
                		<option value="18:00">18 : 00</option>
                	</select>
                </td>
                <th>제한인원수</th>
                <td><input type="number" id="max-input" name="maxPeople" placeholder="제한 인원 입력" /></td>
            </tr>
        </table>
        <div class="button-section">
            <button type="button" class="btn back-btn" onclick="goBackCalendar()">돌아가기</button>
            <button type="button" class="btn save-btn" onclick="submitReserve()">저장</button>
        </div>
	</form>
</body>
<script>
	function goBackCalendar() {
		window.location.href = 'adminCalendar.do';
	}
	
	let urlParams = new URL(location.href).searchParams;
	let isAllDay = urlParams.get("isAll");
	
	if (isAllDay == 1) {
		$('#resDateShow').text('전체');
	}	
	
	function submitReserve() {
		let timeInput = $("#time-input").val();
		let maxInput = $("#max-input").val();
		let reserveForm = $("#reservePostForm");
		let eventNo = $("#eventNo").val();
		
		if (timeInput == '시간 선택') {
			alert("시간을 선택해주세요.");
			return false;
		}
		if (maxInput == '') {
			alert("제한인원수를 입력해주세요.");
			return false;
		}
		
		if (confirm("예약을 등록하시겠습니까?")) {			
			if ($('#resDateShow').text() == '전체') {
				reserveForm.attr("action", "reservePostAll.do");
				reserveForm.submit();
			} else {
				reserveForm.submit();
			}
		}
		
	}
	
	$('#time-input').on('change', function(e) {
		console.log(e.target.value);
	})
</script>
</html>