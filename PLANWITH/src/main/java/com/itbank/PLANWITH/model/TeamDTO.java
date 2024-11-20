package com.itbank.PLANWITH.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

//-- 생성된 채팅룸을 기록할 테이블
//CREATE TABLE team (
//    id              INTEGER             GENERATED AS IDENTITY PRIMARY KEY,
//    name            VARCHAR2(255)       NOT NULL,
//    createTime      TIMESTAMP           DEFAULT SYSTIMESTAMP
//);

//-- 채팅룸에 어떤 멤버가 연결되어 있는지 기록할 테이블
//CREATE TABLE teamMember (
//    id             INTEGER             GENERATED AS IDENTITY PRIMARY KEY,
//    memberId       INTEGER             REFERENCES member(id) ON DELETE CASCADE,
//    teamId         INTEGER             REFERENCES team(id) ON DELETE CASCADE
//);

//-- 모든 채팅기록을 담을 테이블
//CREATE TABLE message (
//    id             INTEGER             GENERATED AS IDENTITY PRIMARY KEY,
//    teamId         INTEGER             REFERENCES team(id) ON DELETE CASCADE NOT NULL,
//    memberId       INTEGER             REFERENCES member(id) ON DELETE SET NULL,
//    content        VARCHAR2(2000)      NOT NULL,
//    sentTime       TIMESTAMP           DEFAULT SYSTIMESTAMP NOT NULL
//);

public class TeamDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private int id;
	private String name;
	private Date createTime;
	private String inviteCode;
	
	private List<MemberDTO> team_members;

//	채팅룸에 이전에 채팅을 가져올때 필요한 리스트 필요시 구현
//	private List<MessageDTO> message_list; 
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public List<MemberDTO> getTeam_members() {
		return team_members;
	}

	public void setTeam_members(List<MemberDTO> team_members) {
		this.team_members = team_members;
	}
	
	public String getInviteCode() {
		return inviteCode;
	}

	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}


	
}
