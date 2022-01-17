package com.zzupzzup.service.community;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.Mark;

public interface CommunityDAO {
	
	public int addCommunity(Community community) throws Exception;
	
	public Community getCommunity(int postNo) throws Exception;
	
	public List<Community> listCommunity(Search search) throws Exception;
	
	public List<Community> listMyPost(Search search) throws Exception;
	
	public int updateCommunity(Community community) throws Exception;
	
	public int deleteCommunity(int postNo) throws Exception;
	
	public int addLike(Map<String, Object> map) throws Exception;
	
	public int deleteLike(Map<String, Object> map) throws Exception;
	
	public List<Mark> listLike(String memberId) throws Exception;
	
	public List<Community> listMyLikePost(Map<String, Object> map) throws Exception;
	
	public int officialCommunity(Community community) throws Exception;
	
	public int getLikeCount(int postNo) throws Exception;
	
	public int getLikeTotalCount(String memberId) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
}
