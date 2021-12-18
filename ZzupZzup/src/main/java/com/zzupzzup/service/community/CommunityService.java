package com.zzupzzup.service.community;

import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Community;

public interface CommunityService {
	
	public int addCommunity(Community community) throws Exception;
	
	public int updateCommunity(Community community) throws Exception;
	
	public Community getCommunity(int postNo) throws Exception;
	
	public Map<String, Object> listCommunity(Search search) throws Exception;
	
	public int deleteCommunity(Community community) throws Exception;
	
	public void addLike() throws Exception;
	
	public void deleteLike() throws Exception;
	
	public Map<String, Object> listLike() throws Exception;
	
	public Map<String, Object> listMyPost() throws Exception;
	
	public void officialCommunity() throws Exception;

}
