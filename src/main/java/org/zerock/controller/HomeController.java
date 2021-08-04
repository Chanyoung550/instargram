package org.zerock.controller;


import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.instardto.CommentVO;
import org.zerock.instardto.FollowVO;
import org.zerock.instardto.LikeCntVO;
import org.zerock.instardto.LikeVO;
import org.zerock.instardto.PhotoVO;
import org.zerock.instardto.UserVO;
import org.zerock.service.MemberService;
import org.zerock.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping
@AllArgsConstructor
@Log4j
public class HomeController {
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Autowired
	private final MemberService service;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;

    @GetMapping("/login")//로그인 페이지로 이동
    public String home() throws Exception {
        return "loginForm";
    }
    // 회원가입 페이지
    @GetMapping("/join")
    public String joinForm() throws Exception {
    	
        return "/auth/joinForm";
    }
	
    // 회원 가입 성공
	@PostMapping("/auth/join")
    public String join(UserVO user, RedirectAttributes redirectAttributes) {
        String hashedPw = BCrypt.hashpw(user.getUser_pwd(),BCrypt.gensalt());//비밀번호를 암호화 해서 변수에 담음.
        user.setUser_pwd(hashedPw);//userVO에 암호화된 비밀번호를 담음
        service.register(user);//회원가입하려는 정보를 데이터베이스에 저장
        
        return "loginForm";
    }
	
	// ID 중복체크
	@RequestMapping(value="/idCheck", method=RequestMethod.GET, produces="application/text; charset=utf8")
	@ResponseBody
	public String idCheck(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");//파라미터로 받은 아이디를 변수에 담음
		int result = service.idCheck(user_id);//아이디가 존재하는지 카운트.
		
		return Integer.toString(result);//아이디가 존재하면 1 존재하지않으면 0 을 반환
	}

	//로그인 컨트롤러
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	@ResponseBody
	public String login(@RequestBody UserVO vo, HttpSession session) throws Exception {
	      log.info("vo : "+vo);
	      String result = null;
	      
	      UserVO user = service.login(vo); //로그인 시도한 회원의 아이디와 일치하는 정보를 user에 할당.
	      //아이디 존재 -> 가입된 회원이 존재 -> 비밀번호 확인 필요
	      if(user != null&&BCrypt.checkpw(vo.getUser_pwd(), user.getUser_pwd())) { //아이디값이 null이 아니고 데이터베이스에서 가져온 암호화된 패스워드와 
	    	  																	 //파라미터로 전달된 패스워드를 암호화시켜 비교후 값이 일치하면 session에 저장 후 
	    	  																	 //result값을 loginSuccess로 전달(로그인 성공)
	         session.setAttribute("login", user);
	         result = "loginSuccess";
	         
	      } else {  //아이디가 존재하지 않음
	         result = "idFail";
	      }
	      
	      return result;
	}
	//인기게시글로 이동
	@GetMapping("/image/explore")
	public String explore(Model model)throws Exception{
		List<PhotoVO> photo = service.likelist();//좋아요 개수 순서대로 리스트에 담음
		model.addAttribute("photo", photo);
		return "/image/explore";
	}
	
