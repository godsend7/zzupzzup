package com.zzupzzup.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.community.CommunityDAO;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {
	
	///Field
	@Autowired
	@Qualifier("communityDaoImpl")
	private CommunityDAO communityDAO;
	public void setcommunityDAO(CommunityDAO communityDAO) {
		this.communityDAO = communityDAO;
	}
	
	
	///Constructor
	public CommunityServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@Override
	public int addCommunity(Community community) throws Exception {
		return communityDAO.addCommunity(community);
	}

	@Override
	public int updateCommunity(Community community) throws Exception {
		return communityDAO.updateCommunity(community);
	}

	@Override
	public Community getCommunity(int postNo) throws Exception {
		return communityDAO.getCommunity(postNo);
	}
	
	@Override
	public Map<String, Object> listCommunity(Search search) throws Exception {
		List<Community> list = communityDAO.listCommunity(search);
		int totalCount = communityDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public int deleteCommunity(Community community) throws Exception {
		return communityDAO.deleteCommunity(community);
	}

	@Override
	public void addLike() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteLike() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Map<String, Object> listLike() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> listMyPost() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void officialCommunity() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	

}
