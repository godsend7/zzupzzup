package com.zzupzzup.service.chat;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;

public interface ChatService {
	
	// Insert
	public int addChat(Chat chat) throws Exception;
	
	// Select One
	public Chat getChat(int chatNo) throws Exception;
	
	// Select List
	public Map<String, Object> listChat(Search search) throws Exception;
	
	// Update
	public int updateChat(Chat chat) throws Exception;
	
	// Select One
	public Chat getChatEntrance(int chatNo) throws Exception;
	
	// Update
	public int deleteChat(Chat chat) throws Exception;
	
	// Update
	public int updateChatState(int chatNo, int chatState) throws Exception;
	
	// Select One
	public Chat getChatRecord(int chatNo) throws Exception;
	
	// Insert
	public int addChatMember(ChatMember chatMember) throws Exception;
	
	// Select One
	public ChatMember getChatMember(int chatNo, String memberId) throws Exception;
	
	// Update
	public int updateChatMember(ChatMember chatMember) throws Exception;
	
	// Update
	public int deleteChatMember(ChatMember chatMember) throws Exception;
	
	// Update
	public int deleteAllChatMember(ChatMember chatMember) throws Exception;
	
	// update
	public int updateReadyCheck(ChatMember chatMember) throws Exception;
	
	// Select List
	public Map<String, Object> listChatMember(Search search, int chatNo) throws Exception;
	
	// Select List
	public Map<String, Object> listReadyCheckMember(int chatNo) throws Exception;

	
	//임시 음식점 찾기
	// Select List
	public Map<String, Object> listRestaurantName(Search search) throws Exception;
		
}
