package com.itbank.PLANWITH.repository;

import java.util.List;

import com.itbank.PLANWITH.model.FriendRequestDTO;
import com.itbank.PLANWITH.model.MemberDTO;

public interface FriendDAO {

	List<MemberDTO> selectFriendList(int id);

	List<MemberDTO> selectMemberList(String search);

	int insertFriendRequest(FriendRequestDTO dto);

	List<FriendRequestDTO> selectFriendRequestList();

	int updateFriendRequest(FriendRequestDTO dto);



}
