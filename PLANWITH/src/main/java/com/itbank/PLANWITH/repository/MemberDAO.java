package com.itbank.PLANWITH.repository;

import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.PhotoDTO;

public interface MemberDAO {

	int selectCount(String userid); // ID 중복 확인

	String selectSalt(String userid); // salt 값 조회

	int insertMember(MemberDTO dto); // 일반 및 간편 로그인 사용자 등록

	int insertSNSMember(MemberDTO dto);	// SNS 간편로그인 최초 실행 시  

	MemberDTO selectLogin(MemberDTO dto); // 일반 로그인

	MemberDTO selectSNSLogin(String snsId); // SNS 간편로그인 사용자 조회

	PhotoDTO getPhotoByMemberId(int id);	// memberPhoto 테이블에 데이터 여부 확인
	
	int insertMemberPhoto(PhotoDTO photoDTO);  // 프로필 사진 추가
	
    int updateMemberPhoto(PhotoDTO photoDTO);  // 프로필 사진 업데이트
    
    MemberDTO selectLoginById(int id);	// 프로필 변경 후 재로그인

//    String selectProfilePhotoByMemberId(int memberId);  // 프로필 사진 조회
    
    int updateProfileInfo(MemberDTO dto);	// 프로필 기본정보 업데이트
    
    String selectHash(int id);	// 해시 조회 (현재 비밀번호 검증용)
	// 비밀번호를 변경할 때, 사용자가 입력한 현재 비밀번호가 데이터베이스에 저장된 비밀번호와 일치하는지 확인
    
    int updateMember(MemberDTO dto);
   
    int updatePassword(MemberDTO dto);
    
    int deleteMember(int id);
    
	int selectEmailAndUserid(MemberDTO dto);

//	int checkEmailExists(String email);

//	int updateEmailPassword(MemberDTO dto);	// 이메일로 새로발급받은 비밀번호용

	String selectUserIdByEmail(String email);	// 이메일을 통한 아이디 조회

	int insertLog(MemberDTO dto);	// 로그 추가

	// 회원정보 수정할때 비밀번호 확인용
	MemberDTO selectSaltAndHashById(int id);

	
}
