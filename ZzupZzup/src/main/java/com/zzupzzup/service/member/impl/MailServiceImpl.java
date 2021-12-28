package com.zzupzzup.service.member.impl;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import com.zzupzzup.service.member.MailService;

@Service("mailServiceImpl")
public class MailServiceImpl implements MailService {

	//*Field
	private final String from = "email";			//발신자 이메일
	private final String fromName = "쩝쩝듀스101";						//발신자 이름
	private final String smtpUserName = "email";	//발신자 이메일(서비스 로그인 할 때 쓰는 것 같음)
	private final String smtpPwd = "password";					//발신자 이메일의 비밀번호
	private final String host = "smtp.gmail.com";					//이메일 보내는 서비스
	private final String port = "";									//포트 번호? 뭔지 모르겠음
	private String subject;											//메일 제목
	private String body;											//메일 내용
	
	//*Constructor
	public MailServiceImpl() {
		// TODO Auto-generated constructor stub
	}
	
	//*Method
	@Override
	public void sendToEmail(String to) throws Exception {	//수신자 이메일을 parameter로 받음
		// TODO Auto-generated method stub

		//이메일에 전송될 인증번호 생성 파트
		String certificatedNum = "";
		for(int i = 1; i <= 6; i++) {
	    	Random random = new Random();
	    	certificatedNum += random.nextInt(10);
	    }
		
		//javax.mail에 필요한 local variable
		subject = "[쩝쩝듀스101] 인증번호가 전송되었습니다.";
		body = "안녕하세요. 쩝쩝듀스101입니다.\n\n"+"인증번호 ["+certificatedNum+"]를 입력해주세요.";
		
		Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.port", port); 
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        Session session = Session.getDefaultInstance(props);
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from, fromName));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setContent(body, "text/html;charset=euc-kr");
        
        Transport transport = session.getTransport();
        try {
            System.out.println("전송 중입니다 . . .");
            
            transport.connect(host, smtpUserName, smtpPwd);
            transport.sendMessage(msg, msg.getAllRecipients());
            System.out.println("전송이 완료되었습니다.");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            transport.close();
        }
	}

}