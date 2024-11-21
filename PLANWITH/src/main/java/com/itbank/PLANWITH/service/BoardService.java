package com.itbank.PLANWITH.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.PLANWITH.component.FileComponent;
import com.itbank.PLANWITH.model.BoardDTO;
import com.itbank.PLANWITH.model.LikeDTO;
import com.itbank.PLANWITH.model.PhotoDTO;
import com.itbank.PLANWITH.model.ReplyDTO;
import com.itbank.PLANWITH.repository.BoardDAO;

@Service
public class BoardService {

	@Autowired private BoardDAO boardDAO;
	@Autowired private FileComponent fileComponent;
	
    // 게시물 목록 불러오기
    public List<BoardDTO> selectList() {
        return boardDAO.selectList();
    }
	
	// 게시글 추가
	public void insertBoard(BoardDTO dto, PhotoDTO boardPhoto) {	    
	        boardPhoto.setRefId(dto.getId());  // Board의 ID를 boardPhotoDTO에 설정
            boardDAO.insertBoardPhoto(boardPhoto);
    }
	// 게시글만 있을때
	public void insertBoard(BoardDTO dto) {
		boardDAO.insertBoard(dto);
	}	
	
	// 게시글 사진 있을때
    public int insertBoardPhoto(PhotoDTO boardPhoto) {
        return boardDAO.insertBoardPhoto(boardPhoto);
    }

    // 특정 게시글 조회
    public BoardDTO selectOne(int id) {
        return boardDAO.selectOne(id);
    }
	
	// 게시글 사진목록 불러오기
	public List<PhotoDTO> getPhotoListById(int id) {
		return boardDAO.selectPhotoByBoardId(id);
	}
    
    // 게시글 수정
    public int updateBoard(BoardDTO board) {
    	return boardDAO.updateBoard(board);
    }
    
    // 게시글 삭제
    public int deleteBoard(int id) {	// 업로드 파앨 삭제, DB 삭제
    	// 게시글 안에 있는 업로드된 파일 삭제
    	List<PhotoDTO> photoList = boardDAO.selectPhotoByBoardId(id);
		for (PhotoDTO dto : photoList) fileComponent.deleteFile(dto.getStoredFileName());
		
        return boardDAO.deleteBoard(id);
    }

	public int deleteBoardPhoto(int id) {
    	List<PhotoDTO> photoList = boardDAO.selectPhotoByBoardId(id);
		for (PhotoDTO dto : photoList) fileComponent.deleteFile(dto.getStoredFileName());
		
		return boardDAO.deleteBoardPhoto(id);
	}
    
    // 댓글목록 불러오기
	public List<ReplyDTO> getReplyList(int id) {
		return boardDAO.getReplyList(id);
	}

	// 댓글 작성
	public int writeReply(ReplyDTO dto) {
		return boardDAO.writeReply(dto);
	}
	
	// 좋아요 기능
	public int likeBoard(LikeDTO dto) {
		int count = boardDAO.selectCnt(dto);	// 로그인 아이디랑 해당 보드에 해당하는 좋아요가 있는지 확인
		if(count == 0) boardDAO.insertLikeBoard(dto);	// 좋아요 안했으면 추가
		if(count == 1) boardDAO.deleteLikeBoard(dto);	// 좋아요 해있으면 취소
		
		return count;	// 0 이면 추가됨, 1 이면 삭제됨
	}

}