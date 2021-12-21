package com.zzupzzup.service.chat.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.chat.ChatDAO;

@Repository("chatDaoImpl")
public class ChatDAOImpl implements ChatDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public ChatDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addChat(Chat chat) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Chat getChat(int chatNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Chat> listChat(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateChat(Chat chat) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Chat getChatEntrance(int chatNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteChat(Chat chat) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateChatState(Chat chat) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Chat getChatRecord(int chatNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateReadyCheck(Chat chat) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteChatMember(Chat chat) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Chat> listChatMember(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Chat> listReadyCheckMember(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
