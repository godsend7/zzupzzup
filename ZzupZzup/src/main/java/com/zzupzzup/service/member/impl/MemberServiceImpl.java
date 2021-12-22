package com.zzupzzup.service.member.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
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

//	@Override
//	public void selectMemberRole() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public boolean checkIdDuplication(String memberId) throws Exception {
		// TODO Auto-generated method stub
		boolean checkId = true;
		Member member = new Member(memberId, null);
		memberDao.getMember(member);
		if (member.getMemberId() == memberId) {
			checkId = false;
		}
		
		return checkId;
	}

	@Override
	public boolean checkNicknameDuplication(String nickname) throws Exception {
		// TODO Auto-generated method stub
		boolean checkNickname = true;
		Member member = new Member(null, nickname);
		memberDao.getMember(member);
		if (member.getNickname() == nickname) {
			checkNickname = false;
		}
		
		return checkNickname;
	}

	@Override
	public void findId() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String sendCertificatedNum() throws Exception {
		// TODO Auto-generated method stub
		String certificatedNum = null;
		return certificatedNum;
	}

	@Override
	public boolean checkCertificatedNum(String certificatedNum) throws Exception {
		// TODO Auto-generated method stub
		if(certificatedNum == sendCertificatedNum()) {
			return true;
		}
		return false;
	}

	@Override
	public void updateMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		memberDao.updateMember(member);
	}

	@Override
	public boolean confirmPwd(String password) throws Exception {
		// TODO Auto-generated method stub
		boolean checkPWD = false;
		String inputPWD = null;
		if(password == inputPWD) {
			checkPWD = true;
		}
		
		return checkPWD;
	}
	
	@Override
	public Member getMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.getMember(member);
	}

	@Override
	public void getOtherUser() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
//	@Override
//	public Member getOwner(String memberId) throws Exception {
//		// TODO Auto-generated method stub
//		return memberDao.getOwner(memberId);
//	}

	@Override
	public Map<String, Object> listMember(Search search, Member member) throws Exception {
		// TODO Auto-generated method stub	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("member", member);
		map.put("listMember", memberDao.listMember(map));
		
		return map;
	}
	
//	@Override
//	public void blacklistUser() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public void addActivityScore(String memberId, int accumulType, int accumulScore) throws Exception {
		// TODO Auto-generated method stub
		memberDao.addActivityScore(memberId, accumulType, accumulScore);
	}
	
	@Override
	public Map<String, Object> listActivityScore(String memberId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listMyActivityScore", memberDao.listActivityScore(memberId));
		return map;
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
	public void calculateMannerScore(String memberId, int accumulScore) throws Exception {
		// TODO Auto-generated method stub
		memberDao.updateMannerScore(memberId, accumulScore);
	}

	@Override
	public void logout() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
