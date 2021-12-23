package com.zzupzzup.service.notice.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Notice;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.notice.NoticeService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class NoticeServiceTest {

	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;


	//@Test
	public void testAddNotice() throws Exception {
		
		Notice notice = new Notice();
		Member member = new Member();
		
		member.setMemberId("admin@admin.com");
		notice.setMember(member);
		
		notice.setPostTitle("스므으 커피 2000원");
		notice.setPostText("근데 타르트는 맛이업성~ 버터바 못 참지~");
		notice.setPostCategory(2);
		notice.setPostMemberType("admin");
		
		noticeService.addNotice(notice);
		
	}
	
	//=======================================================================================
	
	 //@Test 
	 public void testGetNotice() throws Exception {
	 
	 Notice notice= new Notice(); 

	 notice.setPostNo(1);
	 System.out.println("notice get success:::" + notice.toString());
	 
	 notice = noticeService.getNotice(notice.getPostNo());
	 //restaurant join 안하고 컨트롤러 타는법
	 System.out.println("notice get success22222:::" + notice);
	 
	 }
	 
	//========================================================================================
	 
	//@Test
	 public void testListNotice() throws Exception {
		Search search = new Search();
		
		search.setCurrentPage(3);		
		search.setPageSize(pageSize);
		
		
		
		Map<String, Object> map = noticeService.listNotice(search);
		
		List<Notice> list = (List<Notice>) map.get("list");
		
		System.out.println("notice list success");
		
		for (Notice r : list) {
			System.out.println(r.getPostNo());
		}
		
		 Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		 System.out.println(resultPage);
	}
	
	//========================================================================================
	
		//@Test
		public void testUpdateNotice() throws Exception {
			
			Notice notice = new Notice();
			
			notice.setPostNo(2);
			notice.setPostMemberType("admin");
			notice.setPostTitle("뚜레쥬르 케잌");
			notice.setPostText("뚜레쥬르 케잌 먹고싶습니당");
			notice.setPostCategory(2);
		
			if(noticeService.updateNotice(notice) == 1) {
				System.out.println("notice update success");
			}
		
		}
		
	//========================================================================================	
		
		@Test
		public void testDeleteNotice() throws Exception {
			
			Notice notice = new Notice();
			
			notice.setPostNo(5);
			
			if(noticeService.deleteNotice(notice.getPostNo()) == 1) {
				System.out.println("post delete success");
			}
			
		}
}