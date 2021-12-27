package com.zzupzzup.web.notice;

import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;
import com.zzupzzup.service.notice.NoticeService;

@Controller
@RequestMapping("/notice/*")

public class NoticeController {
	
	//Field
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
	
	public NoticeController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize; // 미니프로젝트보고 따라한것.
	
	
	@RequestMapping( value="addNotice", method=RequestMethod.GET )
	public String addNotice() throws Exception{
	
		System.out.println("/notice/addNotice: GET");
		
		return "forward:/notice/addNoticeView.jsp";
	}
	
	@RequestMapping( value="addNotice", method=RequestMethod.POST )
	public String addNotice( @ModelAttribute("notice") Notice notice) throws Exception {

		System.out.println("/notice/addNotice: POST");
		//Business Logic
		noticeService.addNotice(notice);
		
		return "foward:/notice/addNotice.jsp";
	}
	
//==================================================================================================
	//질문
	@RequestMapping( value="getNotice", method=RequestMethod.GET )
	public String getNotice( @RequestParam("postNo") int postNo , Model model ) throws Exception {
		
		System.out.println("/notice/getNotice: GET");
		//Business Logic
		Notice notice = noticeService.getNotice(postNo);
		// Model 과 View 연결
		model.addAttribute("noitce", notice);
		
		return "foward:/notice/getNotice.jsp";
	}
	
	
	
//==================================================================================================	
	//질문
	@RequestMapping( value="updateNotice", method=RequestMethod.GET )
	public String updateNotice( @RequestParam("postNo") int  postNo , Model model ) throws Exception{

		System.out.println("/notice/updateNotice : GET");
		//Business Logic
		Notice notice = noticeService.getNotice(postNo);
		// Model 과 View 연결
		model.addAttribute("notice", notice);
		
		return "foward:/notice/updateNotice.jsp";
	}
	
	@RequestMapping( value="updateNotice", method=RequestMethod.POST )
	public String updateNotice( @ModelAttribute("notice") Notice notice, Model model , HttpSession session) throws Exception{

		System.out.println("/notice/updateNotice : POST");
		//Business Logic
		noticeService.updateNotice(notice);
		
		System.out.println("noticeNo::~~"+notice);
		//String sessionId=((Notice)session.getAttribute("notice")).Integer.toString(getPostNo());
		//if(sessionId.equals(notice.getPostNo())){
		//	session.setAttribute("notice", notice);
		//}
		
		return "redirect:/notice/getNotice?postNo";
	}

//==================================================================================================	
	
	@RequestMapping(value="listNotice")
	public String listNotice(@ModelAttribute("search") Search search, Model model) throws Exception {
		
		System.out.println("/notice/listNotice");
		
		if(search.getCurrentPage() == 0) {
			search.setPageSize(1);
		}
		
		search.setPageSize(0); //pageSize
		
		Map<String, Object> map = noticeService.listNotice(search);
		
		//pageUnit, pageSize
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 0, 0);
		System.out.println("RESULT PAGE : " + resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/notice/listNotice.jsp";	
	}

//======================================================================================================
	
	@RequestMapping( value="deleteNotice", method=RequestMethod.GET )
	public String deleteNotice() throws Exception{
	
		System.out.println("/notice/deleteNotice: GET");
		
		return "forward:/notice/listNotice.jsp";
	}
	
}	