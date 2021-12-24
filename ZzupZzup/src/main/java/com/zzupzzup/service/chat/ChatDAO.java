package com.zzupzzup.service.chat;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;

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
	public int updateChatState(Chat chat) throws Exception;
	
	// Select One
	public Chat getChatRecord(int chatNo) throws Exception;
	
	// Insert
	public int addChatMember(ChatMember chatMember) throws Exception;
	
	// Select One
	public List<ChatMember> getChatMember(int chatNo, Member memberId) throws Exception;
	
	// Update
	public void deleteChatMember(String memberId, int chatNo) throws Exception;
	
	// Update
	public int updateReadyCheck(ChatMember chatMember) throws Exception;
	
	// Select List
	public List<ChatMember> listChatMember(Map<String, Object> map) throws Exception;
	
	// Select List
	public List<ChatMember> listReadyCheckMember(Search search) throws Exception;
}
