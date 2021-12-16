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

	@Test
	public void testAddUser() throws Exception {
		
		Member member = new Member();
		member.setMemberId("test@test.com");
		member.setMemberName("ddd");
		member.setPassword("testPasswd");
		member.setMemberPhone("111-2222-3333");
		
		memberService.addMember(member);

		//System.out.println(user);
	}
}