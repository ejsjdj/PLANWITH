package com.itbank.PLANWITH.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class MessageDTO {
	
	   private int id;
	   private int teamId;
	   private int memberId;
	   private String content;
	   private Timestamp sentTime;
	   private int isUser;
	   private String nickname;
	   
	   private String storedFileName;
	   
	   public MessageDTO() {
		    this.sentTime = new Timestamp(System.currentTimeMillis()); 
	   }
	   
	   public MessageDTO(int teamId, int memberId, String content, int isUser) {
	      this.teamId = teamId;
	      this.memberId = memberId;
	      this.content = content;
	      this.isUser = isUser;
	      this.sentTime = new Timestamp(System.currentTimeMillis());
	   }
	   
	   public String getFormattedTime() {
	      if (sentTime != null) {
	         SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss"); 
	         return sdf.format(sentTime);
	      }
	      return ""; 
	   }
    
	   
}
