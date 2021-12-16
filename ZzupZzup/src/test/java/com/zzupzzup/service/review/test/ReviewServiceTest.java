package com.zzupzzup.service.review.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.review.ReviewService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class ReviewServiceTest {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;

	@Test
	public void testAddReview() throws Exception {
	
	}
}