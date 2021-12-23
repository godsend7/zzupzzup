package com.zzupzzup.service.chat.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.chat.ChatDAO;
import com.zzupzzup.service.chat.ChatService;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;

@Service("chatServiceImpl")
public class ChatServiceImpl implements ChatService {
	
	///Field
	@Autowired
	@Qualifier("chatDaoImpl")
	private ChatDAO chatDao;

	///Constructor
	public ChatServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addChat(Chat chat) throws Exception {
		chatDao.addChat(chat);
	}

	@Override
	public Chat getChat(int chatNo) throws Exception {
		return chatDao.getChat(chatNo);
	}

	@Override
	public Map<String, Object> listChat(Search search, String restaurantNo) throws Exception {
		List<Chat> list = chatDao.listChat(search, restaurantNo);
		int totalCount = chatDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updateChat(Chat chat) throws Exception {
		chatDao.updateChat(chat);
	}

	@Override
	public Chat getChatEntrance(int chatNo) throws Exception {
		return chatDao.getChatEntrance(chatNo);
	}

	@Override
	public void deleteChat(Chat chat) throws Exception {
		chatDao.deleteChat(chat);
	}

	@Override
	public void updateChatState(Chat chat) throws Exception {
		chatDao.updateChatState(chat);
	}

	@Override
	public Chat getChatRecord(int chatNo) throws Exception {
		return chatDao.getChatRecord(chatNo);
	}

	@Override
	public void updateReadyCheck(Chat chat) throws Exception {
		chatDao.updateReadyCheck(chat);
	}

	@Override
	public void deleteChatMember(String memberId, int chatNo) throws Exception {
		chatDao.deleteChatMember(memberId, chatNo);
	}
	
	@Override
	public void addChatMember(int chatNo, Member memberId) throws Exception {
		chatDao.addChatMember(chatNo, memberId);
	}
	
	@Override
	public Map<String, Object> getChatMember(int chatNo, Member memberId) throws Exception {
		List<ChatMember> list = chatDao.getChatMember(chatNo, memberId);
		
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("list", list);
		
		return map;
	}

	@Override
	public Map<String, Object> listChatMember(Search search) throws Exception {
		List<Chat> list = chatDao.listChatMember(search);
		int totalCount = chatDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public Map<String, Object> listReadyCheckMember(Search search) throws Exception {
		List<Chat> list = chatDao.listReadyCheckMember(search);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		
		return map;
	}

}
