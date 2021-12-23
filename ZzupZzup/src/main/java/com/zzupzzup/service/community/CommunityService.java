package com.zzupzzup.service.community;

import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Community;

public interface CommunityService {
	
	public int addCommunity(Community community) throws Exception;
	
	public int updateCommunity(Community community) throws Exception;
	
	public Community getCommunity(int postNo) throws Exception;
	
	public Map<String, Object> listCommunity(Search search) throws Exception;
	
	public int deleteCommunity(int postNo) throws Exception;
	
	public int addLike(String memberId, int postNo) throws Exception;
	
	public int deleteLike(String memberId, int postNo) throws Exception;
	
	public Map<String, Object> listLike(Search search, String memberId) throws Exception;
	
	public Map<String, Object> listMyPost(Search search, String memberId) throws Exception;
	
	public void officialCommunity() throws Exception;

}
