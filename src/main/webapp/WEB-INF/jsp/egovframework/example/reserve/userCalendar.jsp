<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약일정관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
	.user-name-area {
	    font-size: 14pt;
	    font-weight: bold;
	    margin: 0;
	    margin-right: 20px;
	}
	.user-info-area {
		display: flex;
		justify-content: end;
	    align-items: center;
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
	.logout-btn {
		background-color: darkgray;
		color: white;
		margin-left: 30px;
	}
	.check-reserves-btn {
		margin-left: 30px;
	}
	
	#calendar-container {
		margin: 120px auto;
		position: relative;
	}
	.calendar {
	    width: 90%;
	    margin: 20px auto;
	    border: 1px solid #ccc;
	}
	
	.calendar-header {
	    display: flex;
	    justify-content: end;
	    align-items: center;
	    padding: 10px 0;
	    margin-right: 20px;
	}
	
	.calendar-grid {
	    display: grid;
	    grid-template-columns: repeat(7, 1fr);
	    gap: 1px;
	    background-color: #ccc;
	}
	
	.calendar-day {
		background-color: #fff;
	    padding: 10px;
	    min-width: 200px;
	    min-height: 180px;
	    display: flex;
	    flex-direction: column;
	    justify-content: space-between;
	    border: 1px solid #ccc;
	    position: relative;
	}
	.calendar-grid div:nth-child(7n+1) {
	    color: red;
	    cursor: no-drop;
	}
	.calendar-grid div:nth-child(7n) {
	    color: blue;
	}
	
	.event {
	    margin-top: 5px;
	    background-color: #f0f0f0;
	    padding: 5px;
	    border-radius: 4px;
	    font-size: 12px;
	}
	
	.add-event {
	    background-color: #ddd;
	    border: none;
	    font-weight: bold;
	    padding: 5px;
	    text-align: center;
	    cursor: pointer;
	}
	
	.add-event:hover {
	    opacity: 0.6;
	}
	
	.calendar-week {
		list-style: none;
	    display: grid;
	    grid-template-columns: repeat(7, 1fr);
	    gap: 1px;
	    text-align: center;
    	border-top: 2px solid #ccc;
	    padding: 10px 0;
	    margin: 0;
	}
	.calendar-week-item {
		/* width: 200px; */
	}
	
	.calendar-title {
		width: 90%;
    	margin: 0 auto;
	}
	.calendar-menu {
		list-style: none;
		display: flex;
		padding: 0;
		margin-bottom: -50px;
	}
	.calendar-menu-item {
		border: none;
	    margin: 0 20px 0 0;
	    background-color: #fff;
	    cursor: pointer;
	    font-size: 15pt;
	    padding: 12px;
	    border-radius: 5px;
	    font-weight: bold;
	}
	.calendar-menu-item:hover {
		background-color: deeppink;
		color: white;
	}
	.active {
		background-color: deeppink;
		color: white;
	}
	
	#add-all-btn {
		margin-left: 20px;
		padding: 12px 30px;
	    border: none;
	    background-color: #000;
	    color: white;
	    font-weight: bold;
	    border-radius: 5px;
	    cursor: pointer;
	}
	#add-all-btn:hover {
		opacity: 0.6;
	}
	.calendar-date-setting {
		width: 90%;
		margin: 0 auto;
		display: flex;
		justify-content: end;
		
	}
	.calendar-date-setting button {
		padding: 10px 15px;
	    border: 1px solid #ccc;
	    background-color: #f5f5f5;
	    cursor: pointer;
	}
	.calendar-date-setting button:hover {
	    background-color: #ddd;
	}
	.calendar-date-setting select {
	    padding: 10px;
    	border: 1px solid #ddd;
    	margin-right: 20px;
	}
	#this-month {
	    margin-left: 20px;
	    border: none;
	    background-color: #000;
	    color: white;
	    font-weight: bold;
	    border-radius: 5px;
	    cursor: pointer;
	}
	#this-month:hover {
		opacity: 0.6;
	}
	
	.reserved-list {
		list-style: none;
	    padding: 0;
	    position: absolute;
	    top: 30px;
	    margin: 5px auto;
	    overflow-y: scroll;
	    min-width: 90%;
	    max-height: 120px;
	}
	.reserved-item {
		margin: 5px 0 5px 0;
	    display: flex;
	    align-items: center;
	}
	.reserved-time {
		margin-right: 10px;
	    border: 2px solid orange;
	    padding: 0 5px;
	    color: orange;
	    font-weight: bold;
	    border-radius: 5px;
	}
	.reserved-status {
		text-decoration: none;
		color: black;
	}
	.reserved-status:hover {
		text-decoration: underline;
		color: black;
	}
	.admin-btn {
		background-color: #000;
    	color: white;
	}
