package com.itbank.PLANWITH.service;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class CaptchaService {
	
	private String clientId = "XWuRYQMkZWSbvvTdiDx3";
	private String clientSecret = "Q92qyocTjR";
	private String saveDirectory = "C:\\upload\\captcha";
	private RestTemplate restTemplate = new RestTemplate(); 
	
	public CaptchaService() {
		File dir = new File(saveDirectory);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
	}
	
	// 캡차 정보를 네이버에 요청하여 불러온다
	public String getCapchaKey() throws URISyntaxException {
		String url = "https://openapi.naver.com/v1/captcha/nkey?code=0";
		URI uri = new URI(url);
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Naver-Client-Id", clientId);
		headers.set("X-Naver-Client-Secret", clientSecret);
		RequestEntity<String> request = new RequestEntity<String>(headers, HttpMethod.GET, uri);
		ResponseEntity<String> response = restTemplate.exchange(request, String.class);
		String body = response.getBody();
		return body;
	}
	
	// 키를 이용하여 이미지를 불러와 업로드한 후 파일을 반환한다
	public File getCapchaImage(String captchaKey) throws IOException, URISyntaxException {
		String fileName = UUID.randomUUID().toString().replace("-", "") + ".jpg";
		File f = new File(saveDirectory, fileName);
		String url = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + captchaKey;
		URI uri = new URI(url);
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Naver-Client-Id", clientId);
		headers.set("X-Naver-Client-Secret", clientSecret);
		RequestEntity<String> request = new RequestEntity<String>(headers, HttpMethod.GET, uri);
		ResponseEntity<byte[]> response = restTemplate.exchange(request, byte[].class);
		byte[] arr = response.getBody();
		Files.write(Paths.get(f.getAbsolutePath()), arr);
		return f;
	}

	// 캡차를 검증한다
	public String verifyCapcha(String key, String value) throws URISyntaxException {
		String url = "https://openapi.naver.com/v1/captcha/nkey?code=1&key=" + key + "&value=" + value;
		URI uri = new URI(url);
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Naver-Client-Id", clientId);
		headers.set("X-Naver-Client-Secret", clientSecret);
		RequestEntity<String> request = new RequestEntity<String>(headers, HttpMethod.GET, uri);
		ResponseEntity<String> response = restTemplate.exchange(request, String.class);
		return response.getBody();
	}

}
