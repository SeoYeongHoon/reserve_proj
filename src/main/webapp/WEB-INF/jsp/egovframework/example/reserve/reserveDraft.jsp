<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안문 작성</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
	#draftContainer {
		width: 1200px;
		height: 1000px;
		margin: 50px auto;
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
	.titleArea {
		display: flex;
	    align-items: center;
	    gap: 8px;
	    border-left: 1px solid #ddd;
	    border-bottom: 1px solid #ddd;
	    border-right: 1px solid #ddd;
	}
	.titleLabel {
		width: 238px;
	    text-align: center;
	    background-color: #f4f4f4;
	    padding: 16px 0px;
	    border-right: 1px solid #ddd;
	    color: #555;
	    font-weight: bold;
	}
	.titleInput {
	    width: 77%;
	    padding: 10px;
	    font-size: 12pt;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    font-weight: bold;
	}
	#content {
		border: 1px solid #ddd;
	    background-color: #f4f4f4;
	    text-align: center;
	    padding: 10px;
	}
	#contentInput {
		width: 1140px;
	    height: 400px;
	    resize: none;
	    border: 1px solid #ddd;
	    font-size: 12pt;
	    font-weight: bold;
	    padding: 10px;
	}
	
	.fileInput {
		display: none;
	}
	.draft-file-label {
		cursor: pointer;
		border: 1px dotted #ddd;
	    padding: 8px;
	    color: darkgray;
	}
	.fileList {
		padding: 10px;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    margin-top: 5px;
	}
	.file-name {
		margin: 0;
	}
	.removeFile {
		display: flex;
		align-items: center;
		gap: 10px;
		cursor: pointer;
	}
	.removeFile:hover {
		text-decoration: underline;
	}
	.remove-btn {
		height: 18px;
	}
	
	.button-area {
		margin-top: 15px;
	}
	.close-btn {
		background-color: #000;
		color: white;
	}
	.select-approver-btn {
		float: right;
		margin-right: 15px;
		background-color: #11735f;
    	color: white;
	}
	.request-approve-btn {
		float: right;
		background: #607324;
    	color: white;
	}
</style>
<body>
	<div id="draftContainer">
		<input type="hidden" id="userId" value="${loginUser.userId }" />
		<input type="hidden" id="resId" value="${resInfo.resId }" />
		<h1>예약 마감신청 기안문</h1>
		<hr>
		
		<div style="display: flex; text-align: center;">
			<table class="reserve-table">
				<thead>
					<tr>
						<th>결재자</th>
					</tr>
				</thead>
				<tbody id="approval-tbody">
				</tbody>
			</table>
			<table class="reserve-table">
				<thead>
					<tr>
						<th>협조자</th>
					</tr>
				</thead>
				<tbody id="coop-tbody">
				</tbody>
			</table>
			<table class="reserve-table">
				<thead>
					<tr>
						<th>참조자</th>
					</tr>
				</thead>
				<tbody id="refer-tbody">
				</tbody>
			</table>
		</div>
		
		<table class="reserve-table">
		    <tr>
		        <th>체험명</th>
		        <td>${resInfo.resTitle }</td>
		        <th>예약시간</th>
		        <td>${resInfo.resDate } (${resInfo.resTime })</td>
		    </tr>
		    <tr>
		    	<th>작성자</th>
		    	<td>${loginUser.userName }</td>
		    	<th>기안일자</th>
		    	<td>
		    		<c:set var="today" value="<%=new java.util.Date()%>" />
		    		<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd hh:mm:ss" /></c:set>
		    		<c:out value="${date }" />
		    	</td>
		    </tr>
		</table>
		<div class="titleArea">
			<div class="titleLabel">제목</div>
			<input type="text" id="draftTitle" class="titleInput" placeholder="제목을 입력해주세요."/>
		</div>
		<div id="content">
			<textarea id="contentInput" placeholder="내용을 입력해주세요."></textarea>
		</div>
		<div class="titleArea">
			<div class="titleLabel">첨부파일</div>
			<label class="draft-file-label" for="file">클릭하여 첨부파일을 등록하세요.</label>
			<input type="file" id="file" class="fileInput" onchange="addFile(this)" multiple />
		</div>
		<div class="fileList">
		</div>
		
		<div class="button-area">
			<button class="btn close-btn" type="button" id="goBackBtn">돌아가기</button>
			<button id="requestApprove" class="btn request-approve-btn" type="button">결재요청</button>
			<button id="selectApprover" class="btn select-approver-btn" type="button">결재라인지정</button>
		</div>
	</div>
	<div id="dataObj">
	</div>
