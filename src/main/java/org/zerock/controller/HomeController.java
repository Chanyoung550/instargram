package org.zerock.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.zerock.service.MemberService;
import org.zerock.user.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping
@AllArgsConstructor
@Log4j
public class HomeController {
	
	@Autowired
	private final MemberService service;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;

    @GetMapping("/")
    public String home() throws Exception {
        return "loginForm";
    }
    @GetMapping("/auth/login")
    public String home2() throws Exception {
        return "loginForm";
    }
    
    // 회원가입 페이지
    @GetMapping("/join")
    public String joinForm() throws Exception {
    	
        return "/auth/joinForm";
    }
	
    // 회원 가입 성공
	@PostMapping("/auth/join")
    public String joinForm(UserVO user, RedirectAttributes redirectAttributes) {
        String hashedPw = BCrypt.hashpw(user.getUserPassword(),BCrypt.gensalt());
        user.setUserPassword(hashedPw);
        service.register(user);
        
        return "redirect:/auth/login";
    }
	
	// ID 중복체크
	@RequestMapping(value="/idCheck", method=RequestMethod.GET, produces="application/text; charset=utf8")
	@ResponseBody
	public String idCheck(HttpServletRequest request) {
		String userID = request.getParameter("userID");
		int result = service.idCheck(userID);
		
		return Integer.toString(result);
	}


	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	@ResponseBody
	public String login(@RequestBody UserVO login, HttpSession session) throws Exception {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String result = null;
		
		//로그인 시도한 회원의 아이디와 일치하는 정보를 user에 할
		UserVO user = service.login(login);
		
		//아이디 존재 -> 가입된 회원이 존재 -> 비밀번호 확인 필요
		if(user != null) {
			//비밀번호 일치 -> 로그인성공
			if(encoder.matches(login.getUserPassword(), user.getUserPassword())) {
				//로그인 성공시 로그인 유지를 설정 -> 세션 사용 	//login이라는 이름의 세션에 로그인한 사람의 전체 정보를 저장한다.
				session.setAttribute("login", user);
				result = "loginSuccess";
				log.info("result: " + result);
				
				//브라우저 닫을 때까지 혹은 세션 유효기간이 만료되기 전까지 세션이 사용됨
				//session.setMaxInactiveInterval(60 * 60); 	//세션 만료시간을 1시간으로 설정
			} else {  //비밀번호 불일치
				result = "pwFail";
			}
		} else {  //이메일이 존재하지 않음
			result = "idFail";
		}
		
		return result;
	}
	
	// 로그인 성공
    @PostMapping("/login")
    public String loginSuccess() throws Exception {
    	
        return "/image/feed";
    }
    
	// LOGOUT	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		log.info("Bye. Logout success");
		return "redirect:/";
	}

}