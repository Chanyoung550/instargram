package org.zerock.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.zerock.instardto.CommentVO;
import org.zerock.instardto.FollowVO;
import org.zerock.instardto.LikeVO;
import org.zerock.instardto.PhotoVO;
import org.zerock.instardto.UserVO;
import org.zerock.mapper.UserMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	
	private UserMapper userMapper;
	
	// 회원가입
	@Override
	public void register(UserVO user) {
		userMapper.register(user);
		
	}

	// 아이디 중복 체크
	@Override
	public int idCheck(String user_id) {
		int result = userMapper.idCheck(user_id);
		return result;
	}
	
	// 로그인
	@Override
	public UserVO login(UserVO login) {
		return userMapper.login(login);
	}

	//게시물수 조회
	@Override
	public int contentcnt(String user_id) {
		return userMapper.contentcnt(user_id);
	}

	//팔로워수 조회
	@Override
	public int followercnt(String user_id) {
		return userMapper.followercnt(user_id);
	}
	
	//팔로우수 조회
	@Override
	public int followcnt(String user_id) {
		return userMapper.followcnt(user_id);
	}
	
	//이미지업로드
	@Override
	public void upload(PhotoVO pVo) {
		userMapper.upload(pVo);
	}

	//업로드된 이미지데이터 가져오기
	@Override
	public List<PhotoVO> selectphoto(String user_id) {
		return userMapper.selectphoto(user_id);
	}

	//follow 등록
	@Override
	public void insertfollow(FollowVO fVo) {
		userMapper.insertfollow(fVo);
		
	}

	//프로필 페이지로 유저정보를 가져옴
	@Override
	public UserVO selectuser(String user_id) {
		return userMapper.selectuser(user_id);
	}

	//프로필 업데이트
	@Override
	public void profileupload(UserVO vo) {
		userMapper.profileupload(vo);
		
	}
	
	//팔로우 리스트 가져오기
	@Override
	public List<FollowVO> followlist(String user_id) {
		return userMapper.followlist(user_id);
	}

	//팔로워 리스트 가져오기
	@Override
	public List<FollowVO> followerlist(String user_id) {
		return userMapper.followerlist(user_id);
	}

	//메인 리스트 가져오기
	@Override
	public List<PhotoVO> mainlist(List<FollowVO> list) {
		return userMapper.mainlist(list);
	}

	//좋아요 순으로 가져오기
	@Override
	public List<PhotoVO> likelist() {
		return userMapper.likelist();
	}

	//댓글 등록하기
	@Override
	public void commentwrite(CommentVO vo) {
		userMapper.commentwrite(vo);
		
	}

	//댓글 가져오기
	@Override
	public List<CommentVO> commentselect(List<PhotoVO> photo) {
		return userMapper.commentselect(photo);
	}

	//댓글 삭제하기
	@Override
	public void commentdelete(CommentVO vo) {
		userMapper.commentdelete(vo);
		
	}

	//유저아이디에 관련된 좋아요 리스트 가져오기
	@Override
	public List<LikeVO> likeselect(List<PhotoVO> photo, String userid) {
		return userMapper.likeselect(photo, userid);
	}

	//팔로우 되어있는지 확인
	@Override
	public int followcheck(String user_id, String follow_user) {
		return userMapper.followcheck(user_id, follow_user);
	}

	//팔로우 하기
	@Override
	public void followupdate(FollowVO fVo) {
		userMapper.followupdate(fVo);
		
	}

	//팔로우 취소
	@Override
	public void followDelete(FollowVO fVo) {
		userMapper.followDelete(fVo);
		
	}

	//프로필 사진 업로드 후 포토테이블 유저사진 업로드
	@Override
	public void updateprofile(String user_photourl, String user_photothumb, String userid) {
		userMapper.updateprofile(user_photourl, user_photothumb, userid);
		
	}

	//좋아요 누르기
	@Override
	public void likeupdate(LikeVO lVo) {
		userMapper.likeupdate(lVo);
	}

	//좋아요 카운트 업데이트
	@Override
	public void likecntupdate(int pno) {
		userMapper.likecntupdate(pno);
	}

	//좋아요 삭제 누르기
	@Override
	public void likedelete(LikeVO lVo) {
		userMapper.likedelete(lVo);
		
	}

	//좋아요 카운트 업데이트
	@Override
	public void likecntdelete(int pno) {
		userMapper.likecntdelete(pno);
	}

	//메인 리스트 카운트
	@Override
	public int mainlistcnt(List<FollowVO> list) {
		return userMapper.mainlistcnt(list);
	}

	
}
