package com.zzupzzup.service.chat;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.ChatMember;

public interface ChatDAO {
	
	// Insert
	public int addChat(Chat chat) throws Exception;
	
	// Select One
	public Chat getChat(int chatNo) throws Exception;
	
	// Select List
	public List<Chat> listChat(Map<String, Object> map) throws Exception;
	
	// Update
	public int updateChat(Chat chat) throws Exception;
	
	// Page Row(totalCount) return
	public int getTotalCount(Search search) throws Exception;
	
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
	
	// Update
	public int updateReadyCheck(ChatMember chatMember) throws Exception;
	
	// Select List
	public List<ChatMember> listChatMember(Map<String, Object> map) throws Exception;
	
	// Select List
	public List<ChatMember> listReadyCheckMember(Map<String, Object> map) throws Exception;
	
	// Update
	public int updateConnectedChatMember(ChatMember chatMember) throws Exception;
	
	//Update
	public int updateGetOutChatMember(ChatMember chatMember) throws Exception;

}
