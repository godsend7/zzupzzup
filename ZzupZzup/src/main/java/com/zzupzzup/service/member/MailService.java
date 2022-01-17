package com.zzupzzup.service.member;

import javax.servlet.http.HttpServletRequest;

public interface MailService {
	
	public void sendToEmail(String to, HttpServletRequest request) throws Exception;

}
