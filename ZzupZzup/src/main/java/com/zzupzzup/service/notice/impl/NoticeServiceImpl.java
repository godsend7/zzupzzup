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
		@Qualifier("noticeDAOImpl")
		private NoticeDAO noticeDAO;
		public void setNoticeDAO(NoticeDAO noticeDAO) {
			this.noticeDAO = noticeDAO;
		}
		
		///Constructor
		public NoticeServiceImpl() {
			System.out.println(this.getClass());
		}

		///Method
		public int addNotice(Notice notice) throws Exception {
			return noticeDAO.addNotice(notice);
		}

		public Notice getNotice(int noticeNo) throws Exception {
			return noticeDAO.getNotice(noticeNo);
		}

		public Map<String , Object > listNotice(Search search) throws Exception {
			List<Notice> list= noticeDAO.listNotice(search);
			int totalCount = noticeDAO.getTotalCount(search);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list );
			map.put("totalCount", new Integer(totalCount));
			
			return map;
		}
		
		public int deleteNotice(Notice notice) throws Exception {
			return noticeDAO.deleteNotice(notice);
		}
		
		public void updateNotice(Notice notice) throws Exception {
			noticeDAO.updateNotice(notice);
		}

}
