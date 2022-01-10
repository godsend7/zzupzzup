package com.zzupzzup.web.chat;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.common.util.CommonUtil;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.restaurant.RestaurantService;

@RestController
@RequestMapping("/chat/*")
public class ChatRestController {

	///Field
	@Autowired
	@Qualifier("chatServiceImpl")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	public ChatRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value="json/getChat/{chatNo}", method=RequestMethod.GET)
	public Chat getChat(@PathVariable int chatNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/json/getProduct : GET");
		System.out.println("chatNo : " + chatNo);
		
		//Business Logic
		Chat chat = chatService.getChat(chatNo);
		
		Restaurant restaurant = new Restaurant();
		Member member = new Member();
		
		restaurant = restaurantService.getRestaurant(chat.getChatRestaurant().getRestaurantNo());
		member = memberService.getMember(chat.getChatLeaderId());
		
		chat.setChatRestaurant(restaurant);
		chat.setChatLeaderId(member);

		System.out.println("json getChat chat : " + chat);
		
		request.setAttribute("chat", chat);

		// Business Logic
		return chat;
	}
	
	@RequestMapping(value="json/listRestaurantAutocomplete/searchKeyword={searchKeyword}", method=RequestMethod.GET)
	public Map listRestaurantAutocomplete(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
		
		System.out.println("/chat/json/listRestaurantAutocomplete : GET");
		System.out.println("listRestaurantAutocomplete request menu : " + search.getSearchKeyword());
		
		String searchKeyword2 = search.getSearchKeyword();
		
		search.setSearchKeyword(null);
		
		String decText= URLDecoder.decode(searchKeyword2,"UTF-8");
		System.out.println("decText : " + decText);
		search.setSearchKeyword(decText);
		
		//Business Logic
		Map<String, Object> map = restaurantService.listRestaurantName(search);
		
		Restaurant restaurant = new Restaurant();
		
		//System.out.println(map);
		
		map.put("restaurant", restaurant);

		// Business Logic
		return map;
	}
	
	@RequestMapping(value="json/addDragFile", method=RequestMethod.POST)
	public Map addDragFile(MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/chat/json/addDragFile : POST");
		
		Iterator<String> itr =  multipartRequest.getFileNames();

        String filePath = request.getServletContext().getRealPath("/resources/images/uploadImages/chat");
        
        System.out.println("filePath : " + filePath);
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        while (itr.hasNext()) { //받은 파일들을 모두 돌린다.
            
            MultipartFile mf = multipartRequest.getFile(itr.next());
     
            String originalFileName = mf.getOriginalFilename(); //파일명
            
            String saveName = CommonUtil.getTimeStamp("yyyyMMddHHmmssSSS", mf.getOriginalFilename()); //저장되는 파일명
     
            String fileFullPath = filePath+"/"+saveName; //파일 전체 경로
            
            map.put("saveName", saveName);
     
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
         
        return map;
    }
	
	@RequestMapping(value="json/updateReadyCheck/chatNo={chatNo}&readyCheck={readyCheck}", method=RequestMethod.GET)
	public Map updateReadyCheck(@PathVariable int chatNo, @PathVariable boolean readyCheck, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("/chat/json/updateReadyCheck : GET");
		
		Member member = (Member)session.getAttribute("member");
		
		ChatMember chatMember = new ChatMember();
		chatMember.setChatNo(chatNo);
		chatMember.setMember(member);
		chatMember.setReadyCheck(readyCheck);
		
		System.out.println("UpdateReadyCheck chatMember : " + chatMember);
		
		chatService.updateReadyCheck(chatMember);
		
		Map map = new HashMap();
		map.put("chatMember", chatMember);
		return map;
	}
	
	@RequestMapping(value="json/listChatMember/chatNo={chatNo}", method=RequestMethod.GET)
	public Map listChatMember(@PathVariable int chatNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("/chat/json/listChatMember : GET");
		
		ChatMember chatMember = new ChatMember();
		chatMember.setChatNo(chatNo);
		
		Map<String, Object> map = chatService.listChatMember(chatNo);
		
		return map;
	}
	
	@RequestMapping(value="json/listReadyCheckMember/chatNo={chatNo}", method=RequestMethod.GET)
	public Map listReadyCheckMember(@PathVariable int chatNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("/chat/json/listReadyCheckMember : GET");
		
		ChatMember chatMember = new ChatMember();
		chatMember.setChatNo(chatNo);
		
		Map<String, Object> map = chatService.listReadyCheckMember(chatNo);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="json/listChat", method=RequestMethod.POST)
	public List<Chat> listChat(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("/chat/json/listChat : GET / POST");
		System.out.println("/chat/listChat page : " + request.getParameter("page"));
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		if(search.getSearchSort() == null || search.getSearchSort() == "") {
			search.setSearchSort("latest");
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);

		System.out.println("rest쪽 search 표시" + search);

		Member member = (Member)session.getAttribute("member");
		
		Map<String, Object> map = chatService.listChat(search, member.getMemberId());
		
		List<Chat> list = (List<Chat>)map.get("list");
		
		Restaurant restaurant = new Restaurant();
		
		for (Chat c : list) {
			restaurant = 	restaurantService.getRestaurant(c.getChatRestaurant().getRestaurantNo());
			c.setChatRestaurant(restaurant);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), 		((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " + resultPage);
		
		System.out.println("listChat member : " + member);
		
		// Model and View
		request.setAttribute("list", list);
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		request.setAttribute("member", member);
		
		return list;
	}
	
	
}
