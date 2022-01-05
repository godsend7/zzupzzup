package com.zzupzzup.web.report;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Report;
import com.zzupzzup.service.report.ReportService;

@Controller
@RequestMapping("/report/*")
public class ReportController {
	
	@Autowired
	@Qualifier("reportServiceImpl")
	private ReportService reportService;

	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;
	
	public ReportController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@RequestMapping(value="addReport", method=RequestMethod.POST)
	public String addReport(@ModelAttribute("report") Report report) throws Exception {
		
		System.out.println("report/addReport : POST");
		
		reportService.addReport(report);
		
		return "redirect:/report/listReport?reportCategory="+report.getReportCategory();
	}
	
	@RequestMapping("listReport")
	public String listReport(@RequestParam(value="reportCategory", required = false) String reportCategory, @ModelAttribute Search search, 
							HttpSession session, Model model) throws Exception {
		
		System.out.println("report/listReport : Service");
		
		Member member = (Member) session.getAttribute("member");
		
		String memberId = null;
		if (member != null && member.getMemberRole().equals("user")) {
			memberId = member.getMemberId();
		}
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		int category = 1;
		if (reportCategory != null) {
			category = Integer.parseInt(reportCategory);
		}
		
		System.out.println(search.getCurrentPage() + ":: currentPage");
		search.setPageSize(pageSize);
		
		Map<String, Object> map = reportService.listReport(search, category, memberId);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("category", map.get("category"));
		
		return "forward:/report/listReport.jsp";
	}
	
	@RequestMapping(value="updateReport/{reportNo}", method=RequestMethod.GET)
	@ResponseBody
	public int updateReport(@PathVariable int reportNo) throws Exception {
		
		System.out.println("report/updateReport : GET");
		
		
		
		//return "redirect:/report/listReport?reportCategory="+report.getReportCategory();
		return reportService.checkReport(reportNo);
	}
}
