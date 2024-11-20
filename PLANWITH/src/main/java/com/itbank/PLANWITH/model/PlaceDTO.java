package com.itbank.PLANWITH.model;

//-- 사용자가 plan, review, wishlist 에 어떤 항목을 담았을 경우 해당 항목에 정보를 저장할 테이블
//CREATE TABLE place (
//    id              INTEGER             GENERATED AS IDENTITY PRIMARY KEY,
//    name            VARCHAR2(255)       NOT NULL,
//    category        VARCHAR2(50)        NOT NULL,
//    address         VARCHAR2(255)       NOT NULL
//);

public class PlaceDTO {
	
	public PlaceDTO(String name, String category, String address) {
		this.name = name;
		this.category = category;
		this.address = address;
	}
	
	private int id;
	private String name;
	private String category;
	private String address;
	
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
