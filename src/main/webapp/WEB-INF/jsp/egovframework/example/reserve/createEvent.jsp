<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 생성</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form id="createEventForm" name="createEventForm" method="POST">
		<label for="eventTitle">이벤트 제목</label>
		<input type="text" id="eventTitle" name="eventTitle" />
		<label for="eventTime">진행 시간</label>
		<select id="eventTime" name="eventTime">
			<option value="0">30분</option>
			<option value="1">1시간</option>
			<option value="2">1시간 30분</option>
			<option value="3">2시간</option>
			<option value="4">2시간 30분</option>
			<option value="5">3시간</option>
		</select>
		<button type="button" onclick="submitCreateEvent()">생성</button>
	</form>
</body>
<script>

	$('#eventTime').on('change', function(e) {
		console.log(e.target.value);
	});

	function submitCreateEvent() {
		let eventTitle = $('#eventTitle');
		let eventTime = $('#eventTime');
		let createEventForm = $('#createEventForm');
		
		if (eventTitle.val() == "") {
			alert("이벤트 제목을 입력해주세요.");
			eventTitle.focus();
			return;
		}
		
		if (confirm("이벤트를 등록하시겠습니까?")) {
			createEventForm.attr("action", "createEvent.do");
			createEventForm.submit();
		}
	}
</script>
</html>