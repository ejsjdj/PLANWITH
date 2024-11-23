package com.itbank.PLANWITH.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.MessageDTO;
import com.itbank.PLANWITH.model.PhotoDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;
import com.itbank.PLANWITH.service.MapService;
import com.itbank.PLANWITH.service.MemberService;
import com.itbank.PLANWITH.service.TeamService;

@Controller
public class StompTeamController {
	
	@Autowired private TeamService teamService;
	@Autowired private MapService mapService;
	@Autowired private MemberService memberService;
	@Autowired SimpMessagingTemplate template;
	
	// 팀에 입장할 때 기존 메시지들을 불러오기 (채팅과 시스템 메시지 구분)
	@MessageMapping("/enterTeam/{teamId}")
	public void enterTeam(@DestinationVariable int teamId, @Payload MemberDTO memberDTO) {
	    // 기존 메시지들 가져오기 (채팅과 시스템 메시지 구분)
	    List<MessageDTO> messageList = teamService.selectMessageListByTeamId(teamId);

	    // 메시지를 클라이언트에 전송
	    template.convertAndSend("/broker/team/" + teamId, messageList);
	}
//	
    // 새로운 멤버가 팀에 처음 합류할 때 알림 전송
	@MessageMapping("/join/{teamId}")
	public void joinTeam(@DestinationVariable int teamId, @Payload MemberDTO memberDTO) {
	    boolean isNewMember = teamService.insertMemberIfNotExists(teamId, memberDTO);

	    if (isNewMember) {	// 새로운 멤버였다면? = 팀의 기존 멤버가 아니였다면?
	    	MessageDTO systeamMessage = teamService.insertJoinSystemMessage(teamId, memberDTO);	// 참여했다는 시스템 메시지를 insert하고 들고와서
	        template.convertAndSend("/broker/team/" + teamId, systeamMessage);	// 채팅 메시지로 보냄!
	        
	        // 새로운 멤버 추가 후 현재 팀 멤버 목록 갱신 전송
	        List<MemberDTO> updatedMemberList = teamService.selectMemberListByTeamId(teamId);
	        template.convertAndSend("/broker/team/members/" + teamId, updatedMemberList);
	    }
	}

	// 팀에서 나가면
	@MessageMapping("/exitTeam/{teamId}")
    public void exitTeam(@DestinationVariable int teamId, @Payload Map<String, Object> payload) {
    	int memberId = (int)payload.get("memberId");
    	
    	MessageDTO exitMessage = teamService.insertExitMessageAndDeleteMember(teamId, memberId);
        template.convertAndSend("/broker/team/" + teamId, exitMessage);
        
        // 팀 멤버 목록 갱신
        List<MemberDTO> updatedMemberList = teamService.selectMemberListByTeamId(teamId);
        template.convertAndSend("/broker/team/members/" + teamId, updatedMemberList);

        // 탈퇴 성공 응답 보내기
        template.convertAndSend("/broker/team/" + teamId + "/exitSuccess", "success");  // 클라이언트로 응답 전송
    }
    
    // 일반 채팅 메시지 처리
    @MessageMapping("/message/{teamId}")
    public void sendMessage(@DestinationVariable int teamId, MessageDTO messageDTO) {
        teamService.insertMessage(messageDTO);  
        PhotoDTO photoDTO = memberService.selectProfilePhotoByUserid(messageDTO.getMemberId());
        messageDTO.setStoredFileName(photoDTO.getStoredFileName());
        template.convertAndSend("/broker/team/" + teamId, messageDTO);  // 채팅방에 실시간 전송
    }
    
    // 팀 이름 변경 시 모든 사용자에게 알림 전송
    @MessageMapping("/updateTeamName/{teamId}")
    public void updateTeamName(@DestinationVariable int teamId, String newTeamName) {
        teamService.updateTeamName(teamId, newTeamName);  // 팀 이름 변경
        template.convertAndSend("/broker/team/teamName/" + teamId, newTeamName);  // 새 팀 이름 전송
    }

    // 팀에서 스케쥴 추가하면
    @MessageMapping("/addSchedule/{teamId}")
    public void addSchedule(@DestinationVariable int teamId, @Payload ScheduleDTO scheduleDTO) {
    	// 장소를 insert하고
    	mapService.insertPlace(scheduleDTO);
    	// placeId설정
    	int placeId = mapService.searchId(scheduleDTO);
    	scheduleDTO.setPlaceId(placeId);
    	
    	mapService.insertSchedule(teamId, scheduleDTO);
    	
    	List<ScheduleDTO> scheduleList = teamService.selectScheduleListByTeamId(teamId);
    	template.convertAndSend("/broker/map/" + teamId, scheduleList);
    }
    
    // 팀에서 스케쥴 삭제하면 
    @MessageMapping("/deleteSchedule/{teamId}")
    public void deleteSchedule(@DestinationVariable int teamId, @Payload ScheduleDTO scheduleDTO) {    	
    	mapService.deleteSchedule(scheduleDTO);
    	List<ScheduleDTO> scheduleList= teamService.selectScheduleListByTeamId(teamId);
    	template.convertAndSend("/broker/map/" + teamId, scheduleList);
    }
    
    // 시간 수정했을 시
    @MessageMapping("/updateScheduleTime/{teamId}")
    public void updateScheduleTime(@DestinationVariable int teamId, @Payload ScheduleDTO scheduleDTO) {
    	
    	mapService.updateTime(scheduleDTO);
    	
    	List<ScheduleDTO> scheduleList= teamService.selectScheduleListByTeamId(teamId);
    	template.convertAndSend("/broker/map/" + teamId, scheduleList);
    }

}