package org.zerock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.user.UserVO;

@Mapper
public interface UserMapper {
	
	//회원가입
	public void register(UserVO user);
	
	//아이디 중복 확인
	public int idCheck(String userID);
	
	//로그인시 회원정보 조회
	UserVO login(UserVO login);
	
}