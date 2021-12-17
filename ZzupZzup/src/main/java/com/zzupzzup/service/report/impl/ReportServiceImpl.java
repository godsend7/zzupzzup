package com.zzupzzup.service.report.impl;

import java.util.List;

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
		return 0;
	}

	@Override
	public int checkReport(boolean check) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Report> listReport(int category) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Report> listMyReport(int category, String memberId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
