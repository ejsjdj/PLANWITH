package com.itbank.PLANWITH.model;

import lombok.Data;

@Data
public class FriendRequestDTO {

	private int id;
	private int sender;
	private int receiver;
	private int state;
	
	private String userid;
	private String nickname;
}
