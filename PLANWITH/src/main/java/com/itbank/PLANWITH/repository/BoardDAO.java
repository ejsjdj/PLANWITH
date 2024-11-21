package com.itbank.PLANWITH.repository;

import java.util.List;

import com.itbank.PLANWITH.model.BoardDTO;
import com.itbank.PLANWITH.model.LikeDTO;
import com.itbank.PLANWITH.model.PhotoDTO;
import com.itbank.PLANWITH.model.ReplyDTO;

public interface BoardDAO {

	List<BoardDTO> selectList();

	int insertBoard(BoardDTO board);

	int insertBoardPhoto(PhotoDTO photo);

    BoardDTO selectOne(int id);

    int updateBoard(BoardDTO board);
    
    int deleteBoard(int id);

//    int deleteBoardPhoto(int id);
    
	List<ReplyDTO> getReplyList(int id);

	int writeReply(ReplyDTO dto);

	List<PhotoDTO> selectPhotoByBoardId(int id);

	int deletePhotoById(int id);

	int deleteBoardPhoto(int refId);

	int selectCnt(LikeDTO dto);

	int insertLikeBoard(LikeDTO dto);

	int deleteLikeBoard(LikeDTO dto);


}
