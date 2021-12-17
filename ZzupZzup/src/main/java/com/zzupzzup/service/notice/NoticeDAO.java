package com.zzupzzup.service.notice;

import java.util.List;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;
import com.zzupzzup.service.domain.Reservation;

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
		
}
