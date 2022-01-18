package com.zzupzzup.web.community;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.common.util.S3ImageUpload;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;

@RestController
@RequestMapping("/community/*")
public class CommunityRestController {
	
	// Field
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;
	
	private S3ImageUpload s3ImageUpload;
	
	// Constructor
	public CommunityRestController() {
		System.out.println(this.getClass());
	}
	
	// Method
//	@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
//	public List<String> addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		System.out.println("/community/json/addDragFile : POST");
//		
//		List<MultipartFile> fileList = multipartRequest.getFiles("uploadFile");
//		System.out.println("FILE LIST TO UPLOAD : " + fileList);
//		
//		List<String> postImg = new ArrayList<String>();
//		String filePath = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH);
//		System.out.println("FILE_PATH : " + filePath);
//		
//		for(MultipartFile mf : fileList) {
//			
//			if(!mf.getOriginalFilename().equals("")) {
//				System.out.println(":: 파일 이름 => " + mf.getOriginalFilename());
//				System.out.println(":: 파일 사이즈 => " + mf.getSize());
//				
//				try {
//					String fileName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
//					
//					File file = new File(filePath + "/" + fileName);
//					mf.transferTo(file);
//					
//					System.out.println(":: 저장할 이름 => " + fileName);
//					postImg.add(fileName);
//					
//					System.out.println("::: IMAGE UPLOAD SUCCESS :::");
//					
//				} catch (Exception e) {
//					System.out.println("::: IMAGE UPLOAD FAIL :::");
//					e.printStackTrace();
//				}
//				
//			}
//			
//		}
//		
//		return postImg;
//		
//	}
	
	@RequestMapping(value = "json/addLike/{postNo}", method = RequestMethod.GET)
	public Community addLike(@PathVariable("postNo") int postNo, HttpSession session) throws Exception {
		
		System.out.println("/community/json/addLike : GET");
		
		Member member = (Member) session.getAttribute("member");
		System.out.println("MEMBER INFOMATION : " + member);
		
		if(member != null) {
			communityService.addLike(member.getMemberId(), postNo);
		}
		
		return communityService.getCommunity(postNo);
		
	}
	
	@RequestMapping(value = "json/deleteLike/{postNo}", method = RequestMethod.GET)
	public Community deleteLike(@PathVariable("postNo") int postNo, HttpSession session) throws Exception {
		
		System.out.println("/community/json/deleteLike : GET");
		
		Member member = (Member) session.getAttribute("member");
		System.out.println("MEMBER INFOMATION : " + member);
		
		if(member != null) {
			communityService.deleteLike(member.getMemberId(), postNo);
		}
		
		return communityService.getCommunity(postNo);
		
	}
	
	
	@RequestMapping(value="json/listCommunity")
	public Map<String, Object> listCommunity(@RequestBody Search search, HttpServletRequest request, HttpSession session) throws Exception {
		
		
		
		
		System.out.println("/community/json/listCommunity : SERVICE");
		System.out.println("/community/json/listCommunity PAGE : " + request.getParameter("page"));
		
		Member member = (Member)session.getAttribute("member");
		List<Mark> listLike = null;
		
		if(member != null && member.getMemberRole().equals("user")) {
			listLike = communityService.listLike(member.getMemberId());
		}
		
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
//		if(request.getParameter("page") != null) {
//			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
//		}
		
		System.out.println("CurrentPage : " + search.getCurrentPage());
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = communityService.listCommunity(search);
		
		List<Community> list = (List<Community>) map.get("list");
		
		for(Community cm : list) {
			System.out.println("COMMNUNITY LIST : " + cm);
		}
		
		//pageUnit, pageSize
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("RESULT PAGE : " + resultPage);
		
		map.put("list", map.get("list"));
		map.put("listLike", listLike);
		map.put("search", search);
		map.put("totalCount", map.get("totalCount"));
		map.put("resultPage", resultPage);
		
		return map;
		
	}
	
	
	@RequestMapping(value="json/listMyPost")
	public Map<String, Object> listMyPost(@RequestBody Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		//System.out.println(request.getParameter("memnerId"));
		
		System.out.println("/community/json/listCommunity : SERVICE");
		System.out.println("/community/json/listCommunity PAGE : " + request.getParameter("page"));
		
		System.out.println("search : "  + search);
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		if(search.getSearchSort() == null || search.getSearchSort() == "") {
			search.setSearchSort("latest");
		}
		
		Member member = (Member)session.getAttribute("member");
		
		System.out.println(member);
		
		List<Mark> listLike = null;
		
		if(member != null && member.getMemberRole().equals("user")) {
			listLike = communityService.listLike(member.getMemberId());
		}
		
		
//		if(request.getParameter("page") != null) {
//			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
//		}
		
		System.out.println("CurrentPage : " + search.getCurrentPage());
		
		search.setPageSize(pageSize);
		
		//Map<String, Object> map = communityService.listMyPost(search, memberId);
		Map<String, Object> map = communityService.listMyPost(search, member.getMemberId());
		
		List<Community> list = (List<Community>) map.get("list");
		
		for(Community cm : list) {
			System.out.println("COMMNUNITY LIST : " + cm);
		}
		
		//pageUnit, pageSize
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("RESULT PAGE : " + resultPage);
		
		map.put("list", map.get("list"));
		map.put("listLike", listLike);
		map.put("search", search);
		map.put("totalCount", map.get("totalCount"));
		map.put("resultPage", resultPage);
		
		return map;
		
	}
	
	
	// AWS S3 Image Upload
	@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
	public List<String> addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/community/json/addDragFile : POST");
		
		s3ImageUpload = new S3ImageUpload();
	
		List<MultipartFile> fileList =  multipartRequest.getFiles("uploadFile");
		System.out.println("FILE LIST TO UPLOAD : " + fileList);
		
		List<String> postImg = new ArrayList<String>();
	    Map<String, Object> map = new HashMap<String, Object>();
	    
	    for (MultipartFile mf : fileList) { 

			if (!mf.getOriginalFilename().equals("")) {
				System.out.println(":: 파일 이름 => " + mf.getOriginalFilename());
				System.out.println(":: 파일 사이즈 => " + mf.getSize());
	
				try {
					String fileName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
					
					String s3Path = "community/" + fileName;
					
					s3ImageUpload.uploadFile(mf, s3Path);
			
					System.out.println(":: 저장할 이름 => " + fileName);
					 
					postImg.add(fileName);
				
					System.out.println("::: IMAGE UPLOAD SUCCESS :::");
					
					//String test = s3ImageUpload.getFileURL(fileName);
					//System.out.println(test);
				} catch (Exception e) {
					System.out.println("::: IMAGE UPLOAD FAIL :::");
					e.printStackTrace();
				}
			}
		}
	     
	    return postImg;
	}
	
	
}
