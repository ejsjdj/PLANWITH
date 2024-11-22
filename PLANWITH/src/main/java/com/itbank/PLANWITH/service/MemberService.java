package com.itbank.PLANWITH.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.PLANWITH.component.FileComponent;
import com.itbank.PLANWITH.component.HashComponent;
import com.itbank.PLANWITH.exception.MemberNotFoundException;
import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.MessageDTO;
import com.itbank.PLANWITH.model.PhotoDTO;
import com.itbank.PLANWITH.repository.MemberDAO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberService {

    @Autowired private HashComponent hashComponent;
    @Autowired private MemberDAO memberDAO;
    @Autowired private FileComponent fileComponent;

    @Value("classpath:txt/privacy_policy_개인정보 수집,이용동의.txt")
    private Resource agreement;

    // 일반 로그인, userid, hash 를 비교해 일치하는 데이터를 불러온다
    public MemberDTO selectLogin(MemberDTO dto) throws MemberNotFoundException{
        String salt = memberDAO.selectSalt(dto.getUserid());
        String hash = hashComponent.getHash(salt, dto.getUserpw());
        dto.setHash(hash);
        
//        System.out.print("service의 dto 출력 : ");
//        System.out.println(dto);
                
        MemberDTO member = memberDAO.selectLogin(dto);
//        System.out.print("service의 member 출력 : ");
//        System.out.println(member);
		
		if (member != null) {
			int row = insertLogin(member);
//	        System.out.print("status 처리후 의 member 출력 : ");
//			System.out.println(member);
//	        log.info("로그인아이디 : " + member.getId() + ", 로그인status : " + member.getStatus());
		} else {
			throw new MemberNotFoundException();
		}
        return member;
    } 

    // 네이버 간편 로그인 처리 
    public MemberDTO processNaverLogin(String naverId, MemberDTO dto) {
        MemberDTO member = memberDAO.selectSNSLogin(naverId);	// DB에서 naverId와 일치하는 정보를 가져온다
        // 존재하지 않으면 회원가입(snsInfo, member 테이블에 insert)를 시킨 후 가져온다
        if (member == null) {
            dto.setSnsId(naverId);
            dto.setSnsType("naver"); // SNS 타입 설정
            memberDAO.insertSNSMember(dto);
            member = memberDAO.selectSNSLogin(naverId);	 
        } 
        
        int row = insertLogin(member);
        log.info(row);
        
        return member;
    }
    
    // 카카오 간편 로그인 처리   
    public MemberDTO processKakaoLogin(String kakaoId, MemberDTO dto) {
        MemberDTO member = memberDAO.selectSNSLogin(kakaoId);	// DB에서 kakaoId와 일치하는 데이터를 가져온다
        // 존재하지 않으면 회원가입(snsInfo, member 테이블에 insert)를 시킨 후 가져온다
        if (member == null) {
            dto.setSnsId(kakaoId);
            dto.setSnsType("kakao"); // SNS 타입 설정
            memberDAO.insertSNSMember(dto);
            member = memberDAO.selectSNSLogin(kakaoId);
        }
        
        int row = insertLogin(member);
        log.info(row);
        
       return member; 
    }
    
    // memberId로 DB에 저장된 memberPhoto 불러오기
//    public String getProfilePhotoById(int memberId) {
//        return memberDAO.selectProfilePhotoByMemberId(memberId);
//    }
       
    // 일반 회원가입
    public int insertMember(MemberDTO dto) {
        String userpw = dto.getUserpw();
        String salt = hashComponent.getRandomSalt();
        String hash = hashComponent.getHash(salt, userpw);
        
        dto.setSalt(salt);
        dto.setHash(hash);
        
        return memberDAO.insertMember(dto);
    }

    // 사용자 ID 중복 확인
    public boolean isUserIdDuplicate(String userid) {
        return memberDAO.selectCount(userid) > 0;
    }
    
    // 회원 정보 수정
    // 인터셉터 적용 시 수정? (login == null 확인 할 필요가 있나요?)
    public int updateProfileImage(MultipartFile upload, HttpSession session) {
        MemberDTO login = (MemberDTO) session.getAttribute("login");     
        if (login == null) return 0;
          
        // 기존 사진 파일 삭제
        PhotoDTO storedPhoto = memberDAO.getPhotoByMemberId(login.getId());
        if (storedPhoto != null && storedPhoto.getStoredFileName() != null) {
            fileComponent.deleteFile(storedPhoto.getStoredFileName());
        }
        
        int row = 0;        
        if (upload != null && !upload.isEmpty()) {
            String storedFileName = fileComponent.uploadFile(upload);
//            log.info("storedFileName : " + storedFileName);
            PhotoDTO photoDTO = new PhotoDTO();
            photoDTO.setOriginalFileName(upload.getOriginalFilename());
            photoDTO.setStoredFileName(storedFileName);
            photoDTO.setContentType(upload.getContentType());
            photoDTO.setRefId(login.getId());  // 여기서 refId(참조하는 memberId) 설정 
//            System.out.println("Inserting photo for memberId: " + id); 

            log.info(photoDTO);

            // [memberPhoto] 테이블에 있으면 update, 아니면 insert
            PhotoDTO memberPhoto = memberDAO.getPhotoByMemberId(login.getId());
            if (memberPhoto != null)  	row = memberDAO.updateMemberPhoto(photoDTO);
            else 						row = memberDAO.insertMemberPhoto(photoDTO); 
            
        } else {
        	PhotoDTO photoDTO = new PhotoDTO();
        	photoDTO.setRefId(login.getId());
        	memberDAO.updateMemberPhoto(photoDTO);
        }
        
        // 추가 or 업데이트 성공 시 변경된 로그인정보를 session에 다시 저장
        if (row > 0) {
        	MemberDTO updateLogin = memberDAO.selectLoginById(login.getId());
            session.setAttribute("login", updateLogin); 
        }      
        return row;
    }
 
    // 기본 프로필 정보 수정
    public int updateProfileInfo(MemberDTO dto, HttpSession session) {
        MemberDTO login = (MemberDTO) session.getAttribute("login");
        if (login == null)  return 0;
        
        dto.setId(login.getId());
        int row = memberDAO.updateProfileInfo(dto);
        if (row > 0) {
            MemberDTO updateLogin = memberDAO.selectLoginById(login.getId());
            session.setAttribute("login", updateLogin); // 세션에 최신 정보 갱신
        }
        return row;
    }

    // 비밀번호 변경
    // 인터셉터 적용 시 수정? (login == null 확인 할 필요가 있나요?)
    public int updatePassword(String currentPassword, String newPassword, HttpSession session) {
        MemberDTO login = (MemberDTO) session.getAttribute("login");
        if (login == null) return 0;

        String salt = memberDAO.selectSalt(login.getUserid());
        String currentHash = hashComponent.getHash(salt, currentPassword);
        
        // 기존비밀번호를 입력받아 해시처리한 값과, DB에 저장된 hash 값의 일치 여부를 확인한다. false면 함수종료
        if (currentHash.equals(memberDAO.selectHash(login.getId())) == false) return 0;

        // 입력한 새로운 비밀번호로 새로운 salt, hash 값을 저장한다
        String newSalt = hashComponent.getRandomSalt();
        String newHash = hashComponent.getHash(newSalt, newPassword);
       
        // 새로운 memberDTO를 생성하여 id, newSalt, newHash를 저장하고 DB를 update한다
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setId(login.getId());
        memberDTO.setSalt(newSalt);
        memberDTO.setHash(newHash);
//        log.info("비밀번호 변경 시 userid 값 : " + memberDTO.getUserid());
        memberDTO.setUserid(login.getUserid());
        memberDTO.setEmail(login.getEmail());
        
        return memberDAO.updatePassword(memberDTO);
    }
      
    // 회원 탈퇴 
    public int deleteMember(HttpSession session) {
        MemberDTO login = (MemberDTO) session.getAttribute("login");
        int row = 0;
        
        if (login != null) row = memberDAO.deleteMember(login.getId());
        if (row > 0) session.invalidate(); // 탈퇴 후 세션 초기화	
        
        return row;
    }    
    
    // 비밀번호 재발급 
    public String createNewPassword(MemberDTO dto) {
    	// 입력받은 이메일과 사용자아이디가 일치하는 데이터의 개수를 DB에서 가져온다
    	int count = memberDAO.selectEmailAndUserid(dto);   	
    	String password = null;
    	// 임의로 비밀번호 생성 후 DB에 저장하고, 비밀번호를 반환한다
    	if(count == 1) {
    		password = UUID.randomUUID().toString().substring(0, 8);
    		String salt = hashComponent.getRandomSalt();
			String hash = hashComponent.getHash(salt, password);
			dto.setSalt(salt);
			dto.setHash(hash);
			memberDAO.updatePassword(dto);
    	}
    	
    	return password;
    }
   
    // 아이디 찾기
	public String getUserIdByEmail(String email) {
		return memberDAO.selectUserIdByEmail(email);
	}
    
	// 로그아웃 시 
	public int logout(MemberDTO dto) {
		dto.setStatus(-1);
		return memberDAO.insertLog(dto);
	}
	
	
	// 로그 추가 함수
//	public int insertLog(MemberDTO dto) {
//		return memberDAO.insertLog(dto);
//	}

	
	// service 작업 시 로그 추가 함수 
	public int insertLogin(MemberDTO login) {
		login.setStatus(1);
		return memberDAO.insertLog(login);
	}

    	public String getAgreement() {
		return readResource(agreement);
	}
	
	private String readResource(Resource resource) {
        try {
            return new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8).replace("\n", "\r");
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }

	// 유저의 id(DB에서 autogenerated)를 이용해서 storedFileName을 구하는 함수
	public PhotoDTO selectProfilePhotoByUserid(int id) {
		PhotoDTO photoDTO = memberDAO.getPhotoByMemberId(id); 
		return photoDTO;
	}

//	public String getSaltByUserId(String userid) {
//		 return memberDAO.selectSalt(userid);  
//	}


}
