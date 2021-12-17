package com.zzupzzup.service.member.impl;

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
	public void getMember() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void listMember(Search search) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMember() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
