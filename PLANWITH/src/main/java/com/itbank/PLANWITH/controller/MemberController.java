package com.itbank.PLANWITH.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.PLANWITH.component.KakaoLoginComponent;
import com.itbank.PLANWITH.component.NaverLoginComponent;
import com.itbank.PLANWITH.exception.MemberNotFoundException;
import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {

	@Autowired private MemberService memberService;
	@Autowired private NaverLoginComponent naverLoginComponent;
	@Autowired private KakaoLoginComponent kakaoLoginComponent;

	private ObjectMapper objectMapper = new ObjectMapper();

	// 일반 로그인
	@GetMapping("/login")
	public void login(Model model, HttpSession session) {
		String naverLoginURL = naverLoginComponent.getAuthorizationUrl(); // 네이버로그인URL
		String kakaoLoginURL = kakaoLoginComponent.getLoginURI(session); // 카카오로그인URL
		model.addAttribute("naverLoginURL", naverLoginURL);	// 모델에 네이버 로그인 URL 추가
		model.addAttribute("kakaoLoginURL", kakaoLoginURL);	// 모델에 카카오 로그인 URL 추가
		
		// 로그인 시 시도 횟수 카운트
		Integer loginCnt = (Integer) session.getAttribute("loginCnt");
		if (loginCnt == null)
			loginCnt = 1;	 // 초기화
		session.setAttribute("result", loginCnt >= 3);	// 3번 이상 실패 여부를 세션에 저장
	}

	@PostMapping("/login")
	public String login(MemberDTO dto, HttpSession session, RedirectAttributes rttr) {
		Integer loginCnt = (Integer) session.getAttribute("loginCnt");	// 로그인 실패 횟수 세션에서 가져옴
		if (loginCnt == null)
			loginCnt = 0;	 // 초기화

		try {
			MemberDTO login = memberService.selectLogin(dto); // 입력된 ID, PW로 로그인 시도
			session.setAttribute("login", login); // 로그인 성공 시 세션에 사용자 정보 저장
			session.removeAttribute("loginCnt"); // 로그인 성공 시 실패 카운트 초기화
			session.removeAttribute("snsLogin"); // SNS 로그인 플래그 초기화
			rttr.addFlashAttribute("message", "로그인 성공!");
			rttr.addFlashAttribute("context", "login");
			return "redirect:/team/teamList"; // 로그인 성공 시 리다이렉트
		} catch (MemberNotFoundException e) {
			loginCnt++;
			session.setAttribute("loginCnt", loginCnt); // 실패 시도 증가
			session.setAttribute("result", loginCnt >= 3);

			rttr.addFlashAttribute("message", e.getMessage()); // 예외 메시지를 플래시 메시지로 추가
			rttr.addFlashAttribute("context", "loginFail");
			return "redirect:/member/login"; // 실패 시 로그인 페이지로 리다이렉트
		}
	}

	// naverCallback을 통해 accessToken을 받고, acessToken으로 네이버 프로필정보를 받는다
	@GetMapping("/naverCallback")
	public String naverCallback(String code, String state, HttpSession session) throws Exception {
		String access_token = naverLoginComponent.getAccessToken(code, state);	// 인증 코드로 AccessToken 요청
		access_token = objectMapper.readTree(access_token).get("access_token").asText(); // AccessToken 파싱

		String userProfile = naverLoginComponent.getProfile(access_token);	// AccessToken으로 사용자 프로필 요청
		JsonNode profileJson = objectMapper.readTree(userProfile);	// 프로필 데이터를 JSON으로 변환

		String naverId = profileJson.get("response").get("id").asText();
		String nickname = profileJson.get("response").get("nickname").asText();
		String email = profileJson.get("response").get("email").asText();
		String gender = profileJson.get("response").get("gender").asText();

		// 네이버 프로필 정보를 가져와서 memberDTO를 생성한다
		MemberDTO dto = new MemberDTO();
		dto.setUserid(naverId);
		dto.setNickname(nickname);
		dto.setEmail(email);
		dto.setGender(gender);

		// 네이버 로그인 처리 (회원가입 또는 기존 회원 조회)
		MemberDTO login = memberService.processNaverLogin(naverId, dto);
		session.setAttribute("login", login);	// 로그인 정보 세션 저장
		session.setAttribute("snsLogin", true); // SNS 로그인 여부 세션저장

		return "member/naverCallback";	// 네이버 로그인 결과 페이지
	}

	// kakaoCallback을 통해 accessToken을 받고, acessToken으로 네이버 프로필정보를 받는다
	@GetMapping("/kakaoCallback")
	public String kakaoCallback(String code, HttpSession session) throws Exception {
		String access_token = kakaoLoginComponent.getAccessToken(code);
		access_token = objectMapper.readTree(access_token).get("access_token").asText();

		String userProfile = kakaoLoginComponent.getProfile(access_token);
		JsonNode profileJson = objectMapper.readTree(userProfile);

		String kakaoId = profileJson.get("id").asText();
		String nickname = profileJson.get("properties").get("nickname").asText();
		String email = profileJson.get("kakao_account").get("email").asText();

		// 카카오 프로필 정보를 가져와서 memberDTO를 생성한다
		MemberDTO dto = new MemberDTO();
		dto.setUserid(kakaoId);
		dto.setNickname(nickname);
		dto.setEmail(email);

		MemberDTO login = memberService.processKakaoLogin(kakaoId, dto);
		session.setAttribute("login", login);
		session.setAttribute("snsLogin", true); // SNS 로그인 여부 저장

		return "member/kakaoCallback";
	}

	// 일반 회원가입
	@GetMapping("/join")
	public void join(Model model) {
		// 이용약관 내용을 모델에 추가
		model.addAttribute("agreement", memberService.getAgreement());
	}

	@PostMapping("/join")
	public String join(MemberDTO dto, @RequestParam("termsCheck") boolean termsCheck, RedirectAttributes rttr) {

		if (!termsCheck) {
			rttr.addFlashAttribute("message", "이용약관에 동의해야 회원가입이 가능합니다.");
			return "redirect:/member/join";
		}

		int row = memberService.insertMember(dto);
		rttr.addFlashAttribute("message", row > 0 ? "회원 가입 성공" : "회원 가입 실패");
		rttr.addFlashAttribute("context", "join"); // 'join' 맥락 설정
		return "redirect:/member/login";
	}

	// 인터셉터 구현 시 수정
	@GetMapping("/info")
	public String memberInfo(HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		if (login == null) {
			return "redirect:/member/login";
		}
		return "member/info";
	}

	// 프로필 이미지 수정
	// 인터셉터 구현 시 수정
	@GetMapping("/updateProfileImage")
	public String updateProfileImagePage(HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		if (login == null) {
			return "redirect:/member/login";
		}
		return "member/updateProfileImage";
	}

	@PostMapping("/updateProfileImage")
	public String updateProfileImage(@RequestParam MultipartFile upload, HttpSession session, RedirectAttributes rttr) {
		System.out.println(upload);
		int row = memberService.updateProfileImage(upload, session);
		rttr.addFlashAttribute("message", row > 0 ? "프로필 이미지 수정 성공" : "프로필 이미지 수정 실패");
		return "redirect:/member/info";
	}

	// 닉네임, 이메일, 주소, 성별 수정 페이지 로드
	// 인터셉터 구현 시 수정
	@GetMapping("/updateInfo")
	public String updateInfo(HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		if (login == null) {
			return "redirect:/member/login";
		}
		return "member/updateInfo";
	}

	@PostMapping("/updateInfo")
	public String updateInfo(MemberDTO dto, HttpSession session, RedirectAttributes rttr) {
		int row = memberService.updateProfileInfo(dto, session);
		rttr.addFlashAttribute("message", row > 0 ? "프로필 정보 수정 성공" : "프로필 정보 수정 실패");
		return "redirect:/member/info";
	}

	// 비밀번호 수정
	// 인터셉터 구현 시 수정
	@GetMapping("/updatePassword")
	public String updatePasswordPage(HttpSession session, Model model) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		if (login == null) {
			return "redirect:/member/login";
		}
		return "member/updatePassword";
	}

	@PostMapping("/updatePassword")
	public String updatePassword(@RequestParam String currentPassword, @RequestParam String newPassword,
			HttpSession session, RedirectAttributes rttr) {
//		log.info("현재비밀번호(currentPassword) : " + currentPassword);

		int row = memberService.updatePassword(currentPassword, newPassword, session);

//	     HashMap 으로 하면 jsp 에서 하나로 합칠 수 있을 것만 같은 느낌....
		if (row > 0) {
			rttr.addFlashAttribute("result", true);
			rttr.addFlashAttribute("message", "비밀번호 수정 성공: 비밀번호 변경을 성공했습니다.");
			return "redirect:/member/info";
		} else {
			rttr.addFlashAttribute("result", false);
			rttr.addFlashAttribute("message", "비밀번호 수정 실패: 현재 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/updatePassword";
		}
	}

	// 로그아웃
//	@GetMapping("/logout")
//	public String logout(HttpSession session) {
//		MemberDTO login = (MemberDTO) session.getAttribute("login");
//		memberService.logout(login);
//		session.invalidate();
//		return "redirect:/";
//	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
	    if (login != null) {
	        memberService.logout(login);
	        // 세션 무효화 전에 속성을 제거
//	        session.removeAttribute("login");
//	        session.removeAttribute("snsLogin");   
	        // 이후 세션 무효화
	        session.invalidate();
	    }
	    return "redirect:/";
	}

	// 회원 탈퇴 처리
	@PostMapping("/delete")
	public String deleteMember(HttpSession session, RedirectAttributes rttr) {
		int row = memberService.deleteMember(session);
		rttr.addFlashAttribute("message", row > 0 ? "회원 탈퇴가 완료되었습니다." : "회원 탈퇴에 실패했습니다.");
		return "redirect:/";
	}

	// 이메일 인증 후 비밀번호 찾기
	@GetMapping("/findPassword")
	public void findPassword() {
	}

	// 이메일 인증 후 아이디 찾기
	@GetMapping("/findUserid")
	public void findUserid() {
	}

	// 회원정보 수정할때 인터셉터로 패스워드 확인
	@GetMapping("/checkPassword")
	public String checkPasswordPage(HttpSession session) {

	    if (session.getAttribute("login") == null) {
	        return "redirect:/member/login";
	    }
	    return "member/checkPassword";
	}


	// 비밀번호 확인 처리
	@PostMapping("/checkPassword")
	public String checkPassword(@RequestParam String password, HttpSession session, RedirectAttributes rttr) {
	    MemberDTO login = (MemberDTO) session.getAttribute("login");

	    if (login == null) {
	        return "redirect:/member/login";
	    }
	    // 비밀번호 검증
	    boolean isValid = memberService.checkPassword(login.getId(), password);

	    if (isValid) {	 // 비밀번호 확인 성공
	        session.setAttribute("passwordCheck", true); // 세션에 비밀번호 확인 상태 저장
	        // 리다이렉트 URL 가져오기
	        String redirectUrl = (String) session.getAttribute("redirectAfterPasswordCheck");
	        session.removeAttribute("redirectAfterPasswordCheck"); // 사용 후 제거
	        rttr.addFlashAttribute("result", "true");
	        rttr.addFlashAttribute("message", "비밀번호 확인 성공!");
	        return "redirect:" + (redirectUrl != null ? redirectUrl : "/member/info");
	    } else {
	        rttr.addFlashAttribute("result", "false");
	        rttr.addFlashAttribute("message", "비밀번호가 일치하지 않습니다.");
	        return "redirect:/member/checkPassword";
	    }
	}



}
