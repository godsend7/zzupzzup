package com.zzupzzup.web.member;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.member.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	//*Field
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;

	//*Constructor
	public MemberController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	//*Method
//	@RequestMapping( value="login", method=RequestMethod.GET )
//	public String login() throws Exception{
//		
//		System.out.println("/member/login : GET");
//
//		return "redirect:/member/loginView.jsp";
//	}
	
//	@RequestMapping( value="login", method=RequestMethod.POST )
//	public String login(@ModelAttribute("member") Member member , HttpSession session) throws Exception{
//		
//		System.out.println("/member/login : POST");
//		//Business Logic
//		Member mb = new Member();
//		mb.setMemberId(member.getMemberId());
//		memberService.getMember(mb);
//		
//		if( member.getPassword().equals(mb.getPassword())){
//			session.setAttribute("mb", mb);
//		}
//		
//		return "redirect:/main.jsp";
//	}
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session) {
		
		System.out.println("/member/logout : GET");
		
		session.invalidate();
		
		return "redirect:/";
		
	}
	
	@RequestMapping(value="addMember/{memberRole}/{loginType}", method=RequestMethod.GET)
	public String addMember(@PathVariable String memberRole, @PathVariable String loginType) throws Exception {
		
		System.out.println("/member/addMember/"+memberRole+"/"+loginType+" : GET");
		
		return "redirect:/member/addMemberView.jsp?memberRole="+memberRole+"&loginType="+loginType;
//		return "redirect:/member/addMember/"+memberRole+"/"+loginType;
		
	}
	
	@RequestMapping(value="addMember/{memberRole}/{loginType}", method=RequestMethod.POST)
	public String addMember(@PathVariable String memberRole, @PathVariable int loginType,
				@ModelAttribute("member") Member member, HttpServletRequest request,
				@RequestParam(value="file", required = false) MultipartFile uploadfile) throws Exception {
		
		System.out.println("/member/addMember/"+memberRole+"/"+loginType+" : POST");
		
		
		String temp = request.getServletContext().getRealPath("/resources/images/uploadImages");
		String profileImage = uploadFile(uploadfile, temp);
		
		member.setMemberRole(memberRole);
		System.out.println("saved memberRole :: "+member.getMemberRole());
		member.setProfileImage(profileImage);
		member.setLoginType(loginType);
		memberService.addMember(member);
		
		Member pushMem = new Member();
		pushMem.setNickname(member.getPushNickname());
		Member push = memberService.getMember(pushMem);
		
		if(push != null) {
			//활동점수 추가하기
			memberService.addActivityScore(push.getNickname(), 1, 10);
		}
		
		if(member.getMemberRole().equals("owner")) {
			//member domain과 같이 음식점 등록으로 페이지 넘기기
			request.setAttribute("addOwner", member);
			System.out.println("왜 안 넘어가?");
			return "forward:/restaurant/addRestaurant";
		} else {
			System.out.println("업주 회원이 왜 자꾸 여길 와");
			return "redirect:/";
		}
		
	}
	
	public void getUser() {
		
	}
	
	public void getOwner() {
		
	}

	public void listUser() {
		
	}
	
	public void listOwner() {
		
	}
	
	public void blacklistUser() {
		
	}
	
	public void updateUser() {
		
	}
	
	public void updateOwner() {
		
	}
	
	public void calculateActivityScore() {
		
	}
	
	public void calculateMannerScore() {
		
	}
	
	private String uploadFile(MultipartFile uploadfile, String temp) {
		System.out.println(":: uploadfile.getOriginalFilename() => " + uploadfile.getOriginalFilename());
		System.out.println(":: uploadfile.getSize() => " + uploadfile.getSize());
			
		String saveName = uploadfile.getOriginalFilename();
		
		System.out.println(":: saveName => " + saveName);
		
		Path copy = Paths.get(temp, File.separator + StringUtils.cleanPath(saveName));
		
		try {
			Files.copy(uploadfile.getInputStream(), copy, StandardCopyOption.REPLACE_EXISTING);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			saveName = "defaultImage.png";
		}
		
		return saveName;
	}

}
