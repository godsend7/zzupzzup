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
	public int addChat(Chat chat) throws Exception {
		return chatDao.addChat(chat);
	}

	@Override
	public Chat getChat(int chatNo) throws Exception {
		Chat chat = new Chat();
		chat = chatDao.getChat(chatNo);
		
		System.out.println("getChat 결과 chat : " + chat);
		
		//System.out.println("시간 나오는거 볼랭 : " + chat.getChatRegDate());
		
		/*
		 * String chatState = chat.getChatState();
		 * System.out.println("getChat 결과 chat의 chatState : " + chatState);
		 * 
		 * if(chatState.equals("1")){ System.out.println("여기 들어오나나나나");
		 * chat.setChatState("모집중"); }else if(chatState.equals("2")){
		 * chat.setChatState("인원확정"); }else if(chatState.equals("3")){
		 * chat.setChatState("예약확정"); }else if(chatState.equals("4")){
		 * chat.setChatState("모임완료"); }
		 */
		
		//System.out.println("fdfsfeofewofsd : " + chat);
		
		return chat;
	}
	
	@Override
	public int updateChat(Chat chat) throws Exception {
		return chatDao.updateChat(chat);
	}

	@Override
	public Map<String, Object> listChat(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		//map.put("searchCondition", search.getSearchCondition() );
		//map.put("searchKeyword",  search.getSearchKeyword() );
		//map.put("endRowNum",  search.getEndRowNum() );
		//map.put("startRowNum",  search.getStartRowNum() );
		
		map.put("list", chatDao.listChat(map));
		map.put("totalCount", chatDao.getTotalCount(search));
		//List<Chat> list = chatDao.listChat(search, restaurantNo);
		//int totalCount = chatDao.getTotalCount(search);
		
		//Map<String, Object> map = new HashMap<String,Object>();
		//map.put("list", list);
		//map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public Chat getChatEntrance(int chatNo) throws Exception {
		return chatDao.getChatEntrance(chatNo);
	}

	@Override
	public int deleteChat(Chat chat) throws Exception {
		return chatDao.deleteChat(chat);
	}

	@Override
	public int updateChatState(int chatNo, int chatState) throws Exception {
		return chatDao.updateChatState(chatNo, chatState);
	}

	@Override
	public Chat getChatRecord(int chatNo) throws Exception {
		return chatDao.getChatRecord(chatNo);
	}
	
	@Override
	public int updateChatMember(ChatMember chatMember) throws Exception {
		return chatDao.updateChatMember(chatMember);
	}

	@Override
	public int deleteChatMember(ChatMember chatMember) throws Exception {
		return chatDao.deleteChatMember(chatMember);
	}
	
	@Override
	public int updateReadyCheck(ChatMember chatMember) throws Exception {
		return chatDao.updateReadyCheck(chatMember);
	}
	
	@Override
	public int addChatMember(ChatMember chatMember) throws Exception {
		return chatDao.addChatMember(chatMember);
	}
	
	@Override
	public ChatMember getChatMember(int chatNo, String memberId) throws Exception {
		return chatDao.getChatMember(chatNo, memberId);
	}

	@Override
	public Map<String, Object> listChatMember(Search search, int chatNo) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search", search);
		//map.put("searchCondition", search.getSearchCondition() );
		//map.put("searchKeyword",  search.getSearchKeyword() );
		//map.put("endRowNum",  search.getEndRowNum() );
		//map.put("startRowNum",  search.getStartRowNum() );
		map.put("chatNo", chatNo);
		
		map.put("list", chatDao.listChatMember(map));
		map.put("totalCount", chatDao.getTotalCount(search));
		
		return map;
	}

	@Override
	public Map<String, Object> listReadyCheckMember(int chatNo) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("chatNo", chatNo);
		
		map.put("list", chatDao.listReadyCheckMember(map));
		
		return map;
	}

	@Override
	public Map<String, Object> listRestaurantName(Search search) throws Exception {
		System.out.println("chatServiceImpl listRestaurantName " );
		System.out.println("search : " + search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		System.out.println("map : " + map);
		
		map.put("list", chatDao.listRestaurantName(map));
		
		return map;
	}

	

}
