<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안문 결재 확인 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
	#approvalContainer {
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
	    /* width: 18%; */
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
	.allowBtn {
		background-color: blue;
		color: white;
	}
	.denyBtn {
		background-color: red;
		color: white;
	}
	.moveDetailBtn {
		background-color: black;
		color: white;
	}
	
	.buttonArea {
		display: flex;
	    width: 180px;
	    justify-content: center;
	    gap: 10px;
	}
	
	.draft-title {
		overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    width: 400px;
	    margin: 0 auto;
	}
	.draft-content {
		overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    width: 600px;
	    margin: 0 auto;
	}
	
	.draftTitleData {
		cursor: pointer;
	}
	.draftTitleData:hover {
		background-color: #ddd;
	}
	
	#show-draft-details {
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
</style>
<body>
	<div id="approvalContainer">
		<h1>결재 확인</h1>
		<table class="reserve-table">
			<thead>
				<tr>
					<th style="width: 50px;">No</th>
					<th style="width: 400px;">기안문 제목</th>
					<!-- <th style="width: 600px;">기안문 내용</th> -->
					<th style="width: 120px;">신청자</th>
					<th style="width: 100px;">결재 유형</th>
					<th style="width: 80px;">확인</th>
				</tr>
			</thead>
			<tbody style="text-align: center;">
				<c:forEach var="infos" items="${draftInfos }" varStatus="status">
					<tr>
						<td class="draft-number">${status.count }</td>
						<td class="draftTitleData" onclick="showDraftDetail(${infos.draftNo})"><div class="draft-title">${infos.draftTitle }</div></td>
						<%-- <td><div class="draft-content">${infos.draftContent }</div></td> --%>
						<td><div class="draft-user-id" id="draftUserId_${infos.draftNo }">${infos.userId }</div></td>
						<c:choose>
							<c:when test="${infos.draftType eq 0 }">
								<td>결재</td>
							</c:when>
							<c:when test="${infos.draftType eq 1 }">
								<td>협조</td>
							</c:when>
							<c:when test="${infos.draftType eq 2 }">
								<td>참조</td>
							</c:when>
						</c:choose>
						<td><button class="btn moveDetailBtn" type="button" onclick="moveToDetail(${infos.resId })">이동</button>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- 기안문 상세정보 팝업창 -->	
	<div id="overlay"></div>
	<div id="show-draft-details" class="hidden">
		<h1>기안문 정보</h1>
		<div id="draft-table-container">
			
		</div>
	</div>
</body>
<script>
	function moveToDetail(resId) {
		location.href = "reserveDetail.do?resId=" + resId;
	}
	
	// 기안문 상세보기
	function showDraftDetail(index) {
		let confirmBtn = "";
		let popup = $('#show-draft-details');
		let overlay = $('#overlay');
		
		// 팝업창 출력
		popup.removeClass('hidden');
		popup.css('display', "block");
		overlay.removeClass("hidden");
		overlay.css("display", "block");
		
		overlay.on('click', function() {
			popup.addClass("hidden");
			popup.css("display", "none");
			overlay.css("display", "none");
			overlay.css("display", "none");
		});
		
		let draftContainer = $('#draft-table-container');
		let userId = $('#draftUserId_' + index).text();
		
		$.ajax({
			url: "api/showDraftDetail.do",
			type: "post",
			data: { userId: userId },
			dataType: 'json',
			success: function(data) {
				let draftHtml = "";
				draftHtml += "<p>" + data.userName + " (" + data.userId + ")</p>";
				draftHtml += "<p>" + data.draftTitle + "</p>";
				draftHtml += "<p>" + data.draftContent + "</p>";
				
				if (data.files.length > 0) {					
					for (let i = 0; i < data.files.length; i++) {
						draftHtml += "<a href='javascript:downloadFile(" + data.files[i].fileNo + ")'>" + data.files[i].fileName + "</a>";
					}
				}
				
				draftContainer.append(draftHtml);
			},
			error: function(err) {
				console.log("에러: ", err);
			}
		});
	}
	
	// 엑셀 다운로드
	function downloadFile(no) {
		location.href = "api/downloadFile.do?fileNo=" + no;
	}
</script>
</html>