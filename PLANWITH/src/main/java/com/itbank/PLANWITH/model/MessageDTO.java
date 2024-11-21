package com.itbank.PLANWITH.model;

import java.sql.Date;

import lombok.Data;

@Data
public class MessageDTO {
	
	   private int id;
	   private int teamId;
	   private int memberId;
	   private String content;
	   private Date sentTime;
	   private int isUser;
	   private String nickname;
	   
	   private String storedFileName;
	   
	   public MessageDTO() {
	   }
	   
	   public MessageDTO(int teamId, int memberId, String content, int isUser) {
	      this.teamId = teamId;
	      this.memberId = memberId;
	      this.content = content;
	      this.isUser = isUser;
	   }
	   
}
