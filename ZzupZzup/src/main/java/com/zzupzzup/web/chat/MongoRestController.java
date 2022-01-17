package com.zzupzzup.web.chat;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//수기로 넣어줌
import static com.mongodb.client.model.Filters.eq;

import org.bson.Document;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

@RestController
@RequestMapping("/mongo/*")
public class MongoRestController {
	
	///Field
	private MongoClient mongoClient;
	private MongoDatabase database;
	private MongoCollection<Document> collection;
	private String mongoURI;
	
	
	/// setter Method
	public MongoRestController() {
		System.out.println(this.getClass() + " MongoDB 연결됨");
		this.mongoURI = "mongodb+srv://zzupzzup:zzup2022@cluster0.m3cc8.mongodb.net/";
		this.mongoClient = MongoClients.create(mongoURI);
		this.database = mongoClient.getDatabase("zzupzzup");
	}
	
	@RequestMapping(value = "json/getChatCon/{chatNo}", method = RequestMethod.GET)
	public List<Document> getChatCon(@PathVariable int chatNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/mongo/json/getChatCon : GET");
		System.out.println("chatNo : " + chatNo);
		
		collection = database.getCollection("chats");
		List<Document> docs = new ArrayList<Document>();
		
		try {
			//첫줄만 보이기
			Document doc = collection.find(eq("chatNo",chatNo)).first();
			System.out.println(doc.toJson());
			
			//모든 디비 limit() 번까지 불르기
			collection = database.getCollection("chats");
			BasicDBObject query = new BasicDBObject("chatNo", chatNo);
			FindIterable<Document> fit = collection.find(query).sort(new BasicDBObject("regDate",1));
			fit.into(docs);
			for(Document dok : docs) {
				System.out.println("채팅방 ID가 " + chatNo + "인 채팅 메세지 : " + dok);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return docs;
	}

}