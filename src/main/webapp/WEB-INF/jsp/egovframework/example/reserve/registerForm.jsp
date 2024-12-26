<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<style>
	#registerContainer {
		max-width: 1080px;
		margin: 100px auto;
	}
	
	.input-container {
		border-bottom: 1px solid rgb(0, 0, 0, 0.1);
		margin-top: 20px;
    	padding-bottom: 20px;
    	position: relative;
	}
	
	.input-info { 
		border: 1px solid rgb(0, 0, 0, 0.1);
		padding: 10px;
		font-size: 13pt;
	}
	
	.cancel-btn {
		border: none;
		border-radius: 5px;
		background-color: lightgray;
		padding: 20px 35px;
		cursor: pointer;
	}
	.cancel-btn:hover {
		opacity: 0.6;
	}
	
	.register-btn {
		border: none;
		border-radius: 5px;
		margin-left: 10px;
		background-color: royalblue;
		color: white;
		cursor: pointer;
		padding: 20px 35px;
	}
	.register-btn:hover {
		opacity: 0.6;
	}
	
	.input-label {
		display: inline-block;
		width: 200px;
		text-align: center;
	}
	
	.input-tip {
		font-size: 10pt;
	}
	
	.check-btn {
		border: 1px solid black;
	    cursor: pointer;
	    color: white;
	    border-radius: 5px;
	    background-color: black;
	    height: 42px;
	}
	.check-btn:hover {
		opacity: 0.6;
	}
</style>
<body>
	<div id="registerContainer">
		<h2>회원정보 입력</h2>
		<hr>
		<form id="registerForm" name="registerForm" method="POST">
			<div class="input-container">
				<label class="input-label" for="userId"><span style="color: red;">&#10004;</span> 아이디</label>
				<input type="text" name="userId" id="userId" class="input-info" />
				<div id="checkIdArea" style="display: inline-block">
					<button type="button" class="check-btn" onclick="checkUserId()">중복확인</button>
					<span class="input-condition">한글, 특수문자를 제외한 5~15자까지의 영문과 숫자로 입력해주세요.</span>
				</div>
				<div id="checkFinishArea" style="display: none">
					<span class="input-tip" style="color: blue">사용 가능한 아이디입니다.</span>
				</div>
			</div>
			
			<div class="input-container">
				<label class="input-label" for="userPw"><span style="color: red;">&#10004;</span> 비밀번호</label>
				<input type="password" name="userPw" id="userPw" class="input-info" style="width: 300px;" />
				<span class="input-tip">숫자+영문자+특수문자 조합으로 10자리 이상 사용해야 합니다.(10자리~25자리)</span>
			</div>
			<div class="input-container">	
				<label class="input-label" for="checkPw"><span style="color: red;">&#10004;</span> 비밀번호 확인</label>
				<input type="password" name="checkPw" id="checkPw" class="input-info" style="width: 300px;" />
			</div>
			
			<div class="input-container">
				<label class="input-label" for="userName"><span style="color: red;">&#10004;</span> 이름</label>
				<input type="text" name="userName" id="userName" class="input-info" />
			</div>
			
			<div class="input-container">
				<label class="input-label" for="userPhone"><span style="color: red;">&#10004;</span> 휴대폰</label>
				<input type="text" name="userPhone" id="userPhone" class="input-info" oninput="addHyphen(this)" maxlength="13" autocomplete="off" style="width: 300px;" />
			</div>
			
			<div style="text-align: center; margin-top: 40px">
				<button class="cancel-btn" type="button" onclick="location.href='login.do'">취소</button>
				<button class="register-btn" type="button" onclick="submitRegister()">가입</button>
			</div>
		</form>
	</div>
	<c:if test="${not empty errorMessage }">
		<script>
			alert('${errorMessage}');
		</script>
	</c:if>
	<c:if test="${not empty validateError }">
		<script>
			alert("${validateError}");
		</script>
	</c:if>
</body>

<script>
	let inputUserId = $('#userId');
	let pw = $('#userPw');
	let pwCheck = $('#checkPw');
	let inputName = $('#userName');
	let isIdValid = 0;
	let phoneInput = $('#userPhone');
	
	let registerForm = $('#registerForm');
	
	// 비정상적인 submit 접근 차단
	registerForm.on("submit", function(e) {
		e.preventDefault();
		alert("잘못된 접근입니다.");
	});
	
	// 아이디 중복체크
	function checkUserId() {	
		// 영문과 숫자 조합으로 5~15자리 정규식
		let idValidate = /^[a-zA-Z](?=.{0,28}[0-9])[0-9a-zA-Z]{5,15}$/;	
		
		if (!inputUserId.val()) {
			alert("아이디를 먼저 입력해주세요.");
			inputUserId.focus();
			return false;
		}
		
		// test() 메소드: 문자열이 정규표현식과 일치하는지 Boolean 반환
		if (!idValidate.test(inputUserId.val())) {
			alert("아이디 형식을 확인하세요.");
			inputUserId.focus();
			return false;
		}
		
		let userId = inputUserId.val();
		
		$.ajax({
		    type: 'POST',
		    data: { userId: userId },
		    url: 'checkUserId.do',
		    dataType: 'text', // 서버로부터 반환받을 데이터 타입
		    success: function(data) {
		        alert(data);
		        if (data == '사용 가능한 아이디입니다.') {
					isIdValid = 1;
					// inputUserId.attr('readonly', true);
					$('.input-condition').css("display", "none");
					$('#checkFinishArea').css("display", "inline-block");
				} else {
					inputUserId.focus();
					$('.input-condition').css("display", "inline-block");
					$('#checkFinishArea').css("display", "none");
				}
		    },
		    error: function(error) {
		        console.error("에러: ", error);
		    }
		});
	}
	
	// 중복확인 완료했지만 다시 아이디를 입력할 경우
	inputUserId.on('change', function() {
		isIdValid = 0;
		$('.input-condition').css("display", "inline-block");
		$('#checkFinishArea').css("display", "none");
	});
	
	// 휴대폰 번호 올바른지 확인
	const addHyphen = (target) => {
	    target.value = target.value
	    	.replace(/[^0-9]/g, '') // 숫자 제외한 문자 제거
	    	.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3") // 숫자 $1(2,3)-$2(3,4)-$3(4) 자리로 치환
	    	.replace(/(\-{1,2})$/g, ""); 
	}
	
	// 휴대폰 유효성 확인, 비밀번호 확인 및 가입 버튼
	function submitRegister() {
		if (!inputUserId.val() || !pw.val() || !inputName.val() || !phoneInput.val()) {
			alert("모든 입력란에 정보를 입력해주세요.");
			inputUserId.focus();
			return false;
		}
		
		if (phoneInput.val() > 13) {
			alert("휴대폰 번호를 올바르게 입력해주세요.");
			phoneInput.focus();
			return false;
		} 
		
		if (isIdValid != 1) {
			alert("아이디 중복확인을 해주세요!");
			inputUserId.focus();
			return false;
		}
		
		// 영문 + 숫자 + 특수문자 조합 10~25자리 정규식
		let pwValidate = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{10,25}$/;
		if (!pwValidate.test(pw.val())) {
			alert("비밀번호 형식을 확인하세요.");
			pw.focus();
			return false;
		}
		
		if (pw.val() != pwCheck.val()) {
			alert("비밀번호가 같지 않습니다.");
			pwCheck.focus();
			return false;
		}
		
		if (confirm("회원가입 하시겠습니까?")) {
			registerForm.unbind();	// 비정상적인 submit 접근 해제
			registerForm.attr("action", "register.do");
			registerForm.submit();
		}
	}
</script>
</html>