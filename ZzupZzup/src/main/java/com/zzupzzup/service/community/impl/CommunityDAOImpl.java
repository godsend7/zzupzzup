package com.zzupzzup.service.community.impl;

import java.util.List;

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
	/*
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	*/
	
	///Constructor
	public CommunityDAOImpl() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@Override
	public int addCommunity(Community community) throws Exception {
		return sqlSession.insert("CommunityMapper.addCommunity", community);
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
		return sqlSession.update("CommunityMapper.updateCommunity", community);
	}


	@Override
	public int deleteCommunity(Community community) throws Exception {
		// TODO Auto-generated method stub
		return 0;
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
	public List<Community> listLike(Search search) throws Exception {
		return null;
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<Community> listMyPost(Search search) throws Exception {
		return null;
		// TODO Auto-generated method stub
		
	}


	@Override
	public void officialCommunity() throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void getLikeCount() throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
