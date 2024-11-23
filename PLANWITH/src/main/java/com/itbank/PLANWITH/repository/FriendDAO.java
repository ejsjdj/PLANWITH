package com.itbank.PLANWITH.repository;

import java.util.List;

import com.itbank.PLANWITH.model.FriendRequestDTO;
import com.itbank.PLANWITH.model.MemberDTO;

public interface FriendDAO {

	List<MemberDTO> selectFriendList(int id);

	List<MemberDTO> selectMemberList(MemberDTO dto);

	int insertFriendRequest(FriendRequestDTO dto);

	List<FriendRequestDTO> selectFriendRequestList(int id);

	int updateFriendRequest(FriendRequestDTO dto);

	FriendRequestDTO selectFriendRequestById(int id);

	int insertFriendforSender(FriendRequestDTO dto);
	
	int insertFriendforReceiver(FriendRequestDTO dto);



}
