package com.zzupzzup.service.report.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Report;
import com.zzupzzup.service.report.ReportDAO;

@Repository("reportDaoImpl")
public class ReportDAOImpl implements ReportDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public ReportDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("ReportMapper.addReport", report);	
	}

	@Override
	public int checkReport(int reportNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("ReportMapper.checkReport", reportNo);	
	}

	@Override
	public List<Report> listReport(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReportMapper.listReport", map);
	}

	@Override
	public int getTotalCount(int category) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReportMapper.getTotalCount", category);
	}

//	@Override
//	public int getReportCount(Map<String, Object> map) throws Exception {
//		// TODO Auto-generated method stub
//		return sqlSession.selectOne("ReportMapper.getReportCount", map);
//	}
}