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
		return chatDao.getChat(chatNo);
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
	public int updateChatState(Chat chat) throws Exception {
		return chatDao.updateChatState(chat);
	}

	@Override
	public Chat getChatRecord(int chatNo) throws Exception {
		return chatDao.getChatRecord(chatNo);
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
	public Map<String, Object> getChatMember(int chatNo, Member memberId) throws Exception {
		List<ChatMember> list = chatDao.getChatMember(chatNo, memberId);
		
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("list", list);
		
		return map;
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
	public Map<String, Object> listReadyCheckMember(Search search, int chatNo) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search", search);
		//map.put("searchCondition", search.getSearchCondition() );
		//map.put("searchKeyword",  search.getSearchKeyword() );
		//map.put("endRowNum",  search.getEndRowNum() );
		//map.put("startRowNum",  search.getStartRowNum() );
		map.put("chatNo", chatNo);
		
		map.put("list", chatDao.listReadyCheckMember(map));
		map.put("totalCount", chatDao.getTotalCount(search));
		
		return map;
	}

}
