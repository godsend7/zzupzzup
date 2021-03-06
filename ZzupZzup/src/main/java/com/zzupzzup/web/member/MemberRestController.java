package com.zzupzzup.web.member;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.common.util.S3ImageUpload;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.member.MailService;
import com.zzupzzup.service.member.MemberService;


@RestController
@RequestMapping("/member/*")
public class MemberRestController {
	
	//*Field
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("mailServiceImpl")
	private MailService mailService;
	
	private S3ImageUpload s3ImageUpload;
	
	//*Constructor
	public MemberRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	//*Method
//	public void login() {
//		
//	}
	
	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public Member login(@RequestBody Member member, HttpSession session) throws Exception{
		
		System.out.println("/member/json/login : POST");
		System.out.println("::"+member.getMemberId()+", "+member.getPassword());
		
		//Business Logic
		Member mb = memberService.getMember(member);

		if(mb != null && mb.getPassword().equals(member.getPassword())){
			//System.out.println("???????????? : "+mb.getDeleteReason());
			if(mb.isEliminated() || mb.isRegBlacklist()) {
				System.out.println("???????????? : "+mb.getDeleteReason());
				System.out.println("??????????????? : "+mb.getBlacklistDate());
				
				if(mb.isEliminated() && !mb.isRecovered()) {
					
					/* ?????? ??? 7??? ?????? ????????? ??? ???????????? ?????? ????????? ????????? variable */
					String deleteDate = mb.getDeleteDate().toString();
					String currentDate = LocalDate.now().toString();
					
					System.out.println("deleteDate : "+deleteDate+", currentDate : "+currentDate);
					
					int deleteDateYear = Integer.parseInt(deleteDate.substring(0, 4));
					int deleteDateMonth = Integer.parseInt(deleteDate.substring(5, 7));
					int deleteDateDay = Integer.parseInt(deleteDate.substring(8));
					int currentDateYear = Integer.parseInt(currentDate.substring(0, 4));
					int currentDateMonth = Integer.parseInt(currentDate.substring(5, 7));
					int currentDateDay = Integer.parseInt(currentDate.substring(8));
					
					if(currentDateYear == deleteDateYear && currentDateMonth == deleteDateMonth && (currentDateDay - deleteDateDay <= 7 || currentDateDay - deleteDateDay >= -7)) {
						System.out.println(currentDateDay - deleteDateDay);
						mb.setRecovered(true);
					}
				}
				
				return mb;
			} else {
				session.setAttribute("member", mb);
				System.out.println(mb.getMemberId()+" ??? ?????????");
				return mb;
			}
			
		}
			
		return null;
	}
	
//	public void selectMemberRole() {
//		
//	}
	
	@RequestMapping(value="json/kakaoLogin", method=RequestMethod.POST)
	public Member kakaoLogin(@RequestBody Member member, HttpSession session) throws Exception {
		
		System.out.println("/member/json/kakaoLogin : POST");
		System.out.println("::"+member.getMemberId());
		
		Member mb = memberService.getMember(member);

		if(mb != null) {
			if(mb.isEliminated() || mb.isRegBlacklist()) {
				System.out.println("???????????? : "+mb.getDeleteReason());
				System.out.println("??????????????? : "+mb.getBlacklistDate());
				
				if(mb.getDeleteDate() != null && !mb.isRecovered()) {
					
					/* ?????? ??? 7??? ?????? ????????? ??? ???????????? ?????? ????????? ????????? variable */
					String deleteDate = mb.getDeleteDate().toString();
					String currentDate = LocalDate.now().toString();
					
					System.out.println("deleteDate : "+deleteDate+", currentDate : "+currentDate);
					
					int deleteDateYear = Integer.parseInt(deleteDate.substring(0, 4));
					int deleteDateMonth = Integer.parseInt(deleteDate.substring(5, 7));
					int deleteDateDay = Integer.parseInt(deleteDate.substring(8));
					int currentDateYear = Integer.parseInt(currentDate.substring(0, 4));
					int currentDateMonth = Integer.parseInt(currentDate.substring(5, 7));
					int currentDateDay = Integer.parseInt(currentDate.substring(8));
					
					if(currentDateYear == deleteDateYear && currentDateMonth == deleteDateMonth && (currentDateDay - deleteDateDay <= 7 || currentDateDay - deleteDateDay >= -7)) {
						System.out.println(currentDateDay - deleteDateDay);
						mb.setRecovered(true);
					}
				}
				
			} else {
				session.setAttribute("member", mb);
				System.out.println(mb.getMemberId()+" ??? ????????? ?????????");
			}
			
			return mb;
		} else {
			System.out.println("?????? ????????? ????????? ?????????");
			//session.setAttribute("kakaoMember", mb)
		}
		
		return null;
	}
	
//	public void naverLogin() {
//		
//	}
	
