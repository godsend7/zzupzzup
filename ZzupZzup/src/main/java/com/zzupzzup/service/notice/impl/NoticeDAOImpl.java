package com.zzupzzup.service.notice.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.notice.NoticeDAO;

	@Repository("noticeDaoImpl")
	public class NoticeDAOImpl implements NoticeDAO{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public NoticeDAOImpl() {
		System.out.println(this.getClass());
	}

	///Method
	@Override
	public int addNotice(Notice notice) throws Exception {
		return sqlSession.insert("NoticeMapper.addNotice", notice);
	}
	
	@Override
	public Notice getNotice(int noticeNo) throws Exception {
		return sqlSession.selectOne("NoticeMapper.getNotice", noticeNo);
	}
	
	@Override
	public List<Notice> listNotice(Map<String, Object> map) throws Exception {
		
		List<Notice> list = sqlSession.selectList("NoticeMapper.listNotice",map);
		
		return list;
	}
	
	@Override
	public int deleteNotice(int postNo) throws Exception {
		return sqlSession.delete("NoticeMapper.deleteNotice", postNo);
	}
	
	@Override
	public int updateNotice(Notice notice) throws Exception {
		
		return sqlSession.update("NoticeMapper.updateNotice", notice);
	}
	
	@Override
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("NoticeMapper.getTotalCount", search);
	}


}
