package egovframework.example.sample.service;

import javax.servlet.http.HttpSession;

public interface UserService {
	// 로그인 기능
	String userLogin(String userId, String userPw, HttpSession session) throws Exception;
	
	// 회원가입 ID 중복 확인
	int checkIdExist(String userId) throws Exception;
	
	// 회원가입 기능
	void insertUser(UserVO userVO) throws Exception;
}
