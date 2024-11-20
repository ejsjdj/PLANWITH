package com.itbank.PLANWITH.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.service.FriendService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/friends")
@Log4j
public class FriendsController {

	@Autowired private FriendService friendService;
	
	@GetMapping
	public List<MemberDTO> friendList(HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		if(login != null) { return friendService.getFriendList(login.getId()); }
		return null;
	}
	
	@GetMapping("/memberList")
	public List<MemberDTO> memberList(@RequestParam(defaultValue = "") String search) {
		return friendService.getMemberList(search);
	}
}
