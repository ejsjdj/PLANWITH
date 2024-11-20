package com.itbank.PLANWITH.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.repository.FriendDAO;

@Service
public class FriendService {

	@Autowired private FriendDAO friendDAO;

	public List<MemberDTO> getFriendList(int id) {		
		return friendDAO.selectFriendList(id);
	}

	public List<MemberDTO> getMemberList(String search) {
		return friendDAO.selectMemberList(search);
	}
	
		
}
