package com.zzupzzup.service.chat.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.ChatMember;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Chat;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.chat.ChatDAO;


@Repository("chatDAOImpl")
public class ChatDAOImpl implements ChatDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	
	///Field
	private SqlSession sqlSession;
	
	///Constructor
	public ChatDAOImpl() {
		System.out.println(this.getClass());
	}
	
	///Method
	@Override
	public void addChat(Chat chat) throws Exception {
		sqlSession.insert("ChatMapper.addChat", chat);
	}

	@Override
	public Chat getChat(int chatNo) throws Exception {
		return sqlSession.selectOne("ChatMapper.getChat", chatNo);
	}

	@Override
	public List<Chat> listChat(Search search) throws Exception {
		return sqlSession.selectList("ChatMapper.listChat", search);
	}

	@Override
	public void updateChat(Chat chat) throws Exception {
		sqlSession.update("ChatMapper.updateChat", chat);
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
	public void deleteChat(Chat chat) throws Exception {
		sqlSession.update("ChatMapper.deleteChat", chat);
	}

	@Override
	public void updateChatState(Chat chat) throws Exception {
		sqlSession.update("ChatMapper.updateChatState", chat);
	}

	@Override
	public Chat getChatRecord(int chatNo) throws Exception {
		return sqlSession.selectOne("ChatMapper.getChatRecord", chatNo);
	}

	@Override
	public void updateReadyCheck(Chat chat) throws Exception {
		sqlSession.update("ChatMapper.updateReadyCheck", chat);
	}
	
	@Override
	public void addChatMember(int chatNo, Member memberId) throws Exception {
		sqlSession.insert("ChatMapper.addChatMember", chatNo);
	}
	
	@Override
	public List<ChatMember> getChatMember(int chatNo, Member memberId) throws Exception {
		return sqlSession.selectOne("ChatMapper.getChatMember", chatNo);
	}

	@Override
	public void deleteChatMember(String memberId, int chatNo) throws Exception {
		sqlSession.update("ChatMapper.deleteChat", memberId);
	}

	@Override
	public List<Chat> listChatMember(Search search) throws Exception {
		return sqlSession.selectList("ChatMapper.listChatMember", search);
	}

	@Override
	public List<Chat> listReadyCheckMember(Search search) throws Exception {
		return sqlSession.selectList("ChatMapper.listReadyCheckMember", search);
	}

}
