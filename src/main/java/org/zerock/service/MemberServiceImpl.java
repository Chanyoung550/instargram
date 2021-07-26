package org.zerock.service;


import org.springframework.stereotype.Service;
import org.zerock.mapper.UserMapper;
import org.zerock.user.UserVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	//@Autowired
	private UserMapper userMapper;
	
	@Override
	public void register(UserVO user) {
		userMapper.register(user);
		
	}

//	@Override
//	public int idCheck(UserVO user) {
//		int result = userMapper.idCheck(user);
//		return result;
//	}

	@Override
	public int idCheck(String userID) {
		int result = userMapper.idCheck(userID);
		return result;
	}
	
	@Override
	public UserVO login(UserVO login) {
		return userMapper.login(login);
	}

	
}
