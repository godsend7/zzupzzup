package com.zzupzzup.common.util;

import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class SendMessage {
	
	public void sendMessage() {}
	
	 public void sendMessage(String phone, String text) {
		    
		 	String api_key = "NCSNKY0LCPXFSTX8";
		    String api_secret = "JRFMP2VNN1JPWKAQS7XQSILZ1NI6TKAR";
		    Message coolsms = new Message(api_key, api_secret);

		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    String phNum=
			params.put("to", phone);
			 
			params.put("from", "010-8256-2987");
			params.put("type", "SMS");
			params.put("text", text);
			params.put("app_version", "test app 1.2"); // application name and version

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		  }
		

}
