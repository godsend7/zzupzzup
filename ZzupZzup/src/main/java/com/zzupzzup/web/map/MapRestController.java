package com.zzupzzup.web.map;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonArray;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.restaurant.RestaurantService;

@RestController
@RequestMapping("/map/*")
public class MapRestController {
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	RestaurantService restaurantService;
	
	public MapRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(getClass());
	}
	
	@RequestMapping(value = "json/listRestaurant")
	public List<Restaurant> listRestaurant(@RequestBody Search search) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		return restaurantService.listMainRestaurant(search);
	}
	
	@RequestMapping(value = "json/getSimpleRestaurant/{restaurantNo}")
	public Restaurant getSimpleRestaurant(int restaurantNo) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		return restaurant;
	}
	
	@RequestMapping("json/gyeonggidoRestAPI")
	public String gyeonggidoRestAPI(@RequestBody Search search) throws Exception {
		
		System.out.println("/map/json/gyeonggidoRestAPI : POST");
		
		System.out.println(search);
		
		//List<String> line = null;
		StringBuffer result = new StringBuffer();
		try {
			StringBuilder urlBuilder = new StringBuilder("https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt");
			urlBuilder.append("?" + URLEncoder.encode("KEY", "UTF-8") + "=" + "0584ed7e427d4676a15a4bf7f91b1597");
			urlBuilder.append("&Type=json");
			urlBuilder.append("&" + URLEncoder.encode("pIndex", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("pSize", "UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8"));
			
//			if (condition) {
				//urlBuilder.append("&" + URLEncoder.encode("RESTRT_NM", "UTF-8") + "=" + request.getParameter("name")); 
//			}
				
			System.out.println(urlBuilder);
			
			URL url = new URL(urlBuilder.toString());
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			
			BufferedReader rd = null;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			
			String line = null;
			while ((line = rd.readLine()) != null) {
				//System.out.println("확인" + line);
				line = gyeonggiParseData(line, search);
				result.append(line + "\n");
				
				System.out.println("출력 결과 확인 :: " + result);
			}
			
			rd.close();
			conn.disconnect();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	  return result+"";
	}
	
	//OpenAPI 데이터 파싱
	private String gyeonggiParseData(String jsonData, Search search) {
		
		StringBuffer returnData = new StringBuffer();
		ObjectMapper mapper = new ObjectMapper();
		List<String> list = null;
		
		try {
			JSONParser jsonParse = new JSONParser(); 
			
			//JSONParse에 json데이터를 넣어 파싱한 다음 JSONObject로 변환한다. 
			JSONObject jsonObj = (JSONObject) jsonParse.parse(jsonData); 
			
			//JSONObject에서 PersonsArray를 get하여 JSONArray에 저장한다. 
			JSONArray personArray = (JSONArray) jsonObj.get("PlaceThatDoATasteyFoodSt"); 
			JSONObject rowObj = (JSONObject) personArray.get(1); 
			JSONArray restaurantArray = (JSONArray) rowObj.get("row"); 
			
			//System.out.println("row :: " + restaurantArray);
			
			JSONArray newArray = new JSONArray();
			for(int i=0; i < restaurantArray.size(); i++) { 
				//System.out.println("======== person : " + i + " ========"); 
				JSONObject personObject = (JSONObject) restaurantArray.get(i); 
				
				if ("0".equals(search.getSearchCondition())) {
					if (personObject.get("RESTRT_NM").toString().contains(search.getSearchKeyword())) {
						//String apen = (String) restaurantArray.get(i);
						//JsonNode json = mapper.readTree((JsonParser) restaurantArray.get(i));
						newArray.add(personObject);
						
						//System.out.println("appen!!");
						//list.add(restaurantArray.get(i).)
					}
					
					//System.out.println(personObject.get("RESTRT_NM")); 
					//System.out.println(personObject.get("RESTRT_NM").toString());
				} else if ("1".equals(search.getSearchCondition())) {
					if (personObject.get("REFINE_ROADNM_ADDR").toString().contains(search.getSearchKeyword())) {
						//String apen = (String) restaurantArray.get(i);
						//JsonNode json = mapper.readTree((JsonParser) restaurantArray.get(i));
						newArray.add(personObject);
						
						//System.out.println("appen!!");
						//list.add(restaurantArray.get(i).)
					}
					
					//System.out.println(personObject.get("SIGUN_NM")); 
					//System.out.println(personObject.get("REFINE_LOTNO_ADDR")); 
				}
			}
			
			if (search.getSearchKeyword() != null) {
				returnData.append(newArray);
			} else {
				returnData.append(restaurantArray);
			} 
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return returnData+"";
	}	
}
