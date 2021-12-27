package com.zzupzzup.web.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("member") Member member , HttpSession session) throws Exception{
		
		System.out.println("/member/login : POST");
		//Business Logic
		Member mb = new Member();
		mb.setMemberId(member.getMemberId());
		memberService.getMember(mb);
		
		if( member.getPassword().equals(mb.getPassword())){
			session.setAttribute("mb", mb);
		}
		
		return "redirect:/main.jsp";
	}
	
	public void logout() {
		
	}
	
	public void addMember() {
		
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
