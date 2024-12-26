<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>
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
	    border-top: 2px solid black;
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
		background-color: #fff;
		color: #000;
		border: 1px solid #ddd;
	}
	
	.user-table-container {
		margin: 30px 0;
		/* display: none; */
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
	
	.reserve-type {
		width: 30%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	.add-btn-area {
		text-align: center;
		margin-top: 30px;
		display: none;
	}
	
	.user-add-table {
	    width: 100%;
	    border-collapse: collapse;
	    border-top: 2px solid #000;
	}	
	.user-add-table th {
	    background-color: #f4f4f4;
	    border-bottom: 1px solid #ddd;
	    height: 50px;
	    color: #555;
	}
	.user-add-table td {
		border-bottom: 1px solid #ddd;
		height: 60px;
		text-align: center;
	}
	.user-add-table td input {
	    width: 50%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	.user-add-table td input[type="checkbox"] {
		width: 12%;
	}
	.user-add-table td input[type="radio"] {
		width: 12%;
	}
	.user-add-table td select {
		width: 80%;
		padding: 8px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	
	.excel-btn-area {
		display: flex;
	    justify-content: center;
	    margin-top: 30px;
	    gap: 12px;
	}
	.excel-btn {
		background-color: white;
		border: 2px solid dodgerblue;
		border-radius: 4px;
	}
	.icon {
		width: 12px;
		margin-left: 10px;
	}
	.detail-btn {
		padding: 5px 15px;
		margin-left: 20px;
	}
</style>
<body>
	<form id="reservePostForm" action="reservePost.do" method="POST" enctype="multipart/form-data">
		<h1>예약자 정보 입력</h1>
		<input type="hidden" id="resId" value="${resInfo.resId }" />
		<input type="hidden" id="userId" value="${loginUser.userId }" />
		<input type="hidden" id="isFinished" value="${resInfo.isRequested }" />
		<table class="reserve-table">
            <tr>
                <th>체험명</th>
                <td>${resInfo.resTitle }</td>
                <th>날짜</th>
                <td style="color: red;">${resInfo.resDate } ${resInfo.resTime }</td>
            </tr>
            <tr>
                <th>대표 예약자</th>
                <td><input id="userName" type="text" value="${loginUser.userName }" disabled autocomplete="off" /></td>
                <th>전화번호</th>
                <td><input id="userPhone" type="text" value="${loginUser.userPhone }" disabled autocomplete="off" /></td>
            </tr>
            <tr>
            	<th>예약구분</th>
            	<td>
            		<select id="reserve-type" class="reserve-type">
            			<option id="type-personal">개인</option>
            			<option id="type-group">단체</option>
            		</select>
            		<span></span>
            	</td>
            	<th>예약 인원수</th>
            	<td><span id="reservedCount" style="color: red;"></span><span id="reservedMaxCount" style="margin-right: 20px;"> / ${resInfo.resMax }</span></td>
            </tr>
        </table>
        <input type="hidden" id="resMaxVal" value="${resInfo.resMax }" />
        <div class="user-table-container">
        	<h1>체험 인원 정보</h1>
	        <table class="user-add-table">
	        	<thead>
		        	<tr>
		        		<th>번호</th>
		        		<th>성명</th>
		        		<th>성별</th>
		        		<th>시 / 도</th>
		        		<th>상세주소(구/군)</th>
		        		<th>장애여부</th>
		        		<th>외국인</th>
		        		<th>삭제</th>
		        	</tr>
	        	</thead>
	        	<!-- tbody 새롭게 추가는 JS -->
	        </table>
	        <div class="add-btn-area">
	        	<button type="button" class="btn add-user-btn" onclick="addUser()">인원 추가하기 + </button>
	        </div>
        </div>
        <div class="excel-btn-area">
        	<button type="button" id="excelDownloadBtn" class="btn excel-btn" onclick="downloadExcel()">엑셀양식 다운로드<img class="icon" src="/reserve_proj/images/egovframework/reserve/download_icon.png" /></button>
        	<label for="file" id="excelUploadBtn" class="btn excel-btn">엑셀 업로드<img class="icon" src="/reserve_proj/images/egovframework/reserve/upload_icon.svg" /></label>
        	<input type="file" name="file" id="file" style="display: none;" onchange="uploadExcel()" />
        </div>
        <div class="button-section">
            <button type="button" class="btn back-btn" onclick="goBackCalendar()">돌아가기</button>
            <button type="button" id="saveBtn" class="btn save-btn" onclick="saveSchedule()">저장</button>
        </div>
	</form>
	
	<!-- 예약 꽉 찼을 때 -->
	<c:if test="${maxReserve ne null and isReserved eq null }">
		<script>
			$('#saveBtn').attr("disabled", true);
			$('#saveBtn').css("cursor", "not-allowed");
			$('#saveBtn').css("opacity", "0.6");
			$('#excelUploadBtn').remove();
			$('#reserve-type').attr("disabled", true);
			$('#reservedMaxCount').append('<span class="full-message">&nbsp; 예약이 꽉 찼습니다.</span>');
			$('.full-message').css("color", "red");
		</script>
	</c:if>
	
	<!-- 이미 예약했을 때 -->
	<c:if test="${isReserved ne null }">
		<script>
			$('#saveBtn').attr("disabled", true);
			$('#saveBtn').css("cursor", "not-allowed");
			$('#saveBtn').css("opacity", "0.6");
			$('#excelUploadBtn').remove();
			$('#reserve-type').attr("disabled", true);
			$('#reservedMaxCount').append('<span class="full-message">&nbsp; 이미 예약을 하셨습니다.</span><button class="btn detail-btn" onclick="reserveList()" type="button">상세정보</button>');
			$('.full-message').css("color", "red");
		</script>
	</c:if>
	
</body>
<script>
	<!-- 예약이 마감 중이거나 마감 되었을 때 -->
	if ($('#isFinished').val() == 1) {
		$('#saveBtn').attr("disabled", true);
		$('#saveBtn').css("cursor", "not-allowed");
		$('#saveBtn').css("opacity", "0.6");
		$('#excelUploadBtn').remove();
		$('#reserve-type').attr("disabled", true);
		$('#reservedMaxCount').append('<span class="full-message">&nbsp; 예약이 마감되었습니다.</span>');
		$('.full-message').css("color", "red");
	}

	// 지역 데이터
	var area0 = ["시 / 도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	var area3 = ["대덕구","동구","서구","유성구","중구"];
	var area4 = ["광산구","남구","동구", "북구","서구"];
	var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	var area6 = ["남구","동구","북구","중구","울주군"];
	var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	var area16 = ["서귀포시","제주시","남제주군","북제주군"];
	
	// 예약자 번호 매기기 위한 인덱스
	let indexNo = 1;
	
	// 인원 입력란 생성
	addUser();
	if (indexNo < 3) {
		setFirstItemDisabled();
	} 

	// 돌아가기 버튼
	function goBackCalendar() {
		window.location.href = 'userCalendar.do';
	}
	
	$('#reservePostForm').on("submit", function(e) {
		e.preventDefault();
		alert("잘못된 접근입니다.");
	});
	
	// 팝업창 띄워서 예약 정보 확인
	function checkUsersInfo(id) { 
	    const confirmBtn = document.getElementById('confirmBtn'); 
	    const popup = document.getElementById('show-reserved-users');
	    const overlay = document.getElementById('overlay');

	    // 팝업창 열기
	    popup.classList.remove('hidden');
        overlay.classList.remove('hidden');
        popup.style.display = 'block';
        overlay.style.display = 'block';

	    // 팝업창 닫기
	    confirmBtn.addEventListener('click', () => {
	        popup.classList.add('hidden');
	        overlay.classList.add('hidden');
	        popup.style.display = 'none';
	        overlay.style.display = 'none';
	        representDetailTable.innerHTML = '';
	    });

	    // 팝업창 이외에 클릭 시 닫기
	    overlay.addEventListener('click', () => {
	        popup.classList.add('hidden');
	        overlay.classList.add('hidden');
	        popup.style.display = 'none';
	        overlay.style.display = 'none';
	        representDetailTable.innerHTML = '';
	    });
	    
	 	// 대표자 테이블 출력
	    const representDetailTable = document.querySelector('.represent-detail-table');

	    let repHtml = '';
	    repHtml += '<tr><th>대표자명</th><td>' + $('#representName_' + id).val() + '</td></tr>';
	    repHtml += '<tr><th>대표 연락처</th><td>' + $('#representPhone_' + id).val() + '</td></tr>';
	    repHtml += '<tr><th>날짜</th><td>' + $('#representDate_' + id).val() + '</td></tr>';
	    repHtml += '<tr><th>프로그램명</th><td>' + $('#representTitle_' + id).val() + '</td></tr>';

	    // innerHTML을 사용하여 태그를 파싱
	    representDetailTable.innerHTML += repHtml;
	}
	
	// 예약 구분 단체 선택 시 인원 추가 버튼 생성
	$('#reserve-type').on('change', (e) => {		
		if (e.target.value == '단체') { // 단체일 때
			$('.add-btn-area').css('display', 'block'); // 버튼 출력
			$('.user-add-tbody').remove(); // 인원 정보 입력란 삭제
			$('#file')[0].value = ''; // input file 초기화
			indexNo = 1; // index 초기화
			addUser(); // 인원 정보 입력란 생성
			
			$('.user-add-tbody tr .btn')[0].setAttribute("onclick", "this.disabled=true");
			$('.user-add-tbody tr .btn')[0].style.cursor = "not-allowed";
			$('.user-add-tbody tr .btn')[0].setAttribute("disabled", true);
			$('.user-add-tbody tr .btn')[0].style.opacity = "0.6";
		} else { // 개인일 때
			$('.add-btn-area').css('display', 'none'); // 버튼 숨김
			$('.user-add-tbody').remove(); // 인원 정보 입력란 삭제
			$('#file')[0].value = ''; // input file 초기화 
			indexNo = 1; // index 초기화
			addUser(); // 인원 정보 입력란 생성
			
			$('.user-add-tbody tr .btn')[0].setAttribute("onclick", "this.disabled=true");
			$('.user-add-tbody tr .btn')[0].style.cursor = "not-allowed";
			$('.user-add-tbody tr .btn')[0].setAttribute("disabled", true);
			$('.user-add-tbody tr .btn')[0].style.opacity = "0.6";
		}
	});
	
	// 인원 추가 버튼
	function addUser() {
		let addRow = '<tbody class="user-add-tbody"><tr id="userRow_' + indexNo + '">';
		addRow += '<td class="row-index" id="rowIndex_' + indexNo + '">' + indexNo + '</td>';
		addRow += '<td><input id="addUserName_' + indexNo + '" class="guestName" type="text" placeholder="성함" /></td>';	
		addRow += '<td><filedset><input type="radio" value="0" name="genderType_' + indexNo + '" onclick="getGenderType(event, ' + indexNo + ')" />남자<input type="radio" value="1" name="genderType_' + indexNo + '" onclick="getGenderType(event, ' + indexNo + ')" />여자</fieldset</td>';	
		addRow += '<td><select class="selectSido" id="select-sido_' + indexNo + '"></select></td>';
		addRow += '<td><select class="selectGugun" id="select-gugun_' + indexNo + '"></select></td>';
		addRow += '<td><input type="checkbox" class="isDisabled" id="isDisabled_' + indexNo + '" /><span>장애여부</span></td>';
		addRow += '<td><input type="checkbox" class="isForeigner" id="isForeigner_' + indexNo + '"/><span>외국인</span></td>';
		addRow += '<td><button type="button" class="btn" onclick="deleteUser(' + indexNo + ')">삭제</button></td>';
		
		addRow += '</tr>';
		
		// hidden 필드로 성별값 저장
		let genderCheckInput = '<input type="hidden" id="genderCheck_' + indexNo + '" />';
		addRow += genderCheckInput;
		addRow += '</tbody>';
		
		$('.user-add-table').append(addRow);
		
		// $('.user-table-container').append(genderCheckInput);
		
		// 주소 셀렉트 박스 생성
		showAddress(indexNo);
		
		indexNo++;
		
		if (indexNo > 2) {
			setFirstItemAbled();
		}
	}
	
	function setFirstItemDisabled() {
		$('.user-add-tbody tr .btn')[0].setAttribute("onclick", "this.disabled=true");
		$('.user-add-tbody tr .btn')[0].style.cursor = "not-allowed";
		$('.user-add-tbody tr .btn')[0].setAttribute("disabled", true);
		$('.user-add-tbody tr .btn')[0].style.opacity = "0.6";
	}
	
	function setFirstItemAbled() {
		$('.user-add-tbody tr .btn')[0].setAttribute("onclick", "deleteUser(" + 1 + ")");
		$('.user-add-tbody tr .btn')[0].style.cursor = "pointer";
		$('.user-add-tbody tr .btn')[0].removeAttribute("disabled");
		$('.user-add-tbody tr .btn')[0].style.opacity = "";
	}
	
	// 성별 체크값
	function getGenderType(event, index) {
		$("#genderCheck_" + index).val(event.target.value);
	}
	
	// 인원 삭제
	function deleteUser(index) {
		$('#userRow_' + index).parent().remove();
		
		for (let i = 0; i < $('.row-index').length; i++) {
		    $('.user-add-tbody tr .row-index')[i].innerText = i + 1;
		    $('.user-add-tbody tr')[i].id = 'userRow_' + (i + 1);
		    $('.user-add-tbody tr .row-index')[i].id = 'rowIndex_' + (i + 1);
		    $('.user-add-tbody tr .guestName')[i].id = 'addUserName_' + (i + 1);
		    $('.user-add-tbody tr .selectSido')[i].id = 'select-sido_' + (i + 1);
		    $('.user-add-tbody tr .selectGugun')[i].id = 'select-gugun_' + (i + 1);
		    $('.user-add-tbody tr .isDisabled')[i].id = 'isDisabled_' + (i + 1);
		    $('.user-add-tbody tr .isForeigner')[i].id = 'isForeigner_' + (i + 1);
		    $('.user-add-tbody tr .isForeigner')[i].id = 'isForeigner_' + (i + 1);
		    $('.user-add-tbody tr .btn')[i].setAttribute("onclick", "deleteUser(" + (i + 1) + ")");
		}
	    indexNo--;
	    
	    if (indexNo < 3) {
	    	setFirstItemDisabled();
	    }
	}
	
	// 예약 저장
	function saveSchedule() {
	    const userId = $('#userId').val();
	    const resId = $('#resId').val();
	    const userName = $('#userName').val();
	
	    const reserveType = $('#reserve-type').val();
	    const reserveTable = $('.user-add-tbody').length;
	    
	    let resCurrVal = $('#resCurrentVal').val(); // 예약되어 있는 수
	    let resCountVal = $('#resMaxVal').val(); // 최대 예약 수
	    let guestLength = document.querySelectorAll('.user-add-tbody').length; // 예약할 인원 수
	    
	    // "최대예약 수 - 예약되어 있는 수 < 예약할 인원 수" 가 되면 불가능
	    let resPossible = resCountVal - resCurrVal;
	    
	    if (resPossible < guestLength) {
	    	alert("예약할 수 있는 최대 인원수를 넘어섰습니다.");
	    	return;
	    }
	    	
	    if (reserveType === '단체' && reserveTable < 1) {
	        alert("최소 한 명의 체험 일행을 추가해주세요.");
	        return false;
	    }
	    
	    for (let i = 0; i < $('.guestName').length; i++) {
	    	if ($('.guestName')[i].value == '') {
	    		alert("일행의 성함을 입력해주세요.");
	    		$('.guestName')[i].focus();
	    		return;
	    	}
	    }
	    
	    /* if (reserveType === '단체' && $('#addUserName_' + indexNo).val() == '') {
	    	alert("성함을 입력해주세요.");
	    	return false;
	    } */
	
	    // 예약자 데이터
	    let guestList = [];
	    if (reserveTable > 0) {
	        for (let i = 1; i <= reserveTable; i++) {
	            let guestName = $('#addUserName_' + i).val();
	            let guestGender = $('#genderCheck_' + i).val();
	            let isDisabled = $('input:checkbox[id="isDisabled_'+ i + '"]').is(":checked") ? 1 : 0;
	            let isForeigner = $('input:checkbox[id="isForeigner_'+ i + '"]').is(":checked") ? 1 : 0;
	            let guestSido = $('#select-sido_' + i).val();
	            let guestGugun = $('#select-gugun_' + i).val();
	            
	            guestList.push({
	                guestName: guestName,
	                guestGender: guestGender,
	                isDisabled: isDisabled,
	                isForeigner: isForeigner,
	                guestSido: guestSido,
	                guestGugun: guestGugun
	            });
	            if ($('#genderCheck_' + i).val() == '') {
		    		alert("일행의 성별을 선택해주세요.");
		    		return;
		    	}
		    	if ($('#select-sido_' + i).val() == '시 / 도 선택') {
		    		alert("일행의 주소를 선택해주세요.");
		    		return;
		    	}
		    	if ($('#select-gugun_' + i).val() == '구 / 군 선택') {
		    		alert("일행의 상세주소를 선택해주세요.");
		    		return;
		    	}
	        }
	    }
	
	    // ajax로 보낼 데이터
	    let requestData = {
	        repUserInfo: {
	            userId: userId,
	            resId: resId,
	            userName: userName
	        },
	        guestInfo: guestList
	    };
	    
	    if (confirm("저장하시겠습니까")) {
	        $.ajax({
	            url: 'saveSchedule.do',
	            type: 'POST',
	            data: JSON.stringify(requestData),
	            contentType: 'application/json; charset=utf-8',
	            success: function(response) {
	                if (response.success) {
	                    alert(response.message); // 성공 메시지
	                    location.href = "userCalendar.do";
	                } else {
	                    alert(response.message); // 에러 메시지
	                    location.reload(true);
	                }
	            },
	            error: function(error) {
	                console.error("에러: ", error);
	                alert("서버와의 통신에 실패했습니다. 잠시 후 다시 시도해주세요.");
	            }
	        });
	    }
	}

	// 현재 예약 인원 수와 최대인원 출력
	const reservedCount = $('#reservedCount');
	const resId = $('#resId').val();
	$.ajax({
		url: 'api/getReservedCount.do',
		type: 'GET',
		data: { resId: resId },
		dataType: 'json',
		success: function(count) {
			reservedCount.append(count);
			$('.reserve-table').append("<input type='hidden' id='resCurrentVal' value='" + count + "' />");
		},
		error: function(error) {
			console.error("에러: ", error);
		}
	});
	
	// 지역 출력 셀렉트 박스 생성
	function showAddress(indexNo) {
		
		// 시/도 셀렉트 박스에 데이터 삽입
		$("#select-sido_" + indexNo).each(function() {
			let sido = $(this);
			let gugun = $("#select-gugun_" + indexNo);
			
			// jQuery로 배열을 관리하기 위해 $.each() 메서드 사용
			$.each(eval(area0), function() {
				sido.append("<option value='" + this + "'>" + this + "</option>");
			});
			gugun.append("<option value=''>구 / 군 선택</option>");
		});
		
		// 시/도가 선택되면 구/군 셀렉트 박스에 데이터 삽입
		$("#select-sido_" + indexNo).change(function() {
			// console.log($(this).val()); // $("#select-sido_" + indexNo);
			let area = "area" + $("option", $(this)).index($("option:selected", $(this))); // 선택지역의 구군 Array
			let gugun = $("#select-gugun_" + indexNo); // 선택영역 구/군 객체
			
			$("option", gugun).remove(); // 구/군 초기화
			
			if(area == "area0") {				
				gugun.append("<option value=''>구 / 군 선택</option>");
			} else {
				$.each(eval(area), function() {
					// console.log("this: ", this); // 강남구, 강동구...
					gugun.append("<option value='" + this + "'>" + this + "</option>");
				});
			}
		});
	}
	
	// 구/군 선택 박스 생성
	function setGugunSelect(indexNo) {
		let currentArea = "area" + $("option", $('#select-sido_' + indexNo)).index($("option:selected", $('#select-sido_' + indexNo)));
		let gugun = $('#select-gugun_' + indexNo);
		
		$("option", gugun).remove();
		
		if(currentArea == "area0") {				
			gugun.append("<option value=''>구 / 군 선택</option>");
		} else {
			$.each(eval(currentArea), function() {
				gugun.append("<option value='" + this + "'>" + this + "</option>");
			});
		}
	}
	
	// 엑셀 다운로드
	function downloadExcel() {
		location.href = "fileDownload.do?fileName=excel_sample.xlsx";
	}

	// 엑셀 업로드
	function uploadExcel() {
		let file = $('#file')[0].files;
		let fileFormData = new FormData();
		fileFormData.append("file", file[0]);
		
		$.ajax({
			url: "api/uploadFile.do",
			type: 'POST',
			data: fileFormData,
			processData: false, // 기본 값이 쿼리 문자열로 처리됨. 파일 전송을 위해 false
            contentType: false, // 파일 전송(multipart/form-data)을 위해 false
            success: function(res) {
            	console.log(res);
            	if (res.status === "success") {
            		let dataArray = Object.values(res);
                	let guestArr = Object.values(dataArray[0]);
                	
        			$('.add-btn-area').css('display', 'block'); // 버튼 출력
        			$('#file')[0].value = ''; // input file 초기화
                	
                	for (let i = 0; i < guestArr.length; i++) {
                		// console.log(guestArr[i]);
                		
                		$('#reserve-type').val("단체");
                		// $('.user-table-container').css('display', 'block');
                		                		
                		let addRow = '<tbody class="user-add-tbody"><tr id="userRow_' + indexNo + '">';
                		addRow += '<td class="row-index" id="rowIndex_' + indexNo + '">' + indexNo + '</td>';
                		addRow += '<td><input id="addUserName_' + indexNo + '" class="guestName" type="text" value="' + guestArr[i].guestName + '" /></td>';
                		
                		if (guestArr[i].guestGender == 1) {
                			addRow += '<td><filedset><input type="radio" value="0" name="genderType_' + indexNo + '" onclick="getGenderType(event, ' + indexNo + ')" />남자<input type="radio" value="1" name="genderType_' + indexNo + '" onclick="getGenderType(event, ' + indexNo + ')" checked />여자</fieldset</td>';	
                		} else {
                			addRow += '<td><filedset><input type="radio" value="0" name="genderType_' + indexNo + '" onclick="getGenderType(event, ' + indexNo + ')" checked />남자<input type="radio" value="1" name="genderType_' + indexNo + '" onclick="getGenderType(event, ' + indexNo + ')" />여자</fieldset</td>';	
                		}
                		
                		addRow += '<td><select class="selectSido" id="select-sido_' + indexNo + '"></select></td>';
                		addRow += '<td><select class="selectGugun" id="select-gugun_' + indexNo + '"></select></td>';
                		addRow += '<td><input type="checkbox" class="isDisabled" id="isDisabled_' + indexNo + '" /><span>장애여부</span></td>';
                		addRow += '<td><input type="checkbox" class="isForeigner" id="isForeigner_' + indexNo + '"/><span>외국인</span></td>';
                		addRow += '<td><button type="button" class="btn" onclick="deleteUser(' + indexNo + ')">삭제</button></td>';
                		
                		addRow += '</tr>';
                		
                		// hidden 필드로 성별값 저장
                		let genderCheckInput = '';
                		if (guestArr[i].guestGender == 1) {
                			genderCheckInput = '<input type="hidden" id="genderCheck_' + indexNo + '" value="1" />';
                		} else {
                			genderCheckInput = '<input type="hidden" id="genderCheck_' + indexNo + '" value="0" />';
                		}
                		
                		addRow += genderCheckInput;
                		addRow += '</tbody>';
                		
                		$('.user-add-table').append(addRow);
                		
                		
                		// $('.user-table-container').append(genderCheckInput);

                		// 주소 생성 및 셀렉트 박스 값 삽입
						showAddress(indexNo);
						$('#select-sido_' + indexNo).val(guestArr[i].guestSido);
						setGugunSelect(indexNo);
						
                		indexNo++;
                		
                		if (indexNo > 2) {
                			setFirstItemAbled();
                		}
                	}
            	}
            },
            error: function(err) {
            	console.error("에러: ", err);
            }
		});
	}
	
	function reserveList() {
		location.href = "reserveList.do";
	}
</script>
</html>