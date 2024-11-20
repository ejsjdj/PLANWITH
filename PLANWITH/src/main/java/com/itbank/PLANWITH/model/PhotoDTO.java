package com.itbank.PLANWITH.model;

import lombok.Data;

@Data
public class PhotoDTO {

	private int id;
	private String originalFileName;
	private String storedFileName;
	private String contentType;
	
	private int refId;	// memberId 나 boardId 를 담는다, 테이블에 값을 넣을 때는 #{refId}
	
}
