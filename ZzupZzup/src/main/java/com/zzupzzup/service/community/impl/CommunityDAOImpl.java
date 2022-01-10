package com.zzupzzup.service.community.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.community.CommunityDAO;
import com.zzupzzup.service.domain.Community;

@Repository("communityDaoImpl")
public class CommunityDAOImpl implements CommunityDAO {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	///Constructor
	public CommunityDAOImpl() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@Override
	public int addCommunity(Community community) throws Exception {
		int result = sqlSession.insert("CommunityMapper.addCommunity", community);
		
		if(result == 1) {
			if(community.getRestaurantTimes() != null) {
				sqlSession.insert("CommunityMapper.addRestaurantTime", community);
			}
			
			if(community.getPostImage() != null) {
				sqlSession.insert("CommunityMapper.addImage", community);
			}
				
				
			/*
			 * sqlSession.insert("CommunityMapper.addRestaurantTime", community);
			 * sqlSession.insert("CommunityMapper.addImage", community);
			 */
			
			return 1;
			
		} else {
			return 0;
		}
		
	}


	@Override
	public Community getCommunity(int postNo) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getCommunity", postNo);
	}
	
	
	@Override
	public List<Community> listCommunity(Search search) throws Exception {
		return sqlSession.selectList("CommunityMapper.listCommunity", search);
	}


	@Override
	public int updateCommunity(Community community) throws Exception {
		int result = sqlSession.update("CommunityMapper.updateCommunity", community);
		
		if(result == 1) {
			if(community.getRestaurantTimes() != null) {
				sqlSession.insert("CommunityMapper.addRestaurantTime", community);
			}
			
			if(community.getPostImage() != null) {
				sqlSession.insert("CommunityMapper.addImage", community);
			}
			
			return 1;
			
		} else {
			return 0;
		}
		
	}

	
	@Override
	public int officialCommunity(Community community) throws Exception {
		return sqlSession.update("CommunityMapper.officialCommunity", community);
	}


	@Override
	public int getLikeCount(int postNo) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getLikeCount", postNo);
	}


	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getTotalCount", search);
	}


	@Override
	public int deleteCommunity(int postNo) throws Exception {
		return sqlSession.delete("CommunityMapper.deleteCommunity", postNo);
	}


	@Override
	public int addLike(Map<String, Object> map) throws Exception {
		return sqlSession.insert("CommunityMapper.addLike", map);
	}


	@Override
	public int deleteLike(Map<String, Object> map) throws Exception {
		return sqlSession.delete("CommunityMapper.deleteLike", map);
	}


	@Override
	public List<Community> listLike(Map<String, Object> map) throws Exception {
		
		List<Community> list = sqlSession.selectList("CommunityMapper.listLike", map);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setLikeCount(getLikeCount(list.get(i).getPostNo()));
		}
		
		return list;
	}


	@Override
	public List<Community> listMyPost(Map<String, Object> map) throws Exception {
		
		List<Community> list = sqlSession.selectList("CommunityMapper.listMyPost", map);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setLikeCount(getLikeCount(list.get(i).getPostNo()));
		}
		
		return list;
	}
	
}
