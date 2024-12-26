package egovframework.example.cmmn;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.example.sample.service.UserVO;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {
	// 전체 호출순서: Filter(web.xml) -> DispatcherServlet(dispatcher-servlet.xml)
	// -> preHandle -> Controller(요청처리) -> postHandle -> jsp(view 랜더링) -> afterCompletion
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// Controller 호출 전에 처리(가로챔).
	@Override
	public boolean preHandle(HttpServletRequest request, 
							 HttpServletResponse response,
							 Object handler
							 ) throws Exception {
		
		// preHandle:  컨트롤러(URI)로 가기 전에 요청을 가로챔
		
		// 세션을 가져와서 null이거나 loginUser 값이 null이면 로그인 페이지로 보내기, 그리고 인터셉터 종료.		
		HttpSession session = request.getSession();
		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect("login.do"); // 로그인 페이지로 리다이렉트
	        return false; // 요청 처리를 중단
		}
		
		// 어드민 계정이 아닌데 URL로 접근 시 차단
		UserVO userVO = (UserVO) session.getAttribute("loginUser");
		// 어드민 계정이 아닌 경우 특정 URL 접근 차단
        String requestUrl = request.getRequestURL().toString();
        if (!userVO.getUserType().equals("1") && adminOnlyUrl(requestUrl)) {
            response.sendRedirect("userCalendar.do"); // 리스트 페이지로 리다이렉트
            return false; // 요청 처리 중단
        }
		
		return true;
	}
	
	// 관리자만 접근 가능한 URL인지 확인
    private boolean adminOnlyUrl(String requestUrl) {
        return requestUrl.contains("adminCalendar.do") ||
               requestUrl.contains("reservePost.do") ||
               requestUrl.contains("reserveDetail.do") ||
               requestUrl.contains("reserveDraft.do") ||
               requestUrl.contains("reserveApprover.do");
    }
	
	// Controller 호출 후 처리.
	@Override
	public void postHandle(HttpServletRequest request, 
						   HttpServletResponse response, 
						   Object handler,
						   ModelAndView modelAndView
						   ) throws Exception {
		
		// postHandle:  컨트롤러 실행 후에 실행됨
		// 컨트롤러 실행 후 처리 로직이 필요하면 작성
		
	}
	
	// 예외가 발생해도 실행됨.
	@Override
	public void afterCompletion(HttpServletRequest request, 
							 	HttpServletResponse response, 
							 	Object handler,
							 	Exception ex
							 	) throws Exception {
		// preHandle: 메소드의 return값이 true일 때 실행됨
		// 요청 완료 후 추가 처리 로직이 필요하면 작성
	}
}
