package com.zzupzzup.service.member.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberDAO;

@Repository("memberDaoImpl")
public class MemberDAOImpl implements MemberDAO{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public MemberDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("MemberMapper.addMember", member);
	}

}
