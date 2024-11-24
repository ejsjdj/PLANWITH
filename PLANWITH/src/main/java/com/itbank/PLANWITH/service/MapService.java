package com.itbank.PLANWITH.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.PLANWITH.model.NaverBlogDTO;
import com.itbank.PLANWITH.model.NaverImageDTO;
import com.itbank.PLANWITH.model.PlaceDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;
import com.itbank.PLANWITH.repository.MapDAO;

@Service
public class MapService {

	private String clientId = "ucPpOaAXwmvP5mLx4Igl";
	private String clientSecret = "2ApBXv540i";
	
	private RestTemplate template = new RestTemplate();
	private ObjectMapper mapper = new ObjectMapper();
	
	@Autowired private MapDAO mapDAO;
	
	public List<NaverBlogDTO> getBlogSearch(String title) {
		try {
			// 네이버 blog 검색을 위한 링크, 쿼리 스트링을 담을 변수 선언, 쿼리스트링에 담을 내용은 한글이므로 utf-8로 인코딩 필요
			String blogSearchUrl = "https://openapi.naver.com/v1/search/webkr.json?query=" + URLEncoder.encode(title, "UTF-8");
			// RestTemplate 인코딩 문제를 피하기 위해서 해당 URL 을 URI 타입으로 변환
			URI blogSearchUri = new URI(blogSearchUrl);
			// 헤더에 필수값 입력
			HttpHeaders headers = new HttpHeaders();
			headers.set("X-Naver-Client-Id", clientId);
			headers.set("X-Naver-Client-Secret", clientSecret);
			// blog 검색을 위한 요청객체 생성
			RequestEntity<String> blogSearchRequest = new RequestEntity<String>(headers, HttpMethod.GET, blogSearchUri);
			// blog API 요청
			ResponseEntity<String> blogSearchResponse = template.exchange(blogSearchRequest, String.class);
			// List<~~DTO>로 값을 담을 때 DTO에 선언한 하지 않은 변수는 담지 않기로 설정(모든 변수를 선언해 놓아서 필요하지 않음)
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			// JsonNode 타입으로 변환
			JsonNode blogJson = mapper.readTree(blogSearchResponse.getBody());
			// 트리구조에서 items 안에 요소들을 선택해 String 으로 처리
			String blogItems = blogJson.get("items").toString();
			// mapper.readValue 함수로 리스트로 변환
			List<NaverBlogDTO> blogList = mapper.readValue(blogItems, new TypeReference<List<NaverBlogDTO>>() {});
			// 컨트롤러에 blogList 리턴
			return blogList;
		} catch (URISyntaxException | UnsupportedEncodingException e) { // URI 생성과정중 예외처리
			e.printStackTrace(); 
		} catch (JsonProcessingException e) { // Json 변환과정중 예외처리
			e.printStackTrace();
		}
		// 만약에 웹페이지에서 블로그 링크가 나오지 않으면 예외가 발생했거나 검색결과가 없기때문임
		return null;
	}

	public List<NaverImageDTO> getImageSearch(String title) {
		try {
			// 네이버 이미지 검색을 위한 링크, 쿼리 스트링을 담을 변수 선언, 쿼리스트링에 담을 내용은 한글이므로 utf-8로 인코딩 필요
			String imageSearchUrl = "https://openapi.naver.com/v1/search/image?query=" + URLEncoder.encode(title, "UTF-8");
			// RestTemplate 인코딩 문제를 피하기 위해서 해당 URL 을 URI 타입으로 변환
			URI imageSearchUri = new URI(imageSearchUrl);
			// 헤더에 필수값 입력
			HttpHeaders headers = new HttpHeaders();
			headers.set("X-Naver-Client-Id", clientId);
			headers.set("X-Naver-Client-Secret", clientSecret);
			// image 검색을 위한 요청객체 생성
			RequestEntity<String> imageSearchRequest = new RequestEntity<String>(headers, HttpMethod.GET, imageSearchUri);
			// image API 요청
			ResponseEntity<String> imageSearchResponse = template.exchange(imageSearchRequest, String.class);
			// List<~~DTO>로 값을 담을 때 DTO에 선언한 하지 않은 변수는 담지 않기로 설정(모든 변수를 선언해 놓아서 필요하지 않음)
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			// JsonNode 타입으로 변환
			JsonNode imageJson = mapper.readTree(imageSearchResponse.getBody());
			// 트리구조에서 items 요소를 선택해 String 으로 저장
			String imageItems = imageJson.get("items").toString();
			// 각 요소들을 NaverImageDTO 를 참고해 리스트로 저장
			List<NaverImageDTO> imageList = mapper.readValue(imageItems, new TypeReference<List<NaverImageDTO>>() {});
			return imageList;
		} catch (URISyntaxException | UnsupportedEncodingException e) { // URI 생성과정중 예외처리
			e.printStackTrace(); 
		} catch (JsonProcessingException e) { // Json 변환과정중 예외처리
			e.printStackTrace();
		}
		// 만약에 웹페이지에서 이미지가 하나도 나오지 않으면 예외가 발생했거나 검색결과가 없기때문임
		return null;
	}
	
	// 스케쥴 들고와서 place의 name, address 로 
	// place가 이미 있는지 검사 후 없으면 insertPlace한다
	public void insertPlace(ScheduleDTO scheduleDTO) {
		String name = scheduleDTO.getTitle();
		String category = "일반";
		String address = scheduleDTO.getAddress();
		PlaceDTO placeDTO = new PlaceDTO(name, category, address);
		
		int result = mapDAO.selectPlace(placeDTO); // 이미 있는지 확인
		if (result == 0) { // 없으면 인서트를 실행
			mapDAO.insertPlace(placeDTO);
		}
	}
	
	// 스케쥴 들고와서 place의 name, address 로 placeId를 검색한다
	public int searchId(ScheduleDTO scheduleDTO) {
		String name = scheduleDTO.getTitle();
		String category = "일반";
		String address = scheduleDTO.getAddress();
		PlaceDTO placeDTO = new PlaceDTO(name, category, address);
		
		return mapDAO.searchId(placeDTO);
	}

	public void insertSchedule(int teamId, ScheduleDTO schedule) {
		
		Date startTime = new Date(schedule.getSt());
		Date endTime = new Date(schedule.getEt());
		schedule.setTeamId(teamId);
		schedule.setStartTime(startTime);
		schedule.setEndTime(endTime);
		
		mapDAO.insertSchedule(schedule);
	}
	
	public void deleteSchedule(ScheduleDTO schedule) {
		mapDAO.deleteSchedule(schedule);
	}

	public List<ScheduleDTO> viewLoad(int teamId) {
		return mapDAO.selectScheduleListByTeamId(teamId);
	}

	public void updateTime(ScheduleDTO scheduleDTO) {
		mapDAO.updateTime(scheduleDTO);
	}

	public int searchPlaceByScheduleId(int id) {
		return mapDAO.selectPlaceIdById(id);
	}

	public PlaceDTO selectPlaceById(int placeId) {
		return mapDAO.selectPlaceById(placeId);
	}
	
}