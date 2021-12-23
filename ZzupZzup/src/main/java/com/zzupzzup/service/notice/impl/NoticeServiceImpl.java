package com.zzupzzup.service.notice.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Notice;
import com.zzupzzup.service.notice.NoticeService;
import com.zzupzzup.service.notice.NoticeDAO;

	@Service("noticeServiceImpl")
	public class NoticeServiceImpl implements NoticeService{
		
		///Field
		@Autowired
		@Qualifier("noticeDaoImpl")
		private NoticeDAO noticeDao;
		//public void setNoticeDAO(NoticeDAO noticeDAO) {
		//	this.noticeDao = noticeDAO;
		//}
		
		///Constructor
		public NoticeServiceImpl() {
			System.out.println(this.getClass());
		}

		///Method
		@Override
		public int addNotice(Notice notice) throws Exception {
			return noticeDao.addNotice(notice);
		}
		
		@Override
		public Notice getNotice(int noticeNo) throws Exception {
			return noticeDao.getNotice(noticeNo);
		}
		
		@Override
		public Map<String , Object > listNotice(Search search) throws Exception {

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("search", search);
			
			
			map.put("list", noticeDao.listNotice(map));
			map.put("totalCount", noticeDao.getTotalCount(search));
			
			return map;
		}
		
		@Override
		public int deleteNotice(int postNo) throws Exception {
			return noticeDao.deleteNotice(postNo);
		}
		
		@Override
		public int updateNotice(Notice notice) throws Exception {
			return noticeDao.updateNotice(notice);
		}

}
