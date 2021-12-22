package com.zzupzzup.service.member;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;

public interface MemberDAO {

	public void addMember(Member member) throws Exception;
	
	//public void login() throws Exception;
	
	public void kakaoLogin() throws Exception;
	
	public void naverLogin() throws Exception;
	
	public Member getMember(Member member) throws Exception;
	
	public Member getOwner(String memberId) throws Exception;
	
	public List<Member> listMember(Map<String, Object> map) throws Exception;
	
	public void updateMember(Member member) throws Exception;
	
	public void addActivityScore(String memberId, int accumulType, int accumulScore) throws Exception;
	
	public List<Member> listActivityScore(String memberId) throws Exception;
	
	public void updateActivityAllScore(String memberId) throws Exception;
	
	public void updateMannerScore(String memberId, int accumulScore) throws Exception;
}
