package com.itbank.PLANWITH.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.PLANWITH.model.FriendRequestDTO;
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
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		if(login != null) { return friendService.getFriendList(login.getId()); }
		return List.of();	//  비어있는 리스트
	}
	
	@GetMapping("/memberList")
	public List<MemberDTO> memberList(@ModelAttribute MemberDTO dto) {
		return friendService.getMemberList(dto);
	}
	
	@GetMapping("/friendRequestList")
	public List<FriendRequestDTO> friendRequestList(@RequestParam int id) {
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return friendService.getFriendRequestList(id);
	}
	
	@GetMapping("/accept")
	public HashMap<String, Object> friendRequestAccept(@RequestParam int id) {
		int state = 1;
		int row = friendService.updateFriendRequest(id, state);
		row += friendService.insertFriend(id);
		
		HashMap<String, Object> ret = new HashMap<String, Object>();
		ret.put("success", row != 0);
		return ret;
	}
	
	
	@GetMapping("/reject")
	public HashMap<String, Object> friendRequestReject(@RequestParam int id) {
		int state = -1;
		int row = friendService.updateFriendRequest(id, state);
		
		HashMap<String, Object> ret = new HashMap<String, Object>();
		ret.put("success", row != 0);
		return ret;
	}
	
}