	@RequestMapping(value="json/checkIdDuplication", method=RequestMethod.POST)
	public boolean checkIdDuplication(@RequestParam("memberId") String memberId) throws Exception {
		
		System.out.println("/member/json/checkIdDuplication : POST");
		
		return memberService.checkIdDuplication(memberId);
	}

	@RequestMapping(value="json/checkNicknameDuplication", method=RequestMethod.POST)
	public boolean checkNicknameDuplication(@RequestParam("nickname") String nickname) throws Exception {
		
		System.out.println("/member/json/checkNicknameDuplication : POST");
		
		return memberService.checkNicknameDuplication(nickname);
	}
	
	@RequestMapping(value="json/findAccount", method=RequestMethod.POST)
	public Member findAccount(@RequestBody Member member, HttpServletRequest request) throws Exception {
		
		System.out.println("/member/json/findAccount : POST");
		System.out.println("memberName : "+member.getMemberName()+", memberId : "+member.getMemberId()+", memberPhone : "+member.getMemberPhone());
		
		if(member.getMemberId() == null) {
			Member mb = memberService.getMember(member);
			//System.out.println("??????!");
			if(mb != null) {
				//System.out.println("??????!!");
				return mb;
			}
		} else if(member.getMemberPhone() == null || member.getMemberPhone() == "" || member.getMemberPhone().contains("undefined") ) {
			//System.out.println("??????!!!");
			Member mb = memberService.getMember(member);
			if(mb != null) {
				//System.out.println("??????!!!!");
				if(mb.getLoginType() == 1) {
					mailService.sendToEmail(mb.getMemberId(), request);
				}
				return mb;
			}
		}
		
		return null;
	}
	
	@RequestMapping(value="json/sendCertificatedNum", method=RequestMethod.GET)
	public String sendCertificatedNum(String phoneNum) throws Exception {
		
		System.out.println("/member/json/sendCertificatedNum : GET");
		
		String certificatedNum = "";
		
	    for(int i = 1; i <= 6; i++) {
	    	Random random = new Random();
	    	certificatedNum += random.nextInt(10);
	    }

	    memberService.sendCertificatedNum(certificatedNum, phoneNum);
	    
//	    String inputCertificatedNum = null;
//	    String inputPhoneNum = null;
//	    memberService.checkCertificatedNum(inputCertificatedNum, certificatedNum, inputPhoneNum, phoneNum);
	    
	    return certificatedNum;
	}
	
//	@RequestMapping(value="json/checkCertificatedNum", method=RequestMethod.POST)
//	public void checkCertificatedNum(String inputCertificatedNum, String certificatedNum) throws Exception {
//		
//		System.out.println("/member/json/checkCertificatedNum : POST");
//		
//		memberService.checkCertificatedNum(inputCertificatedNum, certificatedNum);
//		
//	}
	
	@RequestMapping(value="json/deleteMember", method=RequestMethod.POST)
	public Member deleteMember(@RequestBody Member member, HttpSession session) throws Exception {
		
		System.out.println("/member/json/deleteMember : POST");
		System.out.println("memberId : "+member.getMemberId()+", password : "+member.getPassword()+", deleteType : "+member.getDeleteType()+", deleteReason : "+member.getDeleteReason());
		
		Member mb = memberService.getMember(member);
		
		if(mb.getLoginType() == 1) {
			
			if(member.getMemberId().equals(mb.getMemberId()) && member.getPassword().equals(mb.getPassword())) {
				//System.out.println("??????");
				mb.setDeleteType(member.getDeleteType());
				
				if(mb.getDeleteReason() == null) {
					//System.out.println("???");
					mb.setDeleteReason(member.getDeleteReason());
				}
				
				memberService.updateMember(mb);
				session.invalidate();
				
				return mb;
			}
			
		} else if(mb.getLoginType() == 2) {
		
			if(member.getMemberId().equals(mb.getMemberId())) {
				//System.out.println("??????");
				mb.setDeleteType(member.getDeleteType());
				
				if(mb.getDeleteReason() == null) {
					//System.out.println("???");
					mb.setDeleteReason(member.getDeleteReason());
				}
				
				memberService.updateMember(mb);
				session.invalidate();
				
				return mb;
			}
		}

		return null;
	}
	
