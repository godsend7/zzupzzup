package com.zzupzzup.service.community;

import java.util.List;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Community;

public interface CommunityDAO {
	
	public int addCommunity(Community community) throws Exception;
	
	public Community getCommunity(int postNo) throws Exception;
	
	public List<Community> listCommunity(Search search) throws Exception;
	
	public int updateCommunity(Community community) throws Exception;
	
	public int deleteCommunity(Community community) throws Exception;
	
	public void addLike() throws Exception;
	
	public void deleteLike() throws Exception;
	
	public List<Community> listLike(Search search) throws Exception;
	
	public List<Community> listMyPost(Search search) throws Exception;
	
	public void officialCommunity() throws Exception;
	
	public void getLikeCount() throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
}
