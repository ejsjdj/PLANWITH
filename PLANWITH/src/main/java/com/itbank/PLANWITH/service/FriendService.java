package com.itbank.PLANWITH.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.PLANWITH.model.FriendRequestDTO;
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

	public int insertFriendRequest(FriendRequestDTO dto) {
		return friendDAO.insertFriendRequest(dto);
	}

	public List<FriendRequestDTO> getFriendRequestList() {
		return friendDAO.selectFriendRequestList();
	}

	public int updateFriendRequest(int id, int state) {
		FriendRequestDTO dto = new FriendRequestDTO();
		dto.setId(id);
		dto.setState(state);
		
		return friendDAO.updateFriendRequest(dto);
	}
		
}
