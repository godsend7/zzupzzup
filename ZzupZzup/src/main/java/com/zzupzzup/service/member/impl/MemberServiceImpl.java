package com.zzupzzup.service.member.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberDAO;
import com.zzupzzup.service.member.MemberService;

@Service("memberServiceImpl")
public class MemberServiceImpl implements MemberService{

	//*Field
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDAO memberDao;
	
	//*Constructor
	public MemberServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	//*Method
	@Override
	public void addMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		memberDao.addMember(member);
	}

	@Override
	public void login(Member member) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void kakaoLogin(Member member) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void naverLogin(Member member) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void selectMemberRole() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkIdDuplication() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkNicknameDuplication() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void findId() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sendCertificatedNum() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkCertificatedNum() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMember() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void confirmPwd() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getMember() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getOtherUser() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void listMember() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void blacklistUser() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addActivityScore() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void calculateActivityScore() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addMannerScore() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void calculateMannerScore() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void logout() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
