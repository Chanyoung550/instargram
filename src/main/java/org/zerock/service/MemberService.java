package org.zerock.service;

import org.zerock.user.UserVO;

public interface MemberService {

	//member service interface 구현
	
	// 회원가입
	public void register(UserVO user);
	
	// 아이디 중복 체크
	public int idCheck(String userID);
	
	// 로그인
	public UserVO login(UserVO login);
	
}