	@RequestMapping(value="json/recoveryMember", method=RequestMethod.POST)
	public Member recoveryMember(@RequestBody Member member, HttpSession session) throws Exception {
		
		Member mb = memberService.getMember(member);
		
		//System.out.println("member : "+member.isRecovered()+", mb : "+mb.isRecovered());
		
		if(member.isRecovered()) {
			
			/* ?????? ??? 7??? ?????? ????????? ??? ???????????? ?????? ????????? ????????? variable */
			String deleteDate = mb.getDeleteDate().toString();
			String currentDate = LocalDate.now().toString();
			
			System.out.println("deleteDate : "+deleteDate+", currentDate : "+currentDate);
			
			int deleteDateYear = Integer.parseInt(deleteDate.substring(0, 4));
			int deleteDateMonth = Integer.parseInt(deleteDate.substring(5, 7));
			int deleteDateDay = Integer.parseInt(deleteDate.substring(8));
			int currentDateYear = Integer.parseInt(currentDate.substring(0, 4));
			int currentDateMonth = Integer.parseInt(currentDate.substring(5, 7));
			int currentDateDay = Integer.parseInt(currentDate.substring(8));
			
			if(currentDateYear == deleteDateYear && currentDateMonth == deleteDateMonth && (currentDateDay - deleteDateDay <= 7 || currentDateDay - deleteDateDay >= -7)) {
				System.out.println(currentDateDay - deleteDateDay);
				
				mb.setEliminated(false);
				mb.setRecovered(true);
				memberService.updateMember(mb);
				
				session.setAttribute("member", mb);
				System.out.println(mb.getMemberId()+" ??? ?????????");
				
			}
		}
		
		return mb;
	}
	
	@RequestMapping(value="json/getOtherUser", method=RequestMethod.POST)
	public Member getOtherUser(@RequestBody Member member, HttpSession session) throws Exception {
		
		System.out.println("/member/json/getOtherUser : POST");
		
		
		Member mb = memberService.getMember(member);
		//session.setAttribute("mb", mb);
		
		return mb;
	}
	
//	@RequestMapping(value="json/checkRegRestaurant", method=RequestMethod.POST)
//	public boolean checkRegRestaurant(boolean regRestaurant) throws Exception {
//		 return false;
//	}
	
	//multifile upload
	//@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
	public List<String> addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/member/json/addDragFile : POST");
		
		s3ImageUpload = new S3ImageUpload();
		
		List<MultipartFile> fileList =  multipartRequest.getFiles("uploadFile");
	
		System.out.println("????????? ?????? :: " + fileList);
		
		List<String> profileImage = new ArrayList<String>();
		
	    //Map<String, Object> map = new HashMap<String, Object>();
	    
	    for (MultipartFile mf : fileList) {
			//image??? ???????????????(image??? name??? ????????? ????????????)
			if (!mf.getOriginalFilename().equals("")) {
				System.out.println(":: ?????? ?????? => " + mf.getOriginalFilename());
				System.out.println(":: ?????? ????????? => " + mf.getSize());
	
				try {
					String saveName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename());
					
					String s3Path = "member/"+saveName;
					
					s3ImageUpload.uploadFile(mf, s3Path);
			
					System.out.println(":: ????????? ?????? => " + saveName);
					 
					profileImage.add(saveName);
				
					System.out.println("????????? ??????");
					
					//String test = s3ImageUpload.getFileURL(saveName);
					//System.out.println(test);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("????????? ??????");
					e.printStackTrace();
					//saveName = "notFile.png";
				}
			}
		}
	     
	    return profileImage;
	}

}
