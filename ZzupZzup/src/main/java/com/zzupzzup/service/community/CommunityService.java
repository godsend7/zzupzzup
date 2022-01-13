package com.zzupzzup.service.community;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;

public interface CommunityService {
	
	public int addCommunity(Community community) throws Exception;
	
	public int updateCommunity(Community community) throws Exception;
	
	public Community getCommunity(int postNo) throws Exception;
	
	public Map<String, Object> listCommunity(Search search) throws Exception;
	
	public int deleteCommunity(int postNo) throws Exception;
	
	public int addLike(String memberId, int postNo) throws Exception;
	
	public int deleteLike(String memberId, int postNo) throws Exception;
	
	public List<Mark> listLike(String memberId) throws Exception;
	
	public Map<String, Object> listMyLikePost(Search search, Member member) throws Exception;
	
	public int officialCommunity(Community community) throws Exception;

}