	// 로그인 성공
    @PostMapping("/login")
    public String loginSuccess() throws Exception {
    	
        return "redirect:/image/feed";
    }
    @GetMapping("/image/feed")
	public String feed(Model model, HttpSession session) {
    	UserVO user_id = (UserVO) session.getAttribute("login");//세션에 있는 유저정보를 변수에 저장
    	String userid = user_id.getUser_id();//변수에 저장한 유저정보에서 유저아이디를 변수에 저장.
    	
    	FollowVO us_id = new FollowVO();//FollowVO 객체 생성
    	us_id.setFollower_user(user_id.getUser_id());//생성한 객체에 유저아이디 저장
    	us_id.setFollow_user(user_id.getUser_id());//생성한 객체에 유저아이디 저장
    	List<FollowVO> list = service.followlist(user_id.getUser_id());//로그인한 유저가 팔로우한 유저리스트를 변수에 담음
    	log.info("list1 : "+list);
    	list.add(us_id);//팔로우한 유저를 담아놓은 리스트에 아까 생성한 객체를 추가.(자신이 올린 사진도 보기 위해)
    	log.info("list2 : "+list);
    	
    	List<PhotoVO> photo = service.mainlist(list);//팔로우한 유저의 게시물을 가져옴
    	int photocnt = service.mainlistcnt(list);//출력해야할 게시물의 개수를 가져옴
    	log.info("photo : "+photo);
    	
    	List<CommentVO> com = service.commentselect(photo);//팔로우한 유저 게시물의 댓글을 가져옴
    	log.info("com : "+com);
    	
    	List<LikeVO> likelist = service.likeselect(photo, userid);//팔로우한 유저 게시물에 좋아요한 리스트를 가져옴
    	log.info("likeList : "+likelist);
    	
    	List<LikeCntVO> likecntlist = new ArrayList<LikeCntVO>();//LikeVO리스트타입의 객체를 생성.
    	
    	//팔로우한 유저의 사진번호만큽 for문을 돌림.
    	for(int i=0; i<photo.size(); i++) {
    		LikeCntVO likecnt = new LikeCntVO();//게시물 별 유저의 좋아요 카운트 객체 생성.
    		int pno = photo.get(i).getPno();//photo리스트에 들어가있는 순서대로 사진번호를 변수에 담음.
    		likecnt.setPno(pno);//생성한 객체에 추출한 게시물 번호를 저장.
    		likecnt.setLikecnt(0);//생성한 객체에 카운트에 0으로 저장.
    		likecntlist.add(likecnt);//LikeCntVO리스트로 생성한 객체 안에 likecnt로 생성한 객체에 담긴 정보를 추가.
    	}
    	log.info("likecntlist : "+likecntlist);
    	
    	
    	
    	if(likelist.size()!=0) {//유저가 팔로우한 유저의 게시물에 좋아요가 있으면 실행
	    	for(int j=0; j<likecntlist.size(); j++) {//LikeCntVO리스트로 생성한 객체의 사이즈만큼 for문을 돌림.
	    		int lpno = likecntlist.get(j).getPno();//likecntlist의 게시물 번호를 순서대로 변수에 담음.
	    		for(int k=0; k<likelist.size();k++) {//likelist의 size만큼 for문을 돌림.
	    			int pno = likelist.get(k).getPno();//likelist의 게시물 번호를 순서대로 변수에 담음.
	    			log.info("pno : "+pno+" == lpno : "+lpno);
	    			if(pno==lpno) {//likecntlist의 게시물 번호와 likelist의 게시물 번호가 같으면 실행.
	    				LikeCntVO likecnt = new LikeCntVO();//게시물 별 유저의 좋아요 카운트 객체 생성.
	    				likecntlist.remove(j);//likecntlist의 리스트 인덱스 값이 j 인것을 remove.
	    				likecnt.setPno(pno);//생성한 객체에 추출한 게시물 번호를 저장.
	    	    		likecnt.setLikecnt(1);//생성한 객체에 카운트에 1로 저장.
	    	    		log.info("likecnt : "+likecnt);
	    	    		likecntlist.add(j,likecnt);//likecntlist리스트에서 인덱스j번째에 객체에 담은 정보를 추가.
	    			}
	    		}
	    	}
    	}
    	log.info("likecntlist2 : "+likecntlist);
    	model.addAttribute("photocnt",photocnt);//출력될 게시물 카운트를 담음
    	model.addAttribute("result", likecntlist);//유저가 좋아요를 했는지 카운트 되어있는 리스트 정보를 담음.
//    	model.addAttribute("likelist", likelist);
    	model.addAttribute("comment", com);//게시물에 관련된 댓글을 담음.
    	model.addAttribute("photo", photo);//출력될 게시물을 담음.
		return "/image/feed";
	}
    
   //댓글작성
    @RequestMapping(value = "/commnetwrite", method = RequestMethod.POST)
	@ResponseBody
	public void commentwrite(CommentVO vo) {
    	
    	service.commentwrite(vo);
    }
    
    //댓글 삭제
    @RequestMapping(value = "/commnetdelete", method = RequestMethod.POST)
	@ResponseBody
	public void commnetdelete(CommentVO vo) {
    	service.commentdelete(vo);
    }
    
    //좋아요
    @RequestMapping(value = "/likeupdate", method = RequestMethod.POST)
   	@ResponseBody
   	public void likeupdate(LikeVO lVo) {
       	service.likeupdate(lVo);//좋아요 테이블에 등록
       	int pno=lVo.getPno();
       	service.likecntupdate(pno);//누적된 좋아요수를 업데이트
    }
    
    //좋아요 취소
    @RequestMapping(value = "/likedelete", method = RequestMethod.POST)
   	@ResponseBody
   	public void likedelete(LikeVO lVo) {
       	service.likedelete(lVo);//좋아요 테이블에서 삭제
       	int pno=lVo.getPno();
       	service.likecntdelete(pno);//누적된 좋아요수를 업데이트
    }
	
