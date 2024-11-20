package com.itbank.PLANWITH.model;

import lombok.Data;

//	CREATE TABLE teammember (
//		    id             INTEGER             GENERATED AS IDENTITY PRIMARY KEY,
//		    memberId       INTEGER             REFERENCES member(id) ON DELETE CASCADE,
//		    teamId         INTEGER             REFERENCES team(id) ON DELETE CASCADE
//		);

@Data
public class TeamMemberDTO {
	
	private int id;
	private int teamId;
	private int memberId;
	
	public TeamMemberDTO(int teamId, int memberId) {
		this.teamId = teamId;
		this.memberId = memberId;
	}

}
