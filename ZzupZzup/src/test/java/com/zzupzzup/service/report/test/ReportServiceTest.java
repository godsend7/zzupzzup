package com.zzupzzup.service.report.test;

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
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.domain.Report;
import com.zzupzzup.service.report.ReportService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class ReportServiceTest {

	@Autowired
	@Qualifier("reportServiceImpl")
	private ReportService reportService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	//@Test
	public void testAddReport() throws Exception {
		Report report = new Report();
		
		report.setMemberId("hihi@a.com");
		//report.setReportReviewNo(1);
		report.setReportChatNo(1);
		//report.setReportMemberId("user02@zzupzzup.com");
		//report.setReportRestaurantNo(2);;
		report.setReportCategory(1);
		report.setReportType(2);
		report.setReportDetail("정보가 확실하지 않습니다.");
		
		reportService.addReport(report);
		
		String result = CommonUtil.returnReportData(report.getReportCategory(), report.getReportType());
		
		System.out.println(result);
	}
	
	//@Test
	public void testListReport() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		Map<String, Object> map = reportService.listReport(search, 1, null);
		List<Report> list = (List<Report>) map.get("list");
		
		for (Report r : list) {
			System.out.println(r);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
	}
	
	//@Test
	public void testCheckReport() throws Exception {
		Report report = new Report();
		report.setReportNo(3);
		
		reportService.checkReport(3);
	}
	
	//@Test
//	public void testReportCount() throws Exception {
//		Report report = new Report();
//		report.setReportNo(3);
//		
//		reportService.checkReport(3);
//	}
}