	//개인 페이지 or 타인의 페이지로 이동하는 컨트롤러
	@GetMapping("/user/profile")
	public String profile(Model model, String user_id
			, @RequestParam(required = false, defaultValue = "0") String follow_user){
		model.addAttribute("userid", user_id);//파라미터로 온 유저아이디를 담음.
		int contentcnt = service.contentcnt(user_id);//유저의 게시물을 카운트해서 변수에 담음
		int followercnt = service.followercnt(user_id);//자신을 팔로우한 유저를 카운트해서 변수에 담음
		int followcnt = service.followcnt(user_id);//자신이 팔로우한 유저를 카운트해서 변수에 담음.
		UserVO user = service.selectuser(user_id);//파라미터로 받은 유저의 정보를 가져옴.
		List<FollowVO> followlist = service.followlist(user_id);//자신이 팔로우한 유저를 리스트에 담음.
		List<FollowVO> followerlist = service.followerlist(user_id);//자신을 팔로우한 유저를 리스트에 담음
		List<PhotoVO> photolist = service.selectphoto(user_id);//유저의 게시물을 리스트에 담음.
		if(follow_user!="0") {//다른사람의 프로필로 들어가면 실행.
			int count = service.followcheck(user_id, follow_user);//팔로우가 되어있는지 체크
			String result = Integer.toString(count);
			model.addAttribute("result", result);//팔로우가 되어있으면 1 되어있지 않으면 0을 담음.
			log.info("result : "+result);
		}
		log.info("cnt : "+contentcnt);
		model.addAttribute("content", contentcnt);//유저의 게시물을 카운트해서 담음.
		model.addAttribute("follower", followercnt);//자신을 팔로우한 유저를 카운트해서 담음.
		model.addAttribute("follow", followcnt);//자신이 팔로우한 유저를 카운트해서 담음.
		model.addAttribute("photolist", photolist);//유저의 게시물을 담음.
		model.addAttribute("user", user);//파라미터로 받은 유저의 정보를 담음.
		model.addAttribute("followlist", followlist);//자신이 팔로우한 유저를 담음.
		model.addAttribute("followerlist", followerlist);//자신을 팔로우한 유저를 담음.
		return"/user/profile";
	}
	
	//업로드 페이지로 이동
	@GetMapping("/image/upload")
	public String upload() {
		return "/image/upload";
	}
	//이미지 업로드
	@PostMapping("/uploadImage")
	public String uploadImage(PhotoVO pVo, MultipartFile file) throws IOException, Exception {
		String user_id=pVo.getPhoto_id();
		log.info("pVo : "+pVo);
		log.info("file : "+file);
		log.info("file : "+file.getOriginalFilename());
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		log.info("imgUploadPath : "+imgUploadPath);
		log.info("ymdPath : "+ymdPath);
		
		//파일이름이 비어있지 않으면 실행.
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		 fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		 log.info("filename2 : "+fileName);
		} else {//파일이름이 비어있으면 실행.
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		 log.info("filename2 : "+fileName);
		}
		log.info("filename : "+fileName);
		pVo.setPhotoUrl(File.separator + "imgUpload" + ymdPath + File.separator + fileName);//이미지 파일이름에 추가하고 pVo에 저장.
		pVo.setPhotothumb(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);//썸네일 파일이름에 추가하고 pVo에 저장.
		log.info("pVo : "+pVo);
		
		service.upload(pVo);//이름을 바꾼 이미지파일과 썸네일 파일을담아놓은 객체를 데이터베이스에 저장.
		
		return "redirect:/user/profile?user_id="+user_id;
	}
	//프로필 업로드
	@PostMapping("/profileupload")
	public String profileupload(UserVO uVo, MultipartFile file) throws IOException, Exception {
		String user_id=uVo.getUser_id();
		log.info("uVo : "+uVo);
		log.info("file : "+file);
		log.info("file : "+file.getOriginalFilename());
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		log.info("imgUploadPath : "+imgUploadPath);
		log.info("ymdPath : "+ymdPath);
		
		//파일이름이 비어있지 않으면 실행.
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		 fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		 log.info("filename2 : "+fileName);
		} else {//파일이름이 비어있으면 실행.
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		 log.info("filename2 : "+fileName);
		}
		log.info("filename : "+fileName);
		uVo.setUser_photoUrl(File.separator + "imgUpload" + ymdPath + File.separator + fileName);//이미지 파일이름에 추가하고 pVo에 저장.
		uVo.setUser_photothumb(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);//썸네일 파일이름에 추가하고 pVo에 저장.
		log.info("pVo : "+uVo);
		
		service.profileupload(uVo);//이름을 바꾼 이미지파일과 썸네일 파일을담아놓은 객체를 데이터베이스에 저장.
		String user_photourl = uVo.getUser_photoUrl();//파라미터로 받은 유저의 프로필 이미지를 변수에 저장.
		String user_photothumb = uVo.getUser_photothumb();//파라미터로 받은 유저의 프로필 썸네일을 변수에 저장.
		String userid = uVo.getUser_id();//파라미터로 받은 유저아이디를 변수에 저장.
		service.updateprofile(user_photourl, user_photothumb, userid);//위에서 변수에 저장한 정보를 photo테이블의 유저 이미지를 업데이트
		
		return "redirect:/user/profile?user_id="+user_id;
	}
	//팔로우하기ajax
	@RequestMapping(value = "/followUpdate", method = RequestMethod.POST)
	@ResponseBody
	public void followUpdate(FollowVO fVo)throws Exception {
		service.followupdate(fVo);
	}
	//팔로우 취소
	@RequestMapping(value = "/followDelete", method = RequestMethod.POST)
	@ResponseBody
	public void followDelete(FollowVO fVo)throws Exception {
		service.followDelete(fVo);
	}
	
    
	// LOGOUT	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}


}