</body>
<script>
	let resId = $('#resId').val();
	
	$('#goBackBtn').on('click', function() {
		location.href = "reserveDetail.do?resId=" + resId;
	})
    
    let fileNo = 0; // 파일이 있는 태그마다 id 값을 주기 위해 선언
	let filesArr = []; // 파일들을 담을 배열 생성
    
	// 파일 추가
    function addFile(obj) {
	    // 현재 파일 input에 선택된 파일들의 개수를 저장
	    let curFileCnt = obj.files.length;

	    // 선택된 각 파일을 순회하며 추가 작업 수행
	    for (let i = 0; i < curFileCnt; i++) {
	        let file = obj.files[i];
	        filesArr.push(file); // 선택된 파일을 filesArr 배열에 추가

	        // 파일 목록 HTML 생성
	        let fileName = "";
			fileName += '<a class="removeFile" onclick="deleteFile(' + i + ')"><img class="remove-btn" src="/reserve_proj/images/egovframework/reserve/removebtn.png"</a>';
    		fileName += "<p class='file-name'>" + file.name + "</p>";
	    	$('.fileList').append(fileName);
	    	
	        fileNo++; // 다음 파일 번호 증가
		    
		    formData.append("fileList", $('#file')[0].files[i]);
	    }

	    // DataTransfer 객체를 통해 파일 input의 files 속성을 업데이트
	    let dataTransfer = new DataTransfer();
	    
	    // filesArr 배열의 파일들을 dataTransfer에 추가하여 새로운 파일 목록 생성
	    filesArr.forEach(function(file) {
	        dataTransfer.items.add(file);
	    });

	    // file input 요소의 files 속성을 새로운 dataTransfer.files로 설정
	    $('#file')[0].files = dataTransfer.files;
	}
	
    // 파일 제거
	function deleteFile(num) {
	    if (confirm("삭제하시겠습니까?")) {
	        
	        // filesArr 배열에서 num 인덱스의 파일을 제거하여 삭제 처리
	        filesArr.splice(num, 1);
	
	        // 새로운 DataTransfer 객체 생성 - input[type="file"]의 files 속성을 수정하기 위해 사용
	        let dataTransfer = new DataTransfer();
	        
	        // filesArr에 남아 있는 파일들을 dataTransfer 객체에 추가하여 새로운 파일 목록 생성
	        filesArr.forEach(function(file) {
	            dataTransfer.items.add(file);
	        });
	        
	        // file input 요소의 files 속성을 새롭게 구성된 dataTransfer.files로 업데이트
	        $('#file')[0].files = dataTransfer.files;

	        $('.fileList').html(''); // 파일 리스트 전체 삭제
	        fileNo = 0; // 파일 인덱스를 0으로 초기화하여 다시 새로고침된 파일 목록을 순차적으로 추가
	        
	        // 파일 목록 갱신: filesArr 배열의 파일들을 기반으로 새 파일 목록 생성
	        filesArr.forEach(function(file) {
	        	let fileName = "";
				fileName += '<a class="removeFile" onclick="deleteFile(' + fileNo + ');"><img class="remove-btn" src="/reserve_proj/images/egovframework/reserve/removebtn.png"</a>';
	    		fileName += "<p class='file-name'>" + file.name + "</p>";
		    	$('.fileList').append(fileName);
	            
	            fileNo++;
	        });
	    }
	}
    
	// 결재라인 선택
	$('#selectApprover').on('click', function() {
		let userId = $('#userId').val();
		
		// 팝업을 띄울 페이지 URL
		let popupURL = "reserveApprover.do";
		// 팝업 창의 속성
		let option = "width=1400, height=1000";
		
		// 팝업 열기
		// window.open(popupURL, "_blank", option);
		window.open(popupURL, 'childWindow', option);
	});

	// Ajax를 통해 컨트롤러로 보낼 데이터들을 모두 담을 formData 생성
	let formData = new FormData();	
	
	// 결재요청
	$('#requestApprove').on('click', function() {
		if ($('#approval-tbody td').length < 1) {
			alert("결재자를 최소 한 명 이상 지정하세요.");
			return;
		}
		
		if ($('#draftTitle').val() == "") {
			alert("제목을 입력하세요.");
			return;
		}
		
		let approveArr = [];
		for (let i = 0; i < $('.approveLines').length; i++) {
			approveArr.push($('#approveLineId_' + i).val());
		}
		let coopArr = [];
		for (let i = 0; i < $('.coopLines').length; i++) {
			coopArr.push($('#coopLineId_' + i).val());
		}
		let referArr = [];
		for (let i = 0; i < $('.referLines').length; i++) {
			referArr.push($('#referLineId_' + i).val());
		}
		
		let draftTitle = $('#draftTitle').val();
		let draftContent = $('#contentInput').val();
		
		let draftInfo = {
		    resId: resId,
		    draftTitle: draftTitle,
		    draftContent: draftContent
		};
		let lineInfo = {
		    approveList: approveArr,
		    coopList: coopArr,
		    referList: referArr
		};

		// JSON 데이터를 FormData에 추가
		formData.append("draftData", JSON.stringify(draftInfo));
		formData.append("lineData", JSON.stringify(lineInfo));
		
		if (confirm("결재요청을 하시겠습니까?")) {
			$.ajax({
				url: "requestApproval.do",
				type: "post",
				// contentType: 'application/json',
				// data: draftData,
				data: formData,
				processData: false, // 기본 값 쿼리 문자열로 처리됨. FormData를 쿼리 문자열로 변환하지 않음
	            contentType: false, // 파일 전송(multipart/form-data)을 위해 false 
	            success: function(response) {
			        if (response.success) {
				    	console.log("요청 완료");
				    	location.href = "reserveDetail.do?resId=" + resId;
			        } else {
			            alert("요청 실패: " + (response.message || "알 수 없는 오류가 발생했습니다."));
			        }
			    },
			    error: function(err) {
			    	console.error(err);
			    	alert("서버와의 통신에 실패했습니다. 잠시 후 다시 시도해주세요.");
			    }
			});
		}
	});
</script>
</html>