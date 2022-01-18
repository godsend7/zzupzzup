package com.zzupzzup.service.member.impl;

import java.io.File;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.zzupzzup.service.member.MailService;

@Service("mailServiceImpl")
public class MailServiceImpl implements MailService {

	//*Field
	private final String from = "zzupzzup101@gmail.com";			//발신자 이메일
	private final String fromName = "쩝쩝듀스101";						//발신자 이름
	private final String smtpUserName = "zzupzzup101@gmail.com";	//발신자 이메일(서비스 로그인 할 때 쓰는 것 같음)
	//private final String smtpPwd = "dlfnbqhwlcysodtj";				//발신자 이메일의 비밀번호(앱 비밀번호 이용)
	private final String smtpPwd = "resztnfcuvgpsxuq";				//발신자 이메일의 비밀번호(앱 비밀번호 이용)
	private final String host = "smtp.gmail.com";					//이메일 보내는 서비스
	private final String port = "587";								//메일 고유 포트 번호(구글은 587)
	private String subject;											//메일 제목
	private String body;											//메일 내용
	
	//*Constructor
	public MailServiceImpl() {
		// TODO Auto-generated constructor stub
	}
	
	//*Method
	@Override
	public void sendToEmail(String to, HttpServletRequest request) throws Exception {	//수신자 이메일을 parameter로 받음
		// TODO Auto-generated method stub

//		//이메일에 전송될 인증번호 생성 파트
//		String certificatedNum = "";
//		for(int i = 1; i <= 6; i++) {
//	    	Random random = new Random();
//	    	certificatedNum += random.nextInt(10);
//	    }
		
		//javax.mail에 필요한 local variable
		subject = "[쩝쩝듀스101] 비밀번호 재설정 링크가 전송되었습니다.";
//		body = "안녕하세요. 쩝쩝듀스101입니다.\n"+"아래 링크로 접속하여 비밀번호를 설정하여 주세요. \n\n"
//				+ "http://localhost:8080/member/setPassword.jsp?memberId="+to;
//		body = "<div align='center'>"
//				+ "<img src='/favicon.ico'><br/>"
//				+ "안녕하세요. 쩝쩝듀스101입니다.<br/>"
//				+ "아래 버튼을 클릭 하여 비밀번호를 설정해주세요.<br/><br/>"
//				+ "<a href='" + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/member/setPassword.jsp?memberId="+to+"'>"
//				+ "<input type='button' class='button primary' value='비밀번호 재설정'>"
//				+ "</a>"
//				+ "</div>";
		body = "<!DOCTYPE HTML><html><head>"
//				+"<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\"><link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin><link href=\"https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap\" rel=\"stylesheet\">"
				+ "<style> .button.primary { background-color: #f56a6a; box-shadow: none; color: #ffffff; box-radius: 20px; width: 150px; height: 40px; text-align:center; font-size: 15px;}</style></head>"
				+ "<body class='is-preload'><div id='wrapper'><div id='main'><div class='inner'>"
				+ "<section id='reset-pwd-body'><div class='container'>"
				+ "<div align='center'>"
				+ "<img src='https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/favicon.ico'><br/><h4>안녕하세요. 쩝쩝듀스101입니다.<br/>아래 버튼을 클릭 하여 비밀번호를 설정해주세요.</h4>"
				+ "<a href='" + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/member/setPassword.jsp?memberId="+to+"'><input type='button' class='button primary' value='비밀번호 재설정'>"
				+ "</a></div>"
				+ "</div></section></div></div></div></body></html>";
		
		Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.port", port); 
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.trust", host);
        Session session = Session.getDefaultInstance(props);
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from, fromName));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setContent(body, "text/html;charset=UTF-8");
        /*
        //메일에 이미지 삽입
        MimeMultipart multipart = new MimeMultipart("related");
        //* first part  (the html)
        BodyPart msgBodyPart = new MimeBodyPart();
        String htmlText = "<!DOCTYPE HTML><html><head><jsp:include page='/layout/toolbar.jsp'/></head>"
				+ "<body class='is-preload'><div id='wrapper'><div id='main'><div class='inner'>"
				+ "<section id='reset-pwd-body'><div class='container'>"
				+ "<div align='center'>"
				+ "<img src='cid:imagePath'><br/>안녕하세요. 쩝쩝듀스101입니다.<br/>아래 버튼을 클릭 하여 비밀번호를 설정해주세요.<br/><br/>"
				+ "<a href='" + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/member/setPassword.jsp?memberId="+to+"'><input type='button' class='button primary' value='비밀번호 재설정'>"
				+ "</a></div>"
				+ "</div></section></div></div></div></body></html>";
        msgBodyPart.setContent(htmlText, "text/html; charset=UTF-8");
        //* add it
        multipart.addBodyPart(msgBodyPart);
        //* second part (the image)
        msgBodyPart = new MimeBodyPart();
        String imagePath = "https://zzupzzup.s3.ap-northeast-2.amazonaws.com/common/favicon.ico";
        
        DataSource fds = new FileDataSource(imagePath);
        msgBodyPart.setDataHandler(new DataHandler(fds));
        msgBodyPart.setHeader("Content-ID","<imagePath>");
        //* add it
        multipart.addBodyPart(msgBodyPart);
        //* put everything together
        msg.setContent(multipart);
        */
        Transport transport = session.getTransport();
        try {
            System.out.println("전송 중입니다 . . .");
            

            //System.out.println("link :: '" + request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/member/setPassword.jsp?memberId="+to+"'");

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
