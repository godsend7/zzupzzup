package com.zzupzzup.service.member;

import com.zzupzzup.service.domain.Member;

public interface MemberService {
	
	public void login(Member member) throws Exception;
	
	public void kakaoLogin(Member member) throws Exception;
	
	public void naverLogin(Member member) throws Exception;
	
	public void selectMemberRole() throws Exception;
	
	public void addMember(Member member) throws Exception;
	
	public void checkIdDuplication() throws Exception;
	
	public void checkNicknameDuplication() throws Exception;
	
	public void findId() throws Exception;
	
	public void sendCertificatedNum() throws Exception;
	
	public void checkCertificatedNum() throws Exception;
	
	public void updateMember() throws Exception;
	
	public void confirmPwd() throws Exception;
	
	public void getMember() throws Exception;
	
	public void getOtherUser() throws Exception;
	
	public void listMember() throws Exception;
	
	public void blacklistUser() throws Exception;
	
	public void addActivityScore() throws Exception;
	
	public void calculateActivityScore() throws Exception;
	
	public void addMannerScore() throws Exception;
	
	public void calculateMannerScore() throws Exception;
	
	public void logout() throws Exception;

}
