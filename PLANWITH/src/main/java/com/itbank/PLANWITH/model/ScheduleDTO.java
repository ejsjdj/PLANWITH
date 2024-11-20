package com.itbank.PLANWITH.model;

import java.sql.Date;

import lombok.Data;

//-- 사용자가 선택한 계획을 기록할 테이블
//CREATE TABLE schedule (
//	    id             INTEGER             GENERATED AS IDENTITY PRIMARY KEY,
//	    startTime      TIMESTAMP           NOT NULL,
//	    endTime        TIMESTAMP           NOT NULL,
//	    placeId        INTEGER             REFERENCES place(id) ON DELETE SET NULL,
//	    content        CLOB,
//	    teamId         INTEGER             REFERENCES team(id) ON DELETE CASCADE,
//	    createdTime    TIMESTAMP           DEFAULT SYSTIMESTAMP
//);

@Data
public class ScheduleDTO {
	
	private int id;
	private Date startTime;
	private Date endTime;
	private String title;
	private int placeId;
	private String content;
	private int teamId;
	private Date createdTime;
	private String imageUrl;
	private String address;
	
	private Long st, et;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public Long getSt() {
		return st;
	}
	public void setSt(Long st) {
		this.st = st;
	}
	public Long getEt() {
		return et;
	}
	public void setEt(Long et) {
		this.et = et;
	}
	public ScheduleDTO(String title, String imageUrl) {
		this.title = title;
		this.imageUrl = imageUrl;
	}
	public ScheduleDTO() {
		// TODO Auto-generated constructor stub
	}
	
	
	public ScheduleDTO(Date startTime, Date endTime, int placeId, int teamId) {
		this.startTime = startTime;
		this.endTime = endTime;
		this.placeId = placeId;
		this.teamId = teamId;
	}
	
	@Override
	public String toString() {
		String value = "id : " + id + ", title : " + title + ", startTime : " + startTime + ", endTime : " + endTime +  ", placeId : " + placeId + ", content : " + content +  ", teamId : " + teamId +  ", createdTime :" + createdTime;
		return value;
	}	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public int getPlaceId() {
		return placeId;
	}
	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
