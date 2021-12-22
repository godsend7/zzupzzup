package com.zzupzzup.service.member;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;

public interface MemberService {
	
	public void login(Member member) throws Exception;
	
	public void kakaoLogin(Member member) throws Exception;
	
	public void naverLogin(Member member) throws Exception;
	
	//public void selectMemberRole() throws Exception;
	
	public void addMember(Member member) throws Exception;
	
	public boolean checkIdDuplication(String memberId) throws Exception;
	
	public boolean checkNicknameDuplication(String nickname) throws Exception;
	
	public void findId() throws Exception;
	
	public String sendCertificatedNum() throws Exception;
	
	public boolean checkCertificatedNum(String certificatedNum) throws Exception;
	
	public void updateMember(Member member) throws Exception;
	
	public boolean confirmPwd(String password) throws Exception;
	
	public Member getMember(Member member) throws Exception;
	
	public void getOtherUser() throws Exception;
	
	//public Member getOwner(String memberId) throws Exception;
	
	public Map<String, Object> listMember(Search search, Member member) throws Exception;
	
	//public void blacklistUser() throws Exception;
	
	public void addActivityScore(String memberId, int accumulType, int accumulScore) throws Exception;
	
	public Map<String, Object> listActivityScore(String memberId) throws Exception;
	
	public void calculateActivityScore() throws Exception;
	
	public void addMannerScore() throws Exception;
	
	public void calculateMannerScore(String memberId, int accumulScore) throws Exception;
	
	public void logout() throws Exception;

}
