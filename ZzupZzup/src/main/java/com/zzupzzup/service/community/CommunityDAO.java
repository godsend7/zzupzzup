package com.zzupzzup.service.community;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Community;

public interface CommunityDAO {
	
	public int addCommunity(Community community) throws Exception;
	
	public Community getCommunity(int postNo) throws Exception;
	
	public List<Community> listCommunity(Search search) throws Exception;
	
	public int updateCommunity(Community community) throws Exception;
	
	public int deleteCommunity(int postNo) throws Exception;
	
	public int addLike(Map<String, Object> map) throws Exception;
	
	public int deleteLike(Map<String, Object> map) throws Exception;
	
	public List<Community> listLike(Map<String, Object> map) throws Exception;
	
	public List<Community> listMyPost(Map<String, Object> map) throws Exception;
	
	public void officialCommunity() throws Exception;
	
	public int getLikeCount(int postNo) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
}
