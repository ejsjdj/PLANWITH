package com.itbank.PLANWITH.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.MessageDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;
import com.itbank.PLANWITH.model.TeamDTO;
import com.itbank.PLANWITH.service.TeamService;

@Controller
@RequestMapping("/team")
public class TeamController {
   
   @Autowired private TeamService teamService;
   
   // git 테스트
   // 11111
   
    @GetMapping("/main")
    public String main(HttpSession session) {
       MemberDTO login = (MemberDTO) session.getAttribute("login");
       if(login != null) return "redirect:/team/viewTeams";
       else return "redirect:/team/view";
    }
    
    // 팀목록 페이지, 로그인 상태인 경우에만 보여진다
    @GetMapping("/viewTeams")
    public String viewTeams(HttpSession session, Model model) {
        MemberDTO login = (MemberDTO) session.getAttribute("login");
        if (login != null) {
            // 팀 목록을 항상 최신 상태로 불러옴
           List<TeamDTO> teamList = teamService.selectTeamListByMemberId(login.getId());
            session.setAttribute("teamList", teamList);
            return "/team/viewTeams";  // 새로고침된 팀 목록을 보여주는 페이지
        }
        return "redirect:/team/view";
    }
    
   // 비로그인 상태에서 여행 시작하기 버튼, 로그인 상태에서의 팀생성 버튼 클릭 시 실행
    @GetMapping("/create")
    public String createTeam(HttpSession session) {
       MemberDTO login = (MemberDTO) session.getAttribute("login");
       // 로그인 상태인 경우 조건문 실행 후 viewTeams로 이동(team 목록 페이지)
       if(login != null) {      
          int row = teamService.insertTeamAndInsertMember(login);
          if(row > 0) {   
              List<TeamDTO> teamList = teamService.selectTeamListByMemberId(login.getId());
               session.setAttribute("teamList", teamList);
               return "redirect:/team/viewTeams";   
          }
       }
        return "redirect:/team/view";   // 비로그인 상태인 경우 view로 이동 (@getMapping("/view")
    }
    
    // 포워드해서 주소를 변경한다 (실제 이동하는곳은 teamView 페이지)
    @GetMapping("/view")   
    public String noTeam() {
        return "team/teamView";
    }
    
    // 초대코드로 팀에 합류할때
    @PostMapping("/joinTeam")
    public String joinTeam(String inviteCode, HttpSession session) {
        TeamDTO team = teamService.selectTeamByInviteCode(inviteCode);   // 초대코드로 team객체 가져 옴
        // 초대코드로 팀이 조회되면 teamId를 불러와서 입장
        if (team != null) {    
            int teamId = team.getId();   
            return "redirect:/team/view/" + teamId;
        } else {
            return "redirect:/team/viewTeams";   // 해당하는 팀이 없으면 팀목록 페이지로 이동 
        }
    }
    
    // 팀 생성했거나, 팀 목록에서 팀에 들어갈 때
    @GetMapping("/view/{teamId}")
    public String viewChat(@PathVariable int teamId, Model model) {
       
        TeamDTO team = teamService.selectTeamById(teamId);    // url에서 teamId 들고와서 팀 조회,저장
        
        List<MemberDTO> memberList = teamService.selectMemberListByTeamId(teamId);         // 팀에 참여한 멤버목록
        List<ScheduleDTO> scheduleList = teamService.selectScheduleListByTeamId(teamId);   // 팀끼리 공유하는 일정목록
        List<MessageDTO> messageList = teamService.selectMessageListByTeamId(teamId);      // 메시지 내용들
        
        // model에 각각 정보 저장
        model.addAttribute("team", team); 
        model.addAttribute("memberList", memberList);
        model.addAttribute("scheduleList", scheduleList);
        model.addAttribute("messageList", messageList);
        
        return "team/teamView"; // 팀 상세화면으로 이동
    }

}
