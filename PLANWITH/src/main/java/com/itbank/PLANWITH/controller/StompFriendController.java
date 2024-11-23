package com.itbank.PLANWITH.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.itbank.PLANWITH.model.FriendRequestDTO;
import com.itbank.PLANWITH.service.FriendService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class StompFriendController {

	@Autowired private FriendService friendService;
	
	@MessageMapping("/connection")
	@SendTo("/broker/login")
	public String connection(String message) {
		log.info(message);
		return message;
	}
	
	@MessageMapping("/friendRequest")
	@SendTo("/broker/allMember") 
	public int friendRequest(FriendRequestDTO dto) {
		int row = friendService.insertFriendRequest(dto);
		int message = 0;
		if (row != 0) message = dto.getReceiver();
		return message;
	}
}