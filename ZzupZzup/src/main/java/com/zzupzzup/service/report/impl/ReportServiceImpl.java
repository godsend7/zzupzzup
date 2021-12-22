package com.zzupzzup.service.report.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Report;
import com.zzupzzup.service.report.ReportDAO;
import com.zzupzzup.service.report.ReportService;

@Service("reportServiceImpl")
public class ReportServiceImpl implements ReportService {

	@Autowired
	@Qualifier("reportDaoImpl")
	private ReportDAO reportDao;
	
	public ReportServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		return reportDao.addReport(report);
	}

	@Override
	public int checkReport(int reportNo) throws Exception {
		// TODO Auto-generated method stub
		return reportDao.checkReport(reportNo);
	}

	@Override
	public Map<String, Object> listReport(Search search, int category, String memberId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("category", category);
		map.put("memberId", memberId);		
		
		map.put("list", reportDao.listReport(map));
		map.put("totalCount", reportDao.getTotalCount(category));
		return map;
	}

	@Override
	public int getReportCount(String report, int category) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("report", report);
		map.put("category", category);
		
		return reportDao.getReportCount(map);
	}

}
