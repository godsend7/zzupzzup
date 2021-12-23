package com.zzupzzup.service.notice;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;

public interface NoticeService {

	// INSERT
	public int addNotice(Notice notice) throws Exception ;

	// SELECT ONE
	public Notice getNotice(int noticeNo) throws Exception ;

	// SELECT LIST
	public Map<String, Object> listNotice(Search search) throws Exception ;
	
	// SELECT DELETE
	public int deleteNotice(int postNo) throws Exception ;

	// UPDATE
	public int updateNotice(Notice notice) throws Exception ;
			

}
