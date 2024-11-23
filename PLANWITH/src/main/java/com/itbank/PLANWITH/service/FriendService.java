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

	public List<MemberDTO> getMemberList(MemberDTO dto) {
//		MemberDTO dto = new memberdto();
//		dto.setid(id);
//		dto.setsearch(search);
		return friendDAO.selectMemberList(dto);
	}

	public int insertFriendRequest(FriendRequestDTO dto) {
		return friendDAO.insertFriendRequest(dto);
	}

	public List<FriendRequestDTO> getFriendRequestList(int id) {
		return friendDAO.selectFriendRequestList(id);
	}

	public int updateFriendRequest(int id, int state) {
		FriendRequestDTO dto = new FriendRequestDTO();
		dto.setId(id);
		dto.setState(state);
		
		return friendDAO.updateFriendRequest(dto);
	}

	public int insertFriend(int id) {
		FriendRequestDTO dto = friendDAO.selectFriendRequestById(id);
		int i = friendDAO.insertFriendforSender(dto);
		int j = friendDAO.insertFriendforReceiver(dto);
		if (i == 1 && j == 1) return 1;
		return 0;
	}
		
}
