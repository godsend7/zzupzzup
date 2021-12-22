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
	public void addMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("MemberMapper.addMember", member);
	}

	@Override
	public void login() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void kakaoLogin() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void naverLogin() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public Member getMember(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getMember", memberId);
	}
	
	@Override
	public Member getOwner(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getOwner", memberId);
		
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Member> list = sqlSession.selectList("MemberMapper.listMember",map);
		
		return list;
	}

	@Override
	public void updateMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("MemberMapper.updateMember", member);
	}
	
//	@Override
//	public int getReportCount(String memberId) throws Exception {
//		// TODO Auto-generated method stub
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("memberId", memberId);
//		return sqlSession.selectOne("MemberMapper.getReportCount",map);
//	}
//	
//	@Override
//	public int getRegRestaurantCount(String memberId) throws Exception {
//		// TODO Auto-generated method stub
//		return sqlSession.selectOne("MemberMapper.getRegRestaurantCount",memberId);
//	}

}
