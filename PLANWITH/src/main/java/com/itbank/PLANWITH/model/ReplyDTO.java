package com.itbank.PLANWITH.model;

import java.sql.Date;

import lombok.Data;


@Data
public class ReplyDTO {
	
	private int id;
	private int memberId;
	private int boardId;
	private String content;
	private Date writeDate;
	private int parentId;
	private int replyDepth;
	
	private String memberPhoto;
	private String nickname;
	
}
