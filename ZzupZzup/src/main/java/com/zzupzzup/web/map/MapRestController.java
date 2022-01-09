package com.zzupzzup.web.map;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	public List<Restaurant> listRestaurant(HttpServletRequest request, @RequestParam(value="search", required = false) Search search) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		return restaurantService.listMainRestaurant();
	}
	
	@RequestMapping(value = "json/getSimpleRestaurant/{restaurantNo}")
	public Restaurant getSimpleRestaurant(int restaurantNo) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		return restaurant;
	}
	
	@RequestMapping(value = "json/gyeonggidoRestAPI", method = RequestMethod.GET)
	public List<Map<String, Object>> requestRestAPI(Model model) throws Exception {

	  URL url = new URL("https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt?KEY=0584ed7e427d4676a15a4bf7f91b1597&Type=json&pIndex=1&pSize=1000");

	  ObjectMapper mapper = new ObjectMapper();
	  StringBuilder sb = new StringBuilder();
	  BufferedReader br;

	  List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();

	  try {
	    HttpURLConnection con = (HttpURLConnection)url.openConnection();

	    //Request Header 정의
	    con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

	    //전송방식
	    con.setRequestMethod("GET");

	    //서버에 연결되는 Timeout 시간 설정
	    con.setConnectTimeout(5000);

	    //InputStream 읽어 오는 Timeout 시간 설정
	    con.setReadTimeout(5000); 

	    //URLConnection에 대한 doOutput 필드값을 지정된 값으로 설정한다. 
	    //URL 연결은 입출력에 사용될 수 있다. 
	    //URL 연결을 출력용으로 사용하려는 경우 DoOutput 플래그를 true로 설정하고, 
	    //그렇지 않은 경우는 false로 설정해야 한다. 기본값은 false이다.
	    con.setDoOutput(false); 

	    if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
	      br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
	      String line;
	      while ((line = br.readLine()) != null) {
	      sb.append(line).append("\n");
	      }
	      br.close();

	      listMap = mapper.readValue(sb.toString(), new TypeReference<List<Map<String, Object>>>(){});
	      model.addAttribute("listMap", listMap);
	    } else {
	    	model.addAttribute("error", con.getResponseMessage());
	    }
	  } catch (Exception e) {
	  	System.err.println(e.toString());
	  }
	  return listMap;
	}
}
