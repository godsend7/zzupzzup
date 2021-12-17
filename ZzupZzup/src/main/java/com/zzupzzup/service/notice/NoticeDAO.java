package com.zzupzzup.service.notice;

import java.util.List;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;

public interface NoticeDAO {

	// INSERT
	public int addNotice(Notice notice) throws Exception ;

	// SELECT ONE
	public Notice getNotice(int noticeNo) throws Exception ;

	// SELECT LIST
	public List<Notice> listNotice(Search search) throws Exception ;
	
	// SELECT DELETE
	public int deleteNotice(Notice notice) throws Exception ;

	// UPDATE
	public void updateNotice(Notice notice) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
		
		
}
