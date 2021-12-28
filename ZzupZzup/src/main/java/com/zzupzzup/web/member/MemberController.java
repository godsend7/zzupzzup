package com.zzupzzup.web.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zzupzzup.service.domain.Member;
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
		
		return "redirect:/main.jsp";
		
	}
	
	@RequestMapping(value="addMember/{memberRole}", method=RequestMethod.GET)
	public String addMember(@PathVariable String memberRole) throws Exception {
		
		System.out.println("/member/addMember/"+memberRole+" : GET");
		
		return "redirect:/member/addMemberView.jsp?memberRole="+memberRole;
		
	}
	
	@RequestMapping(value="addMember", method=RequestMethod.POST)
	public String addMember(@ModelAttribute("member") Member member) throws Exception {
		
		System.out.println("/member/addMember : POST");
		
		memberService.addMember(member);
		System.out.println(member.getMemberRole());
		if(member.getPushNickname() != null) {
			//활동점수 추가하기
			
		}
		if(member.getMemberRole() == "owner") {
			//member domain과 같이 음식점 등록으로 페이지 넘기기
			
		}
		
		return "redirect:/main.jsp";
		
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

}
