package com.itbank.PLANWITH.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.itbank.PLANWITH.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class StompFriendController {

	@Autowired private MemberService memberService;
	
	@MessageMapping("/connection")
	@SendTo("/broker/status")
	public String connection(String message) {
		return message;
	}
	
	@MessageMapping("/friendRequest")
	@SendTo("/broker/online") 
	public String friendRequest(String message) {
//		memberService.insertFriendRequest();
		return message;
	}
}