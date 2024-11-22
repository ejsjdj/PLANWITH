package com.itbank.PLANWITH.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.PLANWITH.model.LikeDTO;
import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.service.BoardService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/boards")
@Log4j
public class BoardsController {
	
	@Autowired private BoardService boardService;
	
	@GetMapping("/likeBoard/{boardId}")
	public HashMap<String, Object> likeBoard(HttpSession session, LikeDTO dto) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		
		int result = 0;
		if(login != null) {
			dto.setMemberId(login.getId());
			result = boardService.likeBoard(dto);	// 0 이면 추가, 1이면 삭제
		}
		
		HashMap<String, Object> ret = new HashMap<String, Object>();
		ret.put("deleteLike", result);
		
		return ret;
	}
	
}
