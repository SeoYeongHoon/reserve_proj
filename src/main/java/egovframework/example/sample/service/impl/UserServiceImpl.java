package egovframework.example.sample.service.impl;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.SessionConfig;
import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {
	
	@Resource(name = "userMapper")
	private UserMapper userMapper;
	
	BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	// 로그인 기능
	@Override
	public String userLogin(String userId, String userPw, HttpSession session) {
        try {
            // 유저 정보 조회
            UserVO userVO = userMapper.userLogin(userId);
            
            // 없는 아이디 or 비밀번호 입력X or 비밀번호 틀렸을 경우
            if (userVO == null
            	|| !encoder.matches(userPw, userVO.getUserPw())) {
                return "등록되지 않은 아이디이거나, 비밀번호가 일치하지 않습니다.";
            }

            // 중복 로그인 방지 체크
            boolean userLoginCheck = SessionConfig.loginSessionIdCheck(session, userVO.getUserId());
            if (userLoginCheck) {
                return "이미 로그인되어 있는 계정입니다. 로그아웃 처리 후 다시 시도해주세요.";
            }

            // 로그인 성공 시 세션에 유저 정보 저장 - setAttribute(String name, Object value)
            session.setAttribute("loginUser", userVO);
            return null; // 성공 시 오류 메시지 없음

        } catch (Exception e) {
            e.printStackTrace();
            return "일시적인 오류로 로그인을 할 수 없습니다. 잠시 후 다시 이용해 주세요.";
        }
    }

	// 회원가입 시 ID 중복 확인
	@Override
	public int checkIdExist(String userId) throws Exception {
		return userMapper.checkIdExist(userId);
	}

	// 회원가입 기능
	@Override
	public void insertUser(UserVO userVO) throws Exception {
		String encodedPw = encoder.encode(userVO.getUserPw());
		userVO.setUserPw(encodedPw);
		
		userMapper.insertUser(userVO);
	}

}
