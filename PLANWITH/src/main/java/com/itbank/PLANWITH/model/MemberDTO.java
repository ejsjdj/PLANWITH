package com.itbank.PLANWITH.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {

	private int id;
	private String userid;
	private String salt;
	private String hash; 
	private String nickname;
	private String gender;
	private String email;
	private String address;
	
	private String userpw;	// 사용자 비밀번호를 입력받기 위한 변수
	private String snsId;	// SNS 아이디 저장 (네이버 또는 카카오에서 보내주는 정보)
	private String snsType;	// SNS 타입 저장 (네이버 또는 카카오)
	
	private MultipartFile upload;	// 프로필 사진 업로드용
//	private PhotoDTO member_photo;		// 저장된 프로필 사진 정보
	
	private String memberPhoto;	// storedFileName 담을 변수
	
	private int status;		// 로그 상태
	
}
