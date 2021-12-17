package com.zzupzzup.service.review.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.review.ReviewService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })

public class ReviewServiceTest {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;

	@Test
	public void testAddReview() throws Exception {
		Review review = new Review();
		Member member = new Member();
		Reservation reservation = new Reservation();
		
		List<Integer> hashTag = new ArrayList<Integer>();
		List<String> reviewImage = new ArrayList<String>();
		
		hashTag.add(1);
		hashTag.add(2);
		hashTag.add(3);
		
		reviewImage.add("a.jpg");
		reviewImage.add("b.jpg");
		reviewImage.add("c.jpg");
		
		member.setMemberId("hihi@a.com");
		//reservation.set
		
		review.setMember(member);
		review.setReservation(reservation);
		review.setReviewDetail("맛있어요~~");
		review.setHashTag(hashTag);
		review.setReviewImage(reviewImage);
		review.setScopeTaste(4);
		review.setScopeKind(5);
		review.setScopeClean(4);
		review.setAvgScope((4+5+4)/3);	
	}
	
	@Test
	public void testUpdateReview() throws Exception {
		Review review = new Review();
		
		review.setReviewDetail("최고에요~~");
		review.setScopeTaste(5);
		review.setScopeKind(5);
		review.setScopeClean(5);
		review.setAvgScope((5+5+5)/3);
	}
}