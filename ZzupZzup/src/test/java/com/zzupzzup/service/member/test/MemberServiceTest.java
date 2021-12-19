package com.zzupzzup.service.member.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class MemberServiceTest {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;

	//@Test
	public void testAddMember() throws Exception {
		
		Member member = new Member();
		///*
		//유저(일반)
		member.setMemberId("test@test.com");
		member.setMemberRole("user");
		member.setPassword("testPasswd");
		member.setMemberName("abc");
		member.setMemberPhone("111-2222-3333");
		member.setLoginType(1);
		member.setAgeRange("10대");
		member.setGender("female");
		member.setProfileImage("test.png");
		member.setNickname("test");
		member.setStatusMessage("let me go home");
		//*/
		/*
		//유저(카카오)
		member.setMemberId("test2@test.com");
		member.setMemberRole("user");
		//member.setPassword("testPasswd");
		member.setMemberName("ghi");
		member.setMemberPhone("111-2222-3333");
		member.setLoginType(2);
		member.setAgeRange("10대");
		member.setGender("female");
		member.setProfileImage("test.png");
		member.setNickname("test");
		member.setStatusMessage("let me go home"); 
		*/
		/*
		//유저(네이버)
		member.setMemberId("test3@test.com");
		member.setMemberRole("user");
		//member.setPassword("testPasswd");
		member.setMemberName("jkl");
		member.setMemberPhone("111-2222-3333");
		member.setLoginType(3);
		member.setAgeRange("10대");
		member.setGender("female");
		member.setProfileImage("test.png");
		member.setNickname("test");
		member.setStatusMessage("let me go home");
		*/
		/*
		//업주
		member.setMemberId("testest@test.com");
		member.setMemberRole("owner");
		member.setPassword("testPasswd");
		member.setMemberName("def");
		member.setMemberPhone("111-2222-3333");
		member.setLoginType(1);
		member.setProfileImage("test.png");
		*/
		memberService.addMember(member);

		//System.out.println(member);
	}
	
	@Test
	public void testGetMember() throws Exception {
		
		Member member = memberService.getMember("test@test.com");
		//Member member = memberService.getMember("testest@test.com");
		//System.out.println(member);
	}
	
	//@Test
	public void testListMember() throws Exception {
		
		//Member member = memberService.listMember(null);
		//System.out.println(member);
	}
	
	//@Test
	public void testUpdateMember() throws Exception {
		
		//Member member = memberService.listMember(null);
		//System.out.println(member);
	}
}