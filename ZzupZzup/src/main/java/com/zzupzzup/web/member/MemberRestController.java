package com.zzupzzup.web.member;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberService;


@RestController
@RequestMapping("/member/*")
public class MemberRestController {
	
	//*Field
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	//*Constructor
	public MemberRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	//*Method
//	public void login() {
//		
//	}
	
	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public Member login(@RequestBody Member member, HttpSession session) throws Exception{
		
		System.out.println("/member/json/login : POST");
		System.out.println("::"+member.getMemberId()+", "+member.getPassword());
		//Business Logic
		member.setMemberId(member.getMemberId());
		Member mb = memberService.getMember(member);
		
		if( mb.getPassword().equals(member.getPassword())){
			session.setAttribute("member", member);
			System.out.println(member.getMemberId()+" 님 로그인");
		}
		
		return member;
	}
	
	public void selectMemberRole() {
		
	}
	
	public void kakaoLogin() {
		
	}
	
	public void naverLogin() {
		
	}
	
	public void checkIdDuplication() {
		
	}

	public void checkNicknameDuplication() {
		
	}
	
	public void findId() {
		
	}
	
	@RequestMapping(value="json/sendCertificatedNum", method=RequestMethod.GET)
	public String sendCertificatedNum(String phoneNum) throws Exception {
		
		String certificatedNum = "";
		
	    for(int i = 1; i <= 6; i++) {
	    	Random random = new Random();
	    	certificatedNum += random.nextInt(10);
	    }

	    memberService.sendCertificatedNum(certificatedNum, phoneNum);
	    
	    String inputCertificatedNum = null;
	    String inputPhoneNum = null;
	    memberService.checkCertificatedNum(inputCertificatedNum, certificatedNum, inputPhoneNum, phoneNum);
	    
	    return "";
	}
	
//	@RequestMapping(value="json/checkCertificatedNum", method=RequestMethod.POST)
//	public void checkCertificatedNum(String inputCertificatedNum, String certificatedNum, String inputPhoneNum, String phoneNum) throws Exception {
//		
//		memberService.checkCertificatedNum(inputCertificatedNum, certificatedNum, inputPhoneNum, phoneNum);
//		
//	}
	
	public void getOtherUser() {
		
	}

}
