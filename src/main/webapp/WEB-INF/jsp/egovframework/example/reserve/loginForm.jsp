<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
	#loginContainer {
		max-width: 500px;
		margin: 150px auto;
		text-align: center;
	}
	
	.login-title {
		padding-bottom: 30px;
	    border-bottom: 1px solid rgb(0, 0, 0, 0.1);
	}
	
	.input-container {
		border-bottom: 1px solid rgb(0, 0, 0, 0.1);
    	padding-bottom: 20px;
    	position: relative;
	}
	
	.input-info {
		width: 92%; 
		height: 35px; 
		border: 1px solid rgb(0, 0, 0, 0.1);
		padding: 10px;
		font-size: 13pt;
		margin-top: 48px;
	}
	
	.login-btn {
		border: none;
	    background-color: crimson;
	    width: 95%;
	    height: 60px;
	    color: white;
	    font-size: 15pt;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.register-btn {
		border: none;
	    background: none;
	    width: 95%;
	    height: 60px;
	    font-size: 15pt;
	    cursor: pointer;
	}
</style>
<body>
	<div id="loginContainer">
		<h2 class="login-title">로그인</h2>
		<form action="login.do" id="loginForm" method="POST">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="input-container">
				<p style="position: absolute; padding-left: 14px; font-weight: bold;">아이디</p>
				<input value="${loginUser.userId }" type="text" name="userId" id="userId" class="input-info" placeholder="아이디" />
			</div>
			
			<div class="input-container" style="margin-top: 15px;">
				<p style="position: absolute; padding-left: 14px; font-weight: bold;">비밀번호</p>
				<input type="password" name="userPw" id="userPw" class="input-info" placeholder="비밀번호" />
			</div>
			
			<div style="margin-top: 30px;">
				<button class="login-btn" onClick="loginBtn()" type="button">로그인</button>
			</div>
			<div>
				<button class="register-btn" type="button" onclick="location.href='register.do'">회원가입</button>
			</div>
			
			<c:if test="${not empty errorMessage}">
			    <script>
			    	let errorMsg = '${errorMessage}';
			    	alert(errorMsg);
			    	$('#userId').val('');
			    	$('#userPw').val('');
		    		$('#userId').focus();
			    </script>
			</c:if>
			<c:if test="${not empty completeMsg }">
				<script>
					alert("${completeMsg}");
				</script>
			</c:if>
			<c:if test="${not empty loggedMessage }">
				<script>
					alert("${loggedMessage}");
		    		$('#userId').focus();
				</script>
			</c:if>
		</form>
	</div>
</body>
<script>
	function loginBtn() {
		let idVal = $('#userId');
		let pwVal = $('#userPw');
		
		if (idVal.val() === '') {
			alert("아이디를 입력해주세요.");
			idVal.focus();
			return false;
		}
		if (pwVal.val() === '') {
			alert("비밀번호를 입력해주세요.");
			pwVal.focus();
			return false;
		}
		
		let loginForm = $('#loginForm');
		loginForm.submit();
	}
</script>
</html>