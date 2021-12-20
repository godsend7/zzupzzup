package com.zzupzzup.service.member.impl;

import java.util.List;

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
	public Member getUser(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getUser", memberId);
	}
	
	@Override
	public Member getOwner(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getOwner", memberId);
		
	}

	@Override
	public List<Member> listMember(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Member> list = sqlSession.selectList("MemberMapper.listMember",search);
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setReportCount(sqlSession.selectOne("MemberMapper.getReportCount", search));
		}
		
		return list;
	}

	@Override
	public void updateMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("MemberMapper.updateMember", member);
	}
	
	@Override
	public int getReportCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getReportCount",search);
	}
	
	@Override
	public int getRegRestaurantCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("MemberMapper.getRegRestaurantCount",search);
	}

}
