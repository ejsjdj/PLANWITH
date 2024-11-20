package com.itbank.PLANWITH.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.MessageDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;
import com.itbank.PLANWITH.model.TeamDTO;
import com.itbank.PLANWITH.model.TeamMemberDTO;

@Repository
public interface TeamDAO {

    int insertTeam(TeamDTO teamDTO);	// DB에 team 저장		
    
    int selectRecentTeamId();	// 최근 생성된 teamId를 불러온다             

    int insertTeamMember(TeamMemberDTO teamMemberDTO);	// DB에 teamMember 저장

    int insertMessage(MessageDTO message);

    TeamDTO selectTeamById(int teamId);	// teamId로 해당 team정보를 불러온다

	List<TeamDTO> selectTeamListByMemberId(int memberId);

	TeamDTO selectTeamByInviteCode(String inviteCode);

	List<MemberDTO> selectMemberListByTeamId(int teamId);

	List<ScheduleDTO> selectScheduleListByTeamId(int teamId);

	List<MessageDTO> selectMessageListByTeamId(int teamId);

	void deleteMemberFromTeam(TeamMemberDTO teamMemberDTO);

	int selectTeamMember(TeamMemberDTO teamMemberDTO);

	String selectMemberNicknameById(int memberId);

	void updateTeamName(TeamDTO teamDTO);

	String selectLastSystemMessage(MessageDTO messageDTO);

}
