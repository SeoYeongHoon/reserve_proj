package egovframework.example.sample.service.impl;

import egovframework.example.sample.service.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {
	// 로그인 기능
	UserVO userLogin(String userId) throws Exception;
	
	// 회원가입 ID 중복 확인
	int checkIdExist(String userId) throws Exception;
	
	// 회원가입 기능
	void insertUser(UserVO userVO) throws Exception;
}
