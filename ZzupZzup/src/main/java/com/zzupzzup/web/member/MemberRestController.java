package com.zzupzzup.web.member;

import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.service.member.MemberService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

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
	}

	public void login() {
		
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

	    memberService.sendCertificatedNum(phoneNum, certificatedNum);
	    
	    return certificatedNum;
	}
	
	public void checkCertificatedNum() {
		
	}
	
	public void getOtherUser() {
		
	}

}
