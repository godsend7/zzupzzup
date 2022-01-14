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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.common.util.S3ImageUpload;
import com.zzupzzup.service.community.CommunityService;
import com.zzupzzup.service.domain.Community;
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
	
	//AWS S3 Image Upload
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
