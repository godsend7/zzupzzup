package com.zzupzzup.service.notice.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;
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
	public int addNotice(Notice notice) throws Exception {
		return sqlSession.insert("NoticeMapper.addNotice", notice);
	}

	public Notice getNotice(int noticeNo) throws Exception {
		return sqlSession.selectOne("NoticeMapper.getNotice", noticeNo);
	}
	
	public List<Notice> listNotice(Search search) throws Exception {
		return sqlSession.selectList("NoticeMapper.listNotice", search);
	}

	public int deleteNotice(Notice notice) throws Exception {
		return sqlSession.delete("NoticeMapper.deleteNotice", notice);
	}

	public void updateNotice(Notice notice) throws Exception {
		
		sqlSession.update("NoticeMapper.updateNotice", notice);
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("NoticeMapper.getTotalCount", search);
	}


}
