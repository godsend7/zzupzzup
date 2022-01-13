package com.zzupzzup.service.chat.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.ChatMember;
import com.zzupzzup.service.chat.ChatDAO;


@Repository("chatDaoImpl")
public class ChatDAOImpl implements ChatDAO {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///Constructor
	public ChatDAOImpl() {
		System.out.println(this.getClass());
	}
	
	///Method
	@Override
	public int addChat(Chat chat) throws Exception {
		int result = sqlSession.insert("ChatMapper.addChat", chat);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public Chat getChat(int chatNo) throws Exception {
		return sqlSession.selectOne("ChatMapper.getChat", chatNo);
	}
	
	@Override
	public int updateChat(Chat chat) throws Exception {
		int result = sqlSession.update("ChatMapper.updateChat", chat);
		
		System.out.println("updateChat " + result);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public List<Chat> listChat(Map<String, Object> map) throws Exception {
		System.out.println("chatDaoImpl listChat map : " + map);
		
		List<Chat> list = sqlSession.selectList("ChatMapper.listChat", map);
		
		return list;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ChatMapper.getTotalCount", search);
	}

	@Override
	public Chat getChatEntrance(int chatNo) throws Exception {
		return sqlSession.selectOne("ChatMapper.getChatEntrance", chatNo);
	}

	@Override
	public int deleteChat(Chat chat) throws Exception {
		int result = sqlSession.update("ChatMapper.deleteChat", chat);
		
		System.out.println("deleteChat " + result);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public int updateChatState(int chatNo, int chatState) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatNo", chatNo);
		map.put("chatState", chatState);
		
		int result = sqlSession.update("ChatMapper.updateChatState", map);
		
		System.out.println("updateChatState" + result);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public Chat getChatRecord(int chatNo) throws Exception {
		return sqlSession.selectOne("ChatMapper.getChatRecord", chatNo);
	}
	
	@Override
	public int addChatMember(ChatMember chatMember) throws Exception {
		int result = sqlSession.insert("ChatMapper.addChatMember", chatMember);
		
		System.out.println("addChatMember" + result);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}
	
	@Override
	public ChatMember getChatMember(int chatNo, String memberId) throws Exception {		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatNo", chatNo);
		map.put("memberId", memberId);
		
		return sqlSession.selectOne("ChatMapper.getChatMember", map);
	}
	
	@Override
	public int updateChatMember(ChatMember chatMember) throws Exception {
		return sqlSession.update("ChatMapper.updateChatMember", chatMember);
	}

	@Override
	public int deleteChatMember(ChatMember chatMember) throws Exception {
		return sqlSession.update("ChatMapper.deleteChatMember", chatMember);
	}
	
	@Override
	public int deleteAllChatMember(ChatMember chatMember) throws Exception {
		return sqlSession.update("ChatMapper.deleteAllChatMember", chatMember);
	}
	
	@Override
	public int updateReadyCheck(ChatMember chatMember) throws Exception {
		int result = sqlSession.update("ChatMapper.updateReadyCheck", chatMember);
		
		System.out.println("updateReadyCheck" + result);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public List<ChatMember> listChatMember(Map<String, Object> map) throws Exception {
		System.out.println("chatDaoImpl listChatMember map : " + map);
		List<ChatMember> list = sqlSession.selectList("ChatMapper.listChatMember", map);
		
		return list;
	}

	@Override
	public List<ChatMember> listReadyCheckMember(Map<String, Object> map) throws Exception {
		System.out.println("chatDaoImpl listReadyCheckMember map : " + map);
		List<ChatMember> list = sqlSession.selectList("ChatMapper.listReadyCheckMember", map);
		
		return list;
	}
	
	@Override
	public int updateConnectedChatMember(ChatMember chatMember) throws Exception {
		int result = sqlSession.update("ChatMapper.updateConnectedChatMember", chatMember);
		
		System.out.println("updateConnectedChatMember" + result);
		
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}


}
