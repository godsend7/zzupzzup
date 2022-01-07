package com.zzupzzup.service.member.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberDAO;
import com.zzupzzup.service.member.MemberService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

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
	public int addMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		memberDao.addMember(member);
		
		return 1;
	}

//	@Override
//	public void login(Member member) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public void kakaoLogin() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void naverLogin() throws Exception {
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
		
		Member member = new Member(memberId, null);
		memberDao.getMember(member);
		if (memberDao.getMember(member) != null) {
			return false;
		}
		
		return true;
	}

	@Override
	public boolean checkNicknameDuplication(String nickname) throws Exception {
		// TODO Auto-generated method stub
		
		Member member = new Member(null, nickname);
		memberDao.getMember(member);
		if (memberDao.getMember(member) != null) {
			return false;
		}
		
		return true;
	}

//	@Override
//	public void findId() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public int sendCertificatedNum(String certificatedNum, String phoneNum) throws Exception {
		// TODO Auto-generated method stub
		String api_key = "NCSW3I0BU5B18BUD";
        String api_secret = "N0PWJKYZWLLV6TZKQYYF57HL0XZ9NKLQ";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phoneNum);
	    params.put("from", "01030235823");
	    params.put("type", "SMS");
	    params.put("text", "[쩝쩝듀스101] 인증번호 ["+certificatedNum+"]를 입력해주세요.");
	    params.put("app_version", "test app 1.2"); // application name and version

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
        
        return 1;
	}

//	@Override
//	public boolean checkCertificatedNum(String inputCertificatedNum, String certificatedNum) throws Exception {
//		// TODO Auto-generated method stub
//	
//		if(inputCertificatedNum == certificatedNum) {
//			return true;
//		}
//		
//		return false;
//	}

	@Override
	public int updateMember(Member member) throws Exception {
		// TODO Auto-generated method stub
		
		
		return memberDao.updateMember(member);
	}

//	@Override
//	public boolean confirmPwd(String password) throws Exception {
//		// TODO Auto-generated method stub
//		boolean checkPWD = false;
//		String inputPWD = null;
//		if(password == inputPWD) {
//			checkPWD = true;
//		}
//		
//		return checkPWD;
//	}
	
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
	public Map<String, Object> listUser(Search search) throws Exception {
		// TODO Auto-generated method stub	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		map.put("listUser", memberDao.listUser(search));
		map.put("totalCount", memberDao.getTotalCount(search));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listOwner(Search search) throws Exception {
		// TODO Auto-generated method stub	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		map.put("listOwner", memberDao.listOwner(search));
		map.put("totalCount", memberDao.getTotalCount(search));
		
		return map;
	}
	
//	@Override
//	public void blacklistUser() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public int addActivityScore(String nickname, int accumulType, int accumulScore) throws Exception {
		// TODO Auto-generated method stub
		memberDao.addActivityScore(nickname, accumulType, accumulScore);
		
		return 1;
	}
	
	@Override
	public Map<String, Object> listActivityScore(String memberId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listMyActivityScore", memberDao.listActivityScore(memberId));
		return map;
	}

	@Override
	public int calculateActivityScore(String memberId) throws Exception {
		// TODO Auto-generated method stub
		memberDao.updateActivityAllScore(memberId);
		
		return 1;
	}

//	@Override
//	public void addMannerScore() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public int calculateMannerScore(String memberId, int accumulScore) throws Exception {
		// TODO Auto-generated method stub
		memberDao.updateMannerScore(memberId, accumulScore);
		
		return 1;
	}

//	@Override
//	public void logout() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

}
