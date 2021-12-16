package com.zzupzzup.service.member.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberDAO;
import com.zzupzzup.service.member.MemberService;

@Service("memberServiceImpl")
public class MemberServiceImpl implements MemberService{

	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDAO memberDao;
	
	public MemberServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		memberDao.addMember(member);
	}
}
