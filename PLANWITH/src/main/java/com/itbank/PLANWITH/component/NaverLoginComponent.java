package com.itbank.PLANWITH.component;

import java.math.BigInteger;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.SecureRandom;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class NaverLoginComponent {
	
	private String clientId = "jgFSVqThsovLV7enoXu1";
	private String clientSecret = "xodukmmhJ2";
	private String callbackURL = "http://localhost:8080/PLANWITH/member/naverCallback";
	
	// 임의로 state 를 생성하여 네이버에 로그인 URL을 요청하고 콜백주소로 이동한다
	public String getAuthorizationUrl() {
		String state = new BigInteger(130, new SecureRandom()).toString();
		String url = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		url += "&client_id=" + clientId;
		url += "&redirect_uri=" + callbackURL;
		url += "&state=" + state;
		return url;
	}
	
	// 2) 네이버 엑세스 토큰을 획득하기
	public String getAccessToken(String code, String state) throws URISyntaxException {
		String url = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
		url += "&client_id=" + clientId;
		url += "&client_secret=" + clientSecret;
		url += "&redirect_uri=" + callbackURL;
		url += "&code=" + code;
		url += "&state=" + state;
		
		URI uri = new URI(url);
		RestTemplate template = new RestTemplate();
		RequestEntity<String> request = new RequestEntity<String>(HttpMethod.GET, uri);
		ResponseEntity<String> response = template.exchange(request, String.class);
		
		return response.getBody();
	}
	
	// 3) 엑세스 토큰을 이용하여 네이버 프로필 정보를 받아오기
	public String getProfile(String access_Token) throws URISyntaxException {
		String url = "https://openapi.naver.com/v1/nid/me";
		URI uri = new URI(url);
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + access_Token);
		
		RestTemplate template = new RestTemplate();
		RequestEntity<String> request = new RequestEntity<String>(headers, HttpMethod.GET, uri);
		ResponseEntity<String> response = template.exchange(request, String.class);
		
		return response.getBody();
		
	}
	
}
