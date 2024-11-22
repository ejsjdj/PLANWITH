package com.itbank.PLANWITH.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardDTO {
	
	private int id;
	private int memberId;
	private String title;
	private Date writeDate;
	private String content;
	private String tag;
	
	private String memberPhoto;		// member의 profileImg 저장
	private String nickname;		// member의 nickname 저장
	private int like;			// /board/view 에선 좋아요 상태 저장, /board/boardList 에선 좋아요 수 저장
	
	private List<MultipartFile> files;		// 사용자가 업로드할 파일을 저장할 변수
}
