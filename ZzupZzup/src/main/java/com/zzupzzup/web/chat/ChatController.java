package com.zzupzzup.web.chat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;

@Controller
@RequestMapping("/chat")

public class ChatController {
	
	///Field
	@Autowired
	@Qualifier("chatServiceImpl")
	private ChatService chatService;

	public ChatController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	
	@RequestMapping(value="addChat", method=RequestMethod.GET)
	public String addChat() throws Exception {
		
		System.out.println("/chat/addCaht : GET");
		
		return "redirect:/chat/addChat.jsp";
	}
	
	@RequestMapping(value="addChat", method=RequestMethod.POST)
	public String addChat(@ModelAttribute("chat") Chat chat, HttpServletRequest request, HttpSession session) throws Exception {
		
		return "forward:/chat/addchat.jsp";
		
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
