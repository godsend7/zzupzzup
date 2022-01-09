package com.zzupzzup.service.member;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;

public interface MemberDAO {

	public int addMember(Member member) throws Exception;
	
	//public void login() throws Exception;
	
	public void kakaoLogin() throws Exception;
	
	public void naverLogin() throws Exception;
	
	public Member getMember(Member member) throws Exception;
	
	public Member getOwner(String memberId) throws Exception;
	
	public List<Member> listUser(Map<String, Object> map) throws Exception;
	
	public List<Member> listOwner(Map<String, Object> map) throws Exception;
	
	public int updateMember(Member member) throws Exception;
	
	public int addActivityScore(String memberId, int accumulType, int accumulScore) throws Exception;
	
	public List<Member> listActivityScore(Map<String, Object> map) throws Exception;
	
	public int updateActivityAllScore(String memberId) throws Exception;
	
	public int updateMannerScore(String memberId, int accumulScore) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
}
