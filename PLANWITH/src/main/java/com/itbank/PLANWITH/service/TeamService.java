package com.itbank.PLANWITH.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.MessageDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;
import com.itbank.PLANWITH.model.TeamDTO;
import com.itbank.PLANWITH.model.TeamMemberDTO;
import com.itbank.PLANWITH.repository.TeamDAO;

@Service
public class TeamService {
	
	@Autowired private TeamDAO teamDAO;
	
	// team을 생성하고 login객체를 해당 teamMember에 추가한다
	public int insertTeamAndInsertMember(MemberDTO login) {		
		TeamDTO teamDTO = createTeam(login.getNickname());
        // 생성된 team에 사용자(login)를 연결하고(생성자 이용), teamMember를 DB에 저장한다
        TeamMemberDTO teamMemberDTO = new TeamMemberDTO(teamDTO.getId(), login.getId());
        int row = teamDAO.insertTeamMember(teamMemberDTO);   
        // 시스템메시지(type = 0) 생성 후 (생성자 이용), DB에 저장
        String content = login.getNickname() + "님이 팀을 생성하였습니다";	// 메시지 내용
        row += insertSystemMessage(teamDTO.getId(), login.getId(), content);
 
        return row;	// 결과 반환
	}
	
	// 초대코드를 생성하여 team을 만들고 DB에 저장
	public TeamDTO createTeam(String nickname) {
		String inviteCode = UUID.randomUUID().toString().replace("-", "").substring(0, 6);
		
		TeamDTO teamDTO = new TeamDTO();
		teamDTO.setName(nickname + "님의 일정");
		teamDTO.setInviteCode(inviteCode);
		
		teamDAO.insertTeam(teamDTO);
		teamDTO.setId(teamDAO.selectRecentTeamId());
		
		return teamDTO;
	}
	
//	public int insertTeamMember(TeamMemberDTO teamMemberDTO) {
//    	return teamDAO.insertTeamMember(teamMemberDTO);
//    }	
	
	// 시스템 메시지 insert
	public int insertSystemMessage(int teamId, int memberId, String content) {
        MessageDTO systemMessage = new MessageDTO(teamId, memberId, content, 0);
        return teamDAO.insertMessage(systemMessage);
	}
	// 메세지를 DB에 저장
	public int insertMessage(MessageDTO message) {
		return teamDAO.insertMessage(message);
	}	
	
	// team 목록을 불러온다
	public List<TeamDTO> selectTeamListByMemberId(int memberId) {
		return teamDAO.selectTeamListByMemberId(memberId);
	}	
	
	// 초대코드로 팀을 불러온다
	public TeamDTO selectTeamByInviteCode(String inviteCode) {
		return teamDAO.selectTeamByInviteCode(inviteCode);
	}
	
	// 팀 생성하면서 teamId도 저장하고 들고 오는 메서드 
    public TeamDTO insertTeam(TeamDTO teamDTO) {
        teamDAO.insertTeam(teamDTO);  
        int teamId = teamDAO.selectRecentTeamId();  // 방금 생성한 teamId 가져와서
        teamDTO.setId(teamId);  // id 저장됨!
        return teamDTO;
    }
	public TeamDTO selectTeamById(int teamId) {
		return teamDAO.selectTeamById(teamId);
	}
	
	public List<MemberDTO> selectMemberListByTeamId(int teamId) {
		return teamDAO.selectMemberListByTeamId(teamId);
	}

	public List<ScheduleDTO> selectScheduleListByTeamId(int teamId) {
		return teamDAO.selectScheduleListByTeamId(teamId);
	}

	public List<MessageDTO> selectMessageListByTeamId(int teamId) {
		return teamDAO.selectMessageListByTeamId(teamId);
	}



	public void deleteMemberFromTeam(int teamId, int memberId) {
		TeamMemberDTO teamMemberDTO = new TeamMemberDTO(teamId, memberId);
		teamDAO.deleteMemberFromTeam(teamMemberDTO);
	}

	public void updateTeamName(int teamId, String newTeamName) {
		TeamDTO teamDTO = new TeamDTO();
		teamDTO.setId(teamId);
		teamDTO.setName(newTeamName);
		
		teamDAO.updateTeamName(teamDTO);
	}

//	public String selectMemberNicknameById(int memberId) {
//		return teamDAO.selectMemberNicknameById(memberId);
//	}

	public boolean isMemberOfTeam(int teamId, int memberId) {
		TeamMemberDTO teamMemberDTO = new TeamMemberDTO(teamId, memberId);
		
		int row = teamDAO.selectTeamMember(teamMemberDTO);
		System.out.println("row: " + row);
		return row > 0;	
	}

	public String selectLastSystemMessage(MessageDTO messageDTO) {
		return teamDAO.selectLastSystemMessage(messageDTO);
	}

	// 멤버가 팀에 없다면 멤버를 insert하고 시스템메시지도 insert하고 true 반환
	public boolean insertMemberIfNotExists(int teamId, MemberDTO memberDTO) {
		int memberId = memberDTO.getId();
		
		if (!isMemberOfTeam(teamId, memberId)) {	// 팀의 멤버가 아니였다면?
			
	        TeamMemberDTO teamMemberDTO = new TeamMemberDTO(teamId, memberId); 
	        teamDAO.insertTeamMember(teamMemberDTO);		// 멤버를 팀에 insert
	        insertJoinSystemMessage(teamId, memberDTO);
	        return true;
		}
		return false;
	}
	
	// 시스템메시지 생성하고 반환
	public MessageDTO insertJoinSystemMessage(int teamId, MemberDTO memberDTO) {
		MessageDTO systeamMessage = new MessageDTO(teamId, memberDTO.getId(), memberDTO.getNickname() + "님이 팀에 참여하였습니다", 0);
		teamDAO.insertMessage(systeamMessage);
		return systeamMessage;
	}
	
	// 탈퇴메시지 insert, 
	public String insertExitMessageAndDeleteMember(int teamId, int memberId) {
		teamDAO.deleteMemberFromTeam(new TeamMemberDTO(teamId, memberId));
		String memberNickname = teamDAO.selectMemberNicknameById(memberId);
		String content = memberNickname + "님이 팀에서 나갔습니다";
		insertSystemMessage(teamId, memberId, content);
		return content;
	}
	
	
	public int insertTeamMember(TeamMemberDTO teamMemberDTO) {
    	return teamDAO.insertTeamMember(teamMemberDTO);
    }	
	
	public String selectMemberNickNameById(int memberId) {
		return teamDAO.selectMemberNicknameById(memberId);
	}
}
