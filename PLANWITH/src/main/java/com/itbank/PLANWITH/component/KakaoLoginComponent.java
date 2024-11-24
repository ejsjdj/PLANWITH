package com.itbank.PLANWITH.component;

import java.net.URI;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Component
public class KakaoLoginComponent {
	
	private final String appKey = "c4de8c1471cc310029cdf865b1d7382e";
	
	// 임의로 state 를 생성하여 카카오에 로그인 URL을 요청한다
	public String getLoginURI(HttpSession session) {
		String state = UUID.randomUUID().toString().replace("-", "");
		session.setAttribute("kakao_oauth_state", state);
		
		String url = "https://kauth.kakao.com/oauth/authorize";
		url += "?client_id=" + appKey;
		url += "&redirect_uri=http://localhost:8080/PLANWITH/member/kakaoCallback";
		url += "&response_type=code";
		return url;
	}
	
	
	public String getAccessToken(String code) throws Exception {
		String url = "https://kauth.kakao.com/oauth/token";
		URI uri = new URI(url);
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", appKey);
		params.add("redirect_uri", "http://localhost:8080/PLANWITH/member/kakaoCallback");
		params.add("code", code);
		
		RestTemplate template = new RestTemplate();
		RequestEntity<MultiValueMap<String, String>> request = new RequestEntity<>(
				params, headers, HttpMethod.POST, uri
			);
		ResponseEntity<String> response = template.exchange(request, String.class);
		return response.getBody();
	}
	
	public String getProfile(String access_token) throws Exception {
		RestTemplate template = new RestTemplate();
		
		String url = "https://kapi.kakao.com/v2/user/me";
		URI uri = new URI(url);
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + access_token);
		
		RequestEntity<String> request = new RequestEntity<String>(headers, HttpMethod.POST, uri);
		ResponseEntity<String> response = template.exchange(request, String.class);
		return response.getBody();
	}
	
	public String userLogout(String access_token) throws Exception {
		RestTemplate template = new RestTemplate();
		
		String url = "https://kapi.kakao.com/v1/user/logout";
		URI uri = new URI(url);
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + access_token);
		
		RequestEntity<String> request = new RequestEntity<String>(headers, HttpMethod.POST, uri);
		ResponseEntity<String> response = template.exchange(request, String.class); 
		return response.getBody();
	}
	
	public String kakaoLogout() throws Exception {
		RestTemplate template = new RestTemplate();
		
		String url = "https://kauth.kakao.com/oauth/logout";
		url += "?client_id=" + appKey;
		url += "&logout_redirect_uri=http://localhost:8080/PLANWITH/member/logout";
		URI uri = new URI(url);
		
		RequestEntity<MultiValueMap<String, String>> request = new RequestEntity<>(HttpMethod.GET, uri);
		ResponseEntity<String> response = template.exchange(request, String.class);
		System.out.println(response.getStatusCodeValue());	
		return response.getBody();
	}
}