</style>
<body>
	<div id="calendar-container">
		<div class="calendar-title">
			<h1>예약하기</h1>
			<h2>프로그램 선택</h2>
			<div class="user-info-area">
				<p class="user-name-area">${loginUser.userName } 님</p>
				<c:if test="${loginUser.userType eq 1 }">
					<button class="btn admin-btn" onclick="adminCalendar()">관리자페이지</button>
				</c:if>
				<button class="btn check-reserves-btn" onclick="reserveList()">예약 확인</button>
				<button class="btn logout-btn" onclick="logoutBtn()">로그아웃</button>
			</div>
			
			<ul class="calendar-menu">
				<li><button type="button" class="calendar-menu-item" id="calendar-menu_1">어린이 안전 동화마을</button></li>
				<!-- <li><button type="button" class="calendar-menu-item" id="calendar-menu_2">1존 생활안전</button></li>
				<li><button type="button" class="calendar-menu-item" id="calendar-menu_3">2존 교통안전</button></li>
				<li><button type="button" class="calendar-menu-item" id="calendar-menu_4">기본 심폐소생술(CPR&AED)</button></li>
				<li><button type="button" class="calendar-menu-item" id="calendar-menu_5">3존 재난안전</button></li> -->
			</ul>
		</div>
		<div class="calendar-date-setting">
			<select id="year-select"></select>
			<select id="month-select"></select>
			<button type="button" id="prev-month">&lt;</button>
			<button type="button" id="next-month">&gt;</button>
			<button type="button" id="this-month">이번 달</button>
		</div>
		<div class="calendar">
			<ul class="calendar-week">
				<li class="calendar-week-item">일요일</li>
				<li class="calendar-week-item">월요일</li>
				<li class="calendar-week-item">화요일</li>
				<li class="calendar-week-item">수요일</li>
				<li class="calendar-week-item">목요일</li>
				<li class="calendar-week-item">금요일</li>
				<li class="calendar-week-item">토요일</li>
			</ul>
			<div class="calendar-grid" id="calendar-grid"></div>
		</div>
	</div>
	<!-- 예약 꽉 찼을 경우 alert메세지 -->
	<c:if test="${maxMessage ne null}">
		<script>
			alert("${maxMessage}");
		</script>
	</c:if>
