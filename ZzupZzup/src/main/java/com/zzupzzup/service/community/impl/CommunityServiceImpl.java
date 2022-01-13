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
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;

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
	public int deleteCommunity(int postNo) throws Exception {
		return communityDAO.deleteCommunity(postNo);
	}

	@Override
	public int officialCommunity(Community community) throws Exception {
		return communityDAO.officialCommunity(community);		
	}


	@Override
	public int addLike(String memberId, int postNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("postNo", postNo);
		
		return communityDAO.addLike(map);
	}


	@Override
	public int deleteLike(String memberId, int postNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("postNo", postNo);
		
		return communityDAO.deleteLike(map);
	}


	@Override
	public List<Mark> listLike(String memberId) throws Exception {
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("search", search);
//		map.put("memberId", memberId);
//		
//		map.put("list", communityDAO.listLike(map));
//		map.put("totalCount", communityDAO.getTotalCount(search));
		
		return communityDAO.listLike(memberId);
	}


	@Override
	public Map<String, Object> listMyLikePost(Search search, Member member) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("member", member);
		
		map.put("list", communityDAO.listMyLikePost(map));
		map.put("totalCount", communityDAO.getLikeTotalCount(member.getMemberId()));
		
		return map;
	}
	
	
}
