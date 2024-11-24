package com.itbank.PLANWITH.controller;

import java.io.File;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.PLANWITH.component.MailComponent;
import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.service.CaptchaService;
import com.itbank.PLANWITH.service.MemberService;

@RestController
@RequestMapping("/members")
public class MembersController {
	
	/***
	 * 
	 * 	깃허브 브랜치 테스트
	 * 	2024.11.20
	 */

    @Autowired private MemberService memberService;
    @Autowired private CaptchaService captchaService;
    @Autowired private MailComponent mailComponent;
    private ObjectMapper objectMapper = new ObjectMapper();

    // ID 중복 확인
    @GetMapping("/idCheck")
    public HashMap<String, Object> idCheck(String userid) {
        boolean isDuplicate = memberService.isUserIdDuplicate(userid);

        HashMap<String, Object> ret = new HashMap<>();
        ret.put("title", "ID 중복 확인 결과");
        ret.put("content", isDuplicate ? "이미 사용 중인 아이디입니다." : "사용 가능한 아이디입니다.");
        ret.put("type", isDuplicate ? "error" : "success");
        ret.put("success", !isDuplicate);
        return ret;
    }

    // 캡차 키를 세션에 저장하고, 키를 이용하여 이미지를 불러온 후 파일이름을 반환한다
    @GetMapping("/captcha")
    public HashMap<String, Object> generateCaptcha(HttpSession session) throws Exception {
        String captchaKey = captchaService.getCapchaKey();
        captchaKey = objectMapper.readTree(captchaKey).get("key").asText();
        session.setAttribute("captchaKey", captchaKey);
        File image = captchaService.getCapchaImage(captchaKey);
        
        HashMap<String, Object> result = new HashMap<>();
        result.put("captchaImage", image.getName());
        return result;
    }

    // 캡차 검증
    @PostMapping("/captcha")
    public String verifyCaptcha(String user_captcha, HttpSession session) throws Exception {
        String captchaKey = (String) session.getAttribute("captchaKey");
        String json = captchaService.verifyCapcha(captchaKey, user_captcha);
        return json;
        
    }
    
    @PostMapping("/findPassword")
	public HashMap<String, Object> resetPassword(MemberDTO dto) { 
		String password = memberService.createNewPassword(dto);
		int row = 0;
		
		if(password != null) {
			String contentForm = "변경된 비밀번호는 [%s]입니다";
			contentForm = String.format(contentForm, password);
			row = mailComponent.sendMessage(dto.getEmail(), "[PLANWITH] 비밀번호 재발급", contentForm);
		}
		
		HashMap<String, Object> ret = new HashMap<>();
		ret.put("success", row != 0);
		return ret;
	}
    
    
    // 아이디 찾기 - 인증번호 발송
    @PostMapping("/sendVerificationCode")
    public HashMap<String, Object> sendVerificationCode(String email, HttpSession session) {
    	// 임의로 6자리의 인증번호를 생성한다
    	Random ran = new SecureRandom();
        String verificationCode = String.format("%d", 100000 + ran.nextInt(900000));
        
        // 이메일로 인증번호 전송 및 전송 성공 여부 확인
        int result = mailComponent.sendMessage(email, "아이디 찾기 인증번호", "인증번호는[" + verificationCode + "]입니다");      
        if (result != 0) {
            session.setAttribute("verificationCode", verificationCode); 
        }
        
        HashMap<String, Object> ret = new HashMap<>(); 
        ret.put("success", result != 0); 
        ret.put("message", result != 0 ? "인증번호가 발송되었습니다." : "인증번호 발송에 실패했습니다."); 
        return ret; 
    }

    // 인증번호 확인 후 아이디 찾기
    @PostMapping("/findUserid")
    public HashMap<String, Object> findUserid(String email, String userInputCode, HttpSession session) {
        HashMap<String, Object> ret = new HashMap<>(); 
       
        // 세션에서 인증 코드 확인, 일치하지 않으면 함수종료
        String verificationCode = (String) session.getAttribute("verificationCode");
        if (verificationCode == null || verificationCode.equals(userInputCode) == false) {
        	ret.put("success", false);
        	ret.put("message", "인증번호가 일치하지 않습니다."); 
            return ret; 
        }

        // 데이터베이스에서 이메일을 통해 ID 조회
        String userId = memberService.getUserIdByEmail(email); // 이메일을 통해 아이디를 검색
        if (userId != null) {
        	ret.put("title", "아이디 찾기 성공");
        	ret.put("success", true);
        	ret.put("message", "회원님의 아이디는 " + userId + " 입니다."); 
        	ret.put("icon", "info");
            session.removeAttribute("verificationCode"); // 인증번호 세션 제거             
        } else {
        	ret.put("title", "아이디 찾기 실패");
        	ret.put("success", false);
        	ret.put("message", "해당 이메일로 등록된 아이디가 없습니다."); 
        	ret.put("icon", "error");
        }
        return ret; 
    }
    
 
    
}
