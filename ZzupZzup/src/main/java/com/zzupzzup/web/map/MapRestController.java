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
import org.springframework.http.HttpHeaders;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
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
	
//	@RequestMapping(value = "json/getSimpleRestaurant/{restaurantNo}")
//	public Restaurant getSimpleRestaurant(int restaurantNo) throws Exception {
//		
//		System.out.println("/map/json/listRestaurant : Service");
//		
//		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
//		
//		return restaurant;
//	}
	
	@CrossOrigin("http://127.0.0.1:8070")
	@RequestMapping(value = "json/getDirections")
	public String getDirections(HttpServletRequest request, @RequestHeader HttpHeaders headers) throws Exception {

		System.out.println("/map/json/getDirections : GET");
		
		System.out.println(request.getParameter("startLat")); 
		System.out.println(request.getParameter("startLong"));
		System.out.println(request.getParameter("goalLat"));
		System.out.println(request.getParameter("goalLong"));
		
//		curl "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start=127.1058342,37.359708&goal=129.075986,35.179470&option=trafast"\
		
		System.out.println(headers);
				
		StringBuffer result = new StringBuffer();
//		try {
//			StringBuilder urlBuilder = new StringBuilder("https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving");
//			urlBuilder.append("?" + URLEncoder.encode("start", "UTF-8") + "=" + request.getParameter("startLong") + "," + request.getParameter("startLat"));
//			urlBuilder.append("&" + URLEncoder.encode("goal", "UTF-8") + "=" + request.getParameter("goalLong") + "," + request.getParameter("goalLat"));
//			urlBuilder.append("&option=trafast");
//			
//			
//			System.out.println(urlBuilder);
//			
//			URL url = new URL(urlBuilder.toString());
//			
//			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
//			conn.setRequestMethod("GET");
//			conn.setRequestProperty("x-ncp-apigw-api-key-id", "7gzdb36t5o");
//			conn.setRequestProperty("x-ncp-apigw-api-key", "mYUAOPlY0TCwBzBjBZhMfMCX7vKouQIWJJDG9kwL");
//			
//			
//			BufferedReader rd = null;
//			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
//			} else {
//				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//			}
//			
//			
//			String line = null;
//			while ((line = rd.readLine()) != null) {
//				//System.out.println("확인" + line);
//				//line = gyeonggiParseData(line, search);
//				result.append(line + "\n");
//				
//				System.out.println("출력 결과 확인 :: " + result);
//			}
//			
//			rd.close();
//			conn.disconnect();
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
		
		return result+"";
	}
	
	
	@RequestMapping(value = "json/listRestaurant")
	public List<Restaurant> listRestaurant(@RequestBody Search search) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		return restaurantService.listMainRestaurant(search);
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
	
	@RequestMapping(value ="json/listRestaurantName", method = RequestMethod.GET)
	public List<Restaurant> listRestaurantName(@RequestParam("keyWord") String keyword) throws Exception {
		
		List<Restaurant> list = new ArrayList<Restaurant>();
		
		Search search = new Search();
		search.setSearchKeyword(keyword);
		search.setSearchCondition("0");
		
		String gyeonggiList = gyeonggidoRestAPI(search);
		
		System.out.println("다시 확인 ~~~~ " + gyeonggiList);
		
		try {
			JSONParser jsonParse = new JSONParser(); 
			
			//JSONParse에 json데이터를 넣어 파싱한 다음 JSONObject로 변환한다. 
			JSONArray jsonArray = (JSONArray) jsonParse.parse(gyeonggiList); 
			
			System.out.println("파싱 후 확인 :: " + jsonArray);
			
			for(int i=0; i < jsonArray.size(); i++) { 
				Restaurant restaurant = new Restaurant();
				JSONObject personObject = (JSONObject) jsonArray.get(i); 
				System.out.println("======== " + i + " ========");
				System.out.println(personObject.get("RESTRT_NM"));
				System.out.println(personObject.get("REFINE_WGS84_LAT"));
				System.out.println(personObject.get("REFINE_WGS84_LOGT"));
				
				restaurant.setRestaurantName(personObject.get("RESTRT_NM").toString());
				restaurant.setLatitude(personObject.get("REFINE_WGS84_LAT").toString());
				restaurant.setLongitude(personObject.get("REFINE_WGS84_LOGT").toString());
				restaurant.setStreetAddress(personObject.get("REFINE_ROADNM_ADDR").toString());
				restaurant.setRestaurantTel(personObject.get("TASTFDPLC_TELNO").toString());
				
				list.add(restaurant);
			}
			
			//list.addAll(jsonArray);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		Map<String, Object> map = restaurantService.listRestaurantName(search);
		
		list.addAll((List<Restaurant>) map.get("list"));
		
		return list;
	}
	
	
	//OpenAPI 데이터 파싱
	private String gyeonggiParseData(String jsonData, Search search) {
		
		StringBuffer returnData = new StringBuffer();
		
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
