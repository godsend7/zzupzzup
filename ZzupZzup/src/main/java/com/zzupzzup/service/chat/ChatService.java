package com.zzupzzup.service.chat;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;

public interface ChatService {
	
	// Insert
	public void addChat(Chat chat) throws Exception;
	
	// Select One
	public Chat getChat(int chatNo) throws Exception;
	
	// Select List
	public Map<String, Object> listChat(Search search) throws Exception;
	
	// Update
	public void updateChat(Chat chat) throws Exception;
	
	// Select One
	public Chat getChatEntrance(int chatNo) throws Exception;
	
	// Update
	public void deleteChat(Chat chat) throws Exception;
	
	// Update
	public void updateChatState(Chat chat) throws Exception;
	
	// Select One
	public Chat getChatRecord(int chatNo) throws Exception;
	
	// Update
	public void updateReadyCheck(Chat chat) throws Exception;
	
	// Insert
	public void addChatMember(int chatNo, Member memberId) throws Exception;
	
	// Select One
	public Map<String, Object> getChatMember(int chatNo, Member memberId) throws Exception;
	
	// Update
	public void deleteChatMember(String memberId, int chatNo) throws Exception;
	
	// Select One
	public Map<String, Object> listChatMember(Search search) throws Exception;
	
	// Select One
	public Map<String, Object> listReadyCheckMember(Search search) throws Exception;

}
