package com.itbank.PLANWITH.exception;

public class MemberNotFoundException extends Exception {

	private static final long serialVersionUID = 1L;
	
	@Override
	public String getMessage() {		
		return "입력하신 정보와 일치하는 회원을 찾을 수 없습니다.";
	}
	
	
}
