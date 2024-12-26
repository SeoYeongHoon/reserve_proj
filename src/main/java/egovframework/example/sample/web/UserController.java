package egovframework.example.sample.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

@Controller
public class UserController {
	@Resource(name = "userService")
	private UserService userService;
	
	// 로그인 페이지
	@GetMapping("/login.do")
	public String loginForm(HttpSession session) throws Exception {
		if (session.getAttribute("loginUser") == null) {
			return "reserve/loginForm";
		} else {
			return "redirect:/userCalendar.do";
		}
	}
	
	// 로그인 기능
	@PostMapping("/login.do")
	public String doLogin(@RequestParam("userId") String userId,
						  @RequestParam("userPw") String userPw,
						  HttpSession session,
						  Model model
						  ) throws Exception {
		
		String errorMessage = userService.userLogin(userId, userPw, session);

	    if (errorMessage == null) {
			return "redirect:/userCalendar.do";
	    } else if (errorMessage.equals("이미 로그인되어 있는 계정입니다. 로그아웃 처리 후 다시 시도해주세요.")) {	    	
	    	model.addAttribute("loggedMessage", errorMessage);
	    	return "reserve/loginForm";
	    } else {
	        model.addAttribute("errorMessage", errorMessage);
	        return "reserve/loginForm";
	    }
	}
	
	// 회원가입 아이디 중복 체크
	@RequestMapping(value = "/checkUserId.do", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String checkUserId(@RequestParam("userId") String userId
							  ) throws Exception {
		
		int count;		
		count = userService.checkIdExist(userId);
		
		if (count > 0) {			
			return "이미 사용 중인 아이디입니다.";
		} else {
			return "사용 가능한 아이디입니다.";
		}
		
	}
	
	// 회원가입 페이지
	@GetMapping("/register.do")
	public String registerForm() throws Exception {
		return "reserve/registerForm";
	}
	
	// 회원가입 기능
	@PostMapping("/register.do")
	public String doRegister(UserVO userVO,
							 RedirectAttributes redirectAttributes,
							 @RequestParam("checkPw") String checkPw,
							 Model model
							 ) throws Exception {
		
		String userIdVal = userVO.getUserId(); // 유저가 입력한 아이디
		String userPwVal = userVO.getUserPw(); // 유저가 입력한 비밀번호
		
		String idValidate = "^[a-zA-Z](?=.{0,28}[0-9])[0-9a-zA-Z]{5,15}$"; // 아이디 정규식
		String pwValidate = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{10,25}$"; // 비밀번호 정규식
		
		if (!userPwVal.equals(checkPw)) {
			model.addAttribute("validateError", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			return "reserve/registerForm";
		}
		
		if (!userPwVal.matches(pwValidate) || !userIdVal.matches(idValidate)) {
			model.addAttribute("validateError", "아이디 또는 비밀번호 형식이 올바르지 않습니다.");
			return "reserve/registerForm";
		}
		
		userService.insertUser(userVO);
		redirectAttributes.addFlashAttribute("completeMsg", "회원가입이 완료되었습니다.");
		
		return "redirect:/login.do";
	}
	
	// 로그아웃 기능
	@GetMapping("/logout")
	public String logout(HttpSession session,
						 RedirectAttributes redirectAttributes
						 ) throws Exception {
		session.invalidate(); // 로그인 세션 무효화 - 제거
		return "redirect:/login.do";
	}
}
