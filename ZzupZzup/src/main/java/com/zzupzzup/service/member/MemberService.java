package com.zzupzzup.service.member;

import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;

public interface MemberService {
	
//	public void login(Member member) throws Exception;
	
	public void kakaoLogin() throws Exception;
	
	public void naverLogin() throws Exception;
	
	//public void selectMemberRole() throws Exception;
	
	public int addMember(Member member) throws Exception;
	
	public boolean checkIdDuplication(String memberId) throws Exception;
	
	public boolean checkNicknameDuplication(String nickname) throws Exception;
	
//	public void findId() throws Exception;
	
	public int sendCertificatedNum(String certificatedNum, String phoneNum) throws Exception;
	
	public boolean checkCertificatedNum(String inputCertificatedNum, String certificatedNum, String inputPhoneNum, String phoneNum) throws Exception;
	
	public int updateMember(Member member) throws Exception;
	
	public boolean confirmPwd(String password) throws Exception;
	
	public Member getMember(Member member) throws Exception;
	
	public void getOtherUser() throws Exception;
	
	//public Member getOwner(String memberId) throws Exception;
	
	public Map<String, Object> listMember(Search search, Member member) throws Exception;
	
	//public void blacklistUser() throws Exception;
	
	public int addActivityScore(String memberId, int accumulType, int accumulScore) throws Exception;
	
	public Map<String, Object> listActivityScore(String memberId) throws Exception;
	
	public int calculateActivityScore(String memberId) throws Exception;
	
	//public int addMannerScore() throws Exception;
	
	public int calculateMannerScore(String memberId, int accumulScore) throws Exception;
	
//	public void logout() throws Exception;

}
