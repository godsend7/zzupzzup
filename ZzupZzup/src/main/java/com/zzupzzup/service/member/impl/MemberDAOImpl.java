package com.zzupzzup.service.member.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberDAO;

@Repository("memberDaoImpl")
public class MemberDAOImpl implements MemberDAO{

	//*Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	//*Constructor
	public MemberDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	//*Method
	@Override
	public int addMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("MemberMapper.addMember", member);
		return 1;
	}

//	@Override
//	public void login() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

//	@Override
//	public void kakaoLogin() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public void naverLogin() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public Member getMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getMember", member);
	}
	
	@Override
	public Member getOwner(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getOwner", memberId);
		
	}

	@Override
	public List<Member> listUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Member> list = sqlSession.selectList("MemberMapper.listUser",map);
		
		return list;
	}
	
	@Override
	public List<Member> listOwner(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Member> list = sqlSession.selectList("MemberMapper.listOwner",map);
		
		return list;
	}

	@Override
	public int updateMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO - "+member);
		return sqlSession.update("MemberMapper.updateMember", member);
	}
	
	@Override
	public int addActivityScore(String memberId, int accumulType, int accumulScore) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("accumulType", accumulType);
		map.put("accumulScore", accumulScore);
		
		sqlSession.insert("MemberMapper.addActivityScore",map);
		
		return 1;
	}
	
	@Override
	public List<Member> listActivityScore(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Member> list = sqlSession.selectList("MemberMapper.listActivityScore",map);
		return list;
	}
	
	@Override
	public int updateActivityAllScore(String memberId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("MemberMapper.updateActivityAllScore", memberId);
		
		return 1;
	}
	
	@Override
	public int updateMannerScore(String memberId, int accumulScore) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("accumulScore", accumulScore);
		
		return sqlSession.update("MemberMapper.updateMannerScore", map);
	}
	
	@Override
	public int getUserTotalCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getUserTotalCount", map);
	}
	
	@Override
	public int getOwnerTotalCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getOwnerTotalCount", map);
	}
	
	@Override
	public int getMyRestaurantTotalCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getMyRestaurantTotalCount", map);
	}
	
	@Override
	public int getActivityScoreTotalCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getActivityScoreTotalCount", map);
	}

}
