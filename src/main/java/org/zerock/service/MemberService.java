package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.instardto.CommentVO;
import org.zerock.instardto.FollowVO;
import org.zerock.instardto.LikeVO;
import org.zerock.instardto.PhotoVO;
import org.zerock.instardto.UserVO;

public interface MemberService {

	
	// 회원가입
	public void register(UserVO user);
	
	// 아이디 중복 체크
	public int idCheck(String user_id);
	
	// 로그인
	public UserVO login(UserVO login);
	
	//게시물수 조회
	public int contentcnt(String user_id);
	
	//팔로워수 조회
	public int followercnt(String user_id);
	
	//팔로우수 조회
	public int followcnt(String user_id);
	
	//이미지 업로드
	public void upload(PhotoVO pVo);
	
	//업로드된 이미지데이터 가져오기
	public List<PhotoVO> selectphoto(String user_id);
	
	//follow 등록
	public void insertfollow(FollowVO fVo);
	
	//프로필 페이지로 유저정보를 가져옴
	public UserVO selectuser(String user_id);
	
	//프로필 업데이트
	public void profileupload(UserVO vo);
	
	//팔로우 리스트 가져오기
	public List<FollowVO> followlist(String user_id);
	
	//팔로워 리스트 가져오기
	public List<FollowVO> followerlist(String user_id);
	
	//메인 리스트 가져오기
	public List<PhotoVO> mainlist(List<FollowVO> list);
	
	//메인 리스트 카운트
	public int mainlistcnt(List<FollowVO> list);
	
	//좋아요 순으로 가져오기
	public List<PhotoVO> likelist();
	
	//댓글 등록하기
	public void commentwrite(CommentVO vo);
	
	//댓글 가져오기
	public List<CommentVO> commentselect (List<PhotoVO> photo);
	
	//댓글 삭제하기
	public void  commentdelete(CommentVO vo);
	
	//유저아이디에 관련된 좋아요 리스트 가져오기
	public List<LikeVO> likeselect(List<PhotoVO> photo, String userid);
	
	//팔로우 되어있는지 확인
	public int followcheck(String user_id, String follow_user);
	
	//팔로우 하기
	public void followupdate(FollowVO fVo);
	
	//팔로우 취소
	public void followDelete(FollowVO fVo);
	
	//프로필 사진 업로드 후 포토테이블 유저사진 업로드
	public void updateprofile(String user_photourl, String user_photothumb, String userid);
	
	//좋아요 누르기
	public void likeupdate(LikeVO lVo);
	
	//좋아요 카운트 업데이트
	public void likecntupdate(int pno);
	
	//좋아요 삭제 누르기
	public void likedelete(LikeVO lVo);
	
	//좋아요 카운트 업데이트
	public void likecntdelete(int pno);
}