</body>
<script>
	let yearSelect = $('#year-select'); // 연도 선택
	let monthSelect = $('#month-select'); // 월 선택
	let prevMonthButton = $('#prev-month'); // 이전 달 ( < ) 버튼 
	let nextMonthButton = $('#next-month'); // 다음 달 ( > ) 버튼
	let currMonthButton = $('#this-month'); // [이번 달] 버튼
	
	const currentDate = new Date();
	let currentYear = currentDate.getFullYear(); // 올해 연도 값
	let currentMonth = currentDate.getMonth(); // 이번 달 값
	
	// 각 날짜에 예약 리스트 출력 및 캘린더 설정
	function loadReservations(currentYear, currentMonth) {
		$.ajax({
			url: 'api/getReservations.do',
			type: 'GET',
			data: { year: currentYear, month: currentMonth },
			dataType: 'json',
			success: function(res) {
				// console.log("예약정보: ", res);
				generateCalendar(currentYear, currentMonth, res);
			},
			error: function(error) {
				console.error("에러: ", error);
			}
		});
	}
	
	// 캘린더 생성
	function generateCalendar(currentYear, currentMonth, reservations) {
	    // 캘린더 그리드 초기화
	    let calendarGrid = $('#calendar-grid');
	    calendarGrid.html("");

	    let firstDay = new Date(currentYear, currentMonth, 1).getDay(); // 이번 달의 첫째 날
	    let lastDay = new Date(currentYear, currentMonth + 1, 0).getDate(); // 이번 달의 마지막 날(다음 달 첫째 날의 0일)

	    // grid item이 첫째 날보다 적으면 <div> 태그로 비워두기
	    for (let i = 0; i < firstDay; i++) {
	    	let emptyCell = $('<div></div>');
	    	calendarGrid.append(emptyCell);
	    }

	    // grid item이 lastDate(마지막 날)까지 날짜(일수) 입력 및 '신규등록' 버튼 추가
	    for (let date = 1; date <= lastDay; date++) {
	    	let dayCell = $('<div></div>');
	        dayCell.addClass("calendar-day");
	        dayCell.html("<strong>" + date + "</strong>");

	        // 해당 날짜의 예약 필터링
	        // reservations 배열에서 특정 조건에 맞는 예약(reserve)만 추출하기 위해 filter 메서드를 사용
			let filteredReservations = reservations.filter(function (reserve) {
			    // filter 메서드는 배열의 각 요소를 순회하며 조건을 검사하고, 조건을 만족하는 요소들로 구성된 새로운 배열을 반환.
			
			    // 예약 객체에서 resDate 필드를 가져와 Date 객체로 변환
			    let resDate = new Date(reserve.resDate);
			
			    // 조건: 현재 연도, 월, 그리고 날짜와 일치하는 예약만 반환
			    return (
			        resDate.getFullYear() === currentYear && // 예약의 연도가 현재 연도와 같은지 확인
			        resDate.getMonth() === currentMonth &&  // 예약의 월이 현재 월과 같은지 확인 (0부터 시작하므로 주의)
			        resDate.getDate() === date              // 예약의 날짜가 주어진 날짜와 같은지 확인
			    );
			});
	        
			// filteredReservations: 조건을 만족하는 예약(reserve) 객체들로 구성된 새로운 배열


	        // 예약이 있을 경우에만 리스트 생성
	        if (filteredReservations.length > 0) {
	        	let reservationList = $("<ul></ul>"); // 예약 리스트를 담을 <ul> 요소 생성
	        	reservationList.addClass("reserved-list"); // 클래스 설정

	            filteredReservations.forEach(function (reserve) {
	            	let reservationItem = $("<li></li>"); // 리스트 태그
	            	let reservationTime = $("<span></span>"); // 시간 태그
	            	let reservationStatus = $("<a></a>"); // 예약상황 태그
	                
	                reservationItem.addClass("reserved-item");
	                reservationTime.text(reserve.resTime); // 예약 시간 출력
	                reservationTime.addClass("reserved-time");
	                
	                $.ajax({
	        			url: 'api/getReservedCount.do',
	        			type: 'GET',
	        			data: { resId: reserve.resId },
	        			dataType: 'json',
	        			success: function(count) {
	        				reservationStatus.text("예약상황(" + count + "/" + reserve.resMax + ")"); // 예약상황(현재인원/최대인원) 출력
	        				if (count >= reserve.resMax) {
	        					reservationStatus.css("color", "red");
	        				}
	        			},
	        			error: function(error) {
	        				console.error("에러: ", error);
	        			}
	        		});

	                reservationStatus.addClass("reserved-status");
	                reservationStatus.attr("href", "requestReserve.do?resId=" + reserve.resId);
	                
	                // 예약 ID 설정
	                let reservationId = "<input type='hidden' name='resId' value='" + reserve.resId + "' />"; 
	                
	                reservationItem.append(reservationTime);
	                reservationItem.append(reservationStatus);
	                reservationItem.append(reservationId);
	                
	                reservationList.append(reservationItem);
	            });

	            dayCell.append(reservationList); // 날짜 셀에 이벤트 리스트 추가
	        }

	        calendarGrid.append(dayCell); // 캘린더에 셀 추가
	    }

	    // 일요일에는 휴관일이므로 클릭 제한
	    for (let i = 0; i < calendarGrid.children().length; i++) {
	        if (i % 7 === 0) {
	            $(calendarGrid.children()[i]).css("backgroundImage", "none");
	            $(calendarGrid.children()[i]).removeAttr("onclick");
	        }
	    }
	}
	
	// 날짜 선택 함수
	function selectDates() {
		// 올해부터 2030년까지
	    for (let year = currentYear; year <= 2030; year++) {
	    	let option = $('<option></option>'); // 셀렉트 박스에 옵션 생성
	    	option.val(year);
	    	option.text(year + '년');
	        yearSelect.append(option);
	    }
		// 1월부터 12월까지. month는 index 기준이므로 텍스트는 1을 더해서 출력
	    for (let month = 0; month < 12; month++) {
	    	let option = $('<option></option>'); // 셀렉트 박스에 옵션 생성
	    	option.val(month);
	    	option.text(month + 1 + '월');
	        monthSelect.append(option);
	    }
	}
	
	// 날짜 값 변경 함수
	function updateSelectors() {
	    yearSelect.val(currentYear);
	    monthSelect.val(currentMonth);
	}
	
	// yearSelect.val()과 monthSelect.val()은 문자열로 반환됨. parseInt를 사용하여 정수로 변환 후 loadReservations 함수에 파라미터 값으로 설정
	// 연도 변경
	yearSelect.on('change', function() {
		currentYear = parseInt(yearSelect.val());
	    loadReservations(currentYear, currentMonth);
	});
	// 월 변경
	monthSelect.on('change', function() {
	    currentMonth = parseInt(monthSelect.val());
	    loadReservations(currentYear, currentMonth);
	});
	
	// 꺽쇠( < ) 버튼 이벤트리스너
	prevMonthButton.on('click', function() {
		currentMonth--; // 이번 달 값 감소
	    
	    // 이번 달이 0보다 작으면(1월 미만이면) 12월로 변경. 그리고 연도 값 감소  
	    if (currentMonth < 0) {
	        currentMonth = 11;
	        currentYear--;
	    }
	    updateSelectors(); // 날짜 값 변경
	    loadReservations(currentYear, currentMonth);
	});
	
	// 꺽쇠( > ) 버튼 이벤트리스너
	nextMonthButton.on('click', function() {
		currentMonth++; // 이번 달 값 증가
	    
	 	// 이번 달이 11보다 크면(12월 넘어가면) 1월로 변경. 그리고 연도 값 증가  
	    if (currentMonth > 11) {
	        currentMonth = 0;
	        currentYear++;
	    }
	    updateSelectors(); // 날짜 값 변경
	    loadReservations(currentYear, currentMonth);
	});
	
	// [이번 달] 버튼 클릭(이번 달 캘린더로 돌아오기)
	currMonthButton.on('click', function() {
		let currentYear = currentDate.getFullYear(); // 현재 연도 재선언
		let currentMonth = currentDate.getMonth(); // 현재 달 재선언
	    loadReservations(currentYear, currentMonth); // 캘린더 재생성
	    yearSelect.val(currentYear); // 연도 옵션 값 설정
	    monthSelect.val(currentMonth); // 달 옵션 값 설정
	});
	
	// 예약 프로그램 선택
	let calendarMenuItem = $('.calendar-menu-item');
	/* $('.calendar-menu-item').on('click', (e) => {
		$('.calendar-menu-item').removeClass('active'); // 전체 메뉴에서 active 클래스명 삭제
		e.target.classList.add('active'); // 선택된 클래스에 active 추가
		loadReservations(currentYear, currentMonth); // 캘린더 재생성
	}); */
	
	/* 페이지 로딩 후 함수들 실행 */
	$(document).ready(function() {
		selectDates(); // 셀렉트 박스 옵션 값 설정
		updateSelectors(); // 옵션 값에 따라 날짜 설정
		loadReservations(currentYear, currentMonth); // 캘린더 생성
		calendarMenuItem[0].classList.add('active'); // 첫 번째 예약 프로그램을 기본으로 설정
	});	
	
	// 로그아웃
	function logoutBtn() {
		if (confirm("로그아웃 하시겠습니까?")) {
			location.href = "logout.do";
		}
	}
	
	// 예약 확인 페이지 이동
	function reserveList() {
		location.href = "reserveList.do";
	}
	
	// 관리자페이지
	function adminCalendar() {
		location.href = "adminCalendar.do";
	}
</script>
</html>