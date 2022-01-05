package com.zzupzzup.web.review;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.domain.HashTag;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	public ReviewRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/listHashTag", method = RequestMethod.GET)
	public List<HashTag> listHashTag(@RequestParam("keyWord") String keyword) throws Exception {
		
		System.out.println("/review/json/listHashTag : GET");
		
		return reviewService.listHashTag(keyword);
	}
	
//	@RequestMapping(value = "json/getReview/{reviewNo}", method = RequestMethod.GET)
//	public boolean getReview(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
//		
//		System.out.println("/review/json/getReview : GET");
//		
//		Review review = reviewService.getReview(reviewNo);
//		
//		session.removeAttribute("review");
//		
//		if (review != null) {
//			System.out.println("성공 :: " + review );
//			session.setAttribute("review", review);
//			return true;
//		}
//		
//		return false;
//	}
	
	@RequestMapping(value = "json/getReview/{reviewNo}", method = RequestMethod.GET)
	public Map<String, Object> getReview(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
		
		System.out.println("/review/json/getReview : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		List<Mark> listLike = null;
		
		String memberId = null;
		
		if (member != null && member.getMemberRole().equals("user")) {
			memberId = member.getMemberId();
			listLike = reviewService.listLike(memberId);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", reviewService.getReview(reviewNo));
		map.put("listLike", listLike);
		
		return map;
	}
	
	@RequestMapping(value = "json/addLike/{reviewNo}", method = RequestMethod.GET)
	public Review addLike(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
		
		System.out.println("/review/json/addLike : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		System.out.println(member);
		
		if (member != null) {
			reviewService.addLike(member.getMemberId(), reviewNo);
		}

		return reviewService.getReview(reviewNo);
	}
	
	@RequestMapping(value = "json/deleteLike/{reviewNo}", method = RequestMethod.GET)
	public Review deleteLike(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
		
		System.out.println("/review/json/deleteLike : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		System.out.println(member);
		
		if (member != null) {
			reviewService.deleteLike(member.getMemberId(), reviewNo);
		}

		return reviewService.getReview(reviewNo);
	}
	
//	@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
//	public List<String> addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		System.out.println("/chat/json/addDragFile : POST");
//		
//		List<MultipartFile> fileList =  multipartRequest.getFiles("uploadFile");
//	
//		System.out.println(fileList);
//		
//		List<String> reviewImage = new ArrayList<String>();
//		
//	    String filePath = request.getServletContext().getRealPath(CommonUtil.IMAGE_PATH+"review");
//	    
//	    System.out.println("filePath : " + filePath);
//	    
//	    Map<String, Object> map = new HashMap<String, Object>();
//	    
//	    for (MultipartFile mf : fileList) {
//			//image가 존재한다면(image의 name이 공백이 아닐경우)
//			if (!mf.getOriginalFilename().equals("")) {
//				System.out.println(":: 파일 이름 => " + mf.getOriginalFilename());
//				System.out.println(":: 파일 사이즈 => " + mf.getSize());
//	
//				try {
//					String saveName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
//					
//					File file = new File(filePath + "/" + saveName);
//					mf.transferTo(file);
//									
//					System.out.println(":: 저장할 이름 => " + saveName);
//					 
//					reviewImage.add(saveName);
//				
//					System.out.println("업로드 성공");
//				} catch (Exception e) {
//					// TODO: handle exception
//					System.out.println("업로드 없음");
//					e.printStackTrace();
//					//saveName = "notFile.png";
//				}
//			}
//		}
//	     
//	    return reviewImage;
//	}
	
	@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
	public List<String> addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/chat/json/addDragFile : POST");
		
		Iterator<String> itr =  multipartRequest.getFileNames();

		List<String> reviewImage = new ArrayList<String>();
		
        String filePath = request.getServletContext().getRealPath("/resources/images/uploadImages/review");
        
        System.out.println("filePath : " + filePath);
        
        while (itr.hasNext()) { //받은 파일들을 모두 돌린다.
            System.out.println(itr);
            MultipartFile mf = multipartRequest.getFile(itr.next());
     
            String originalFileName = mf.getOriginalFilename(); //파일명
            
            String saveName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename()); //저장되는 파일명
     
            String fileFullPath = filePath+"/"+saveName; //파일 전체 경로
            
            reviewImage.add(saveName);
     
            try {
                //파일 저장
                mf.transferTo(new File(fileFullPath)); //파일저장 실제로는 service에서 처리
                
                System.out.println("originalFilename => "+originalFileName);
                System.out.println("saveName => "+saveName);
                System.out.println("fileFullPath => "+fileFullPath);
     
            } catch (Exception e) {
                System.out.println("postTempFile_ERROR======>"+fileFullPath);
                e.printStackTrace();
            }
                         
       }
         
        return reviewImage;
    }
}
