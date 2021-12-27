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
	public int updateChatState(Chat chat) throws Exception;
	
	// Select One
	public Chat getChatRecord(int chatNo) throws Exception;
	
	// Insert
	public int addChatMember(ChatMember chatMember) throws Exception;
	
	// Select One
	public Map<String, Object> getChatMember(int chatNo, Member memberId) throws Exception;
	
	// Delete
	public int deleteChatMember(ChatMember chatMember) throws Exception;
	
	// update
	public int updateReadyCheck(ChatMember chatMember) throws Exception;
	
	// Select One
	public Map<String, Object> listChatMember(Search search, int chatNo) throws Exception;
	
	// Select One
	public Map<String, Object> listReadyCheckMember(Search search, int chatNo) throws Exception;

}
