package com.zzupzzup.web.member;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

		Member mb = memberService.getMember(member);
		

		if( mb.getPassword().equals(member.getPassword())){
			session.setAttribute("member", mb);
			System.out.println(mb.getMemberId()+" 님 로그인");
			
			return mb;
			
		} else {
			
			return null;
		}
	}
	
	public void selectMemberRole() {
		
	}
	
	public void kakaoLogin() {
		
	}
	
	public void naverLogin() {
		
	}
	
	@RequestMapping(value="json/checkIdDuplication", method=RequestMethod.POST)
	public boolean checkIdDuplication(@RequestParam("memberId") String memberId) throws Exception {
		
		System.out.println("/member/json/checkIdDuplication : POST");
		
		return memberService.checkIdDuplication(memberId);
	}

	@RequestMapping(value="json/checkNicknameDuplication", method=RequestMethod.POST)
	public boolean checkNicknameDuplication(@RequestParam("nickname") String nickname) throws Exception {
		
		System.out.println("/member/json/checkNicknameDuplication : POST");
		
		return memberService.checkNicknameDuplication(nickname);
	}
	
	public void findId() {
		
	}
	
	@RequestMapping(value="json/sendCertificatedNum", method=RequestMethod.GET)
	public String sendCertificatedNum(String phoneNum) throws Exception {
		
		System.out.println("/member/json/sendCertificatedNum : GET");
		
		String certificatedNum = "";
		
	    for(int i = 1; i <= 6; i++) {
	    	Random random = new Random();
	    	certificatedNum += random.nextInt(10);
	    }

	    memberService.sendCertificatedNum(certificatedNum, phoneNum);
	    
//	    String inputCertificatedNum = null;
//	    String inputPhoneNum = null;
//	    memberService.checkCertificatedNum(inputCertificatedNum, certificatedNum, inputPhoneNum, phoneNum);
	    
	    return certificatedNum;
	}
	
//	@RequestMapping(value="json/checkCertificatedNum", method=RequestMethod.POST)
//	public void checkCertificatedNum(String inputCertificatedNum, String certificatedNum) throws Exception {
//		
//		System.out.println("/member/json/checkCertificatedNum : POST");
//		
//		memberService.checkCertificatedNum(inputCertificatedNum, certificatedNum);
//		
//	}
	
	public void getOtherUser() {
		
	}

}
