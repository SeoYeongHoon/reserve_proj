package egovframework.example.cmmn;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener // 웹 애플리케이션에서 HttpSession 이벤트를 청취하는 리스너임을 지정
public class SessionConfig implements HttpSessionListener {

	// HashTable의 동시성 성능을 개선하기 위한 구현체.(key, value에 null 허용 X )
    // 사용자 아이디별로 세션을 관리하는 ConcurrentHashMap을 사용하여, 다중 스레드 환경(동시 요청)에서 안전하게 세션을 저장
    private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();

    // 중복 로그인 방지를 위한 메소드
    public static boolean loginSessionIdCheck(HttpSession session, String userId) {

        // 현재 사용자의 아이디로 저장된 세션이 있는지 확인
        HttpSession currentSession = sessions.get(userId); // get 메소드: 가장 최신 value를 return
        
        if (currentSession != null) {
            
            // 현재 세션과 기존 세션의 ID가 다르면 중복 로그인
            if (!currentSession.getId().equals(session.getId())) {
                // 기존 로그인을 로그아웃 시키고 싶을 경우
            	// (기존 세션을 무효화하고 새로운 세션을 저장)
                // currentSession.invalidate();
                // sessions.put(userId, session);
            	
                return true; // 중복 로그인 true 반환
            } else {
            	// 세션은 동일하지만 ID 달라서 정상 로그인
                return false; // 정상 로그인 false 반환
            }
        } else {
            // 사용자가 처음 로그인하는 경우 세션을 저장
            sessions.put(userId, session);
            return false;
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // 새로운 세션이 생성될 때 호출되는 메소드
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        // 세션이 파괴될 때 호출되는 메소드
        HttpSession session = se.getSession();
        // 세션 리스트에서 파괴된 세션을 제거
        sessions.values().removeIf(s -> s.getId().equals(session.getId()));
    }
}

