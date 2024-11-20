package com.itbank.PLANWITH.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.PLANWITH.component.FileComponent;
import com.itbank.PLANWITH.model.BoardDTO;
import com.itbank.PLANWITH.model.MemberDTO;
import com.itbank.PLANWITH.model.PhotoDTO;
import com.itbank.PLANWITH.model.ReplyDTO;
import com.itbank.PLANWITH.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired private FileComponent fileComponent;
	@Autowired private BoardService boardService;
	
	@GetMapping("/boardList")
	public void boardList(Model model) {
		List<BoardDTO> list = boardService.selectList();
		model.addAttribute("list", list);
	}
	
	// 상세보기
    @GetMapping("/view/{id}")
	public String view(@PathVariable int id, Model model) {
    	// 게시글 정보 불러오기
    	BoardDTO board = boardService.selectOne(id);
		model.addAttribute("board", board);
		// 게시글 사진 불러오기
		List<PhotoDTO> boardPhotoList = boardService.getPhotoListById(id);
		model.addAttribute("boardPhotoList", boardPhotoList);
		// 댓글 정보 불러오기
		List<ReplyDTO> replyList = boardService.getReplyList(id);
		model.addAttribute("replyList", replyList);
		return "board/view";
	} 
    
	// 게시글 추가
	@GetMapping("/insert")
	public void insert() {
	}
	
	@PostMapping("/insert")
	public String insert(BoardDTO dto, HttpSession session) {
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		dto.setMemberId(login.getId());
		boardService.insertBoard(dto);
		
		List<MultipartFile> list = dto.getFiles();
		log.info(list);
		
		if ((list.size() <= 1 && list.get(0).getSize() == 0) == false) {
			list.forEach(ob -> {
				String storedFileName = fileComponent.uploadFile(ob);
				PhotoDTO boardPhoto = new PhotoDTO();
				boardPhoto.setOriginalFileName(ob.getOriginalFilename());
				boardPhoto.setStoredFileName(storedFileName);
				boardPhoto.setContentType(ob.getContentType());
				boardPhoto.setRefId(dto.getId());
				
				boardService.insertBoardPhoto(boardPhoto);
			});
		}		
		return "redirect:/board/boardList";	
	}
	
	// 수정
	@GetMapping("/update/{id}")
	public String updateForm(@PathVariable int id, Model model) {
	    BoardDTO board = boardService.selectOne(id);
	    model.addAttribute("board", board);
	    
	    return "board/update";
	}
	
    // 게시글 수정 처리
	// 인터셉터 구현 시 수정
	@PostMapping("/update/{id}")
	public String update(BoardDTO board, HttpSession session) {
	    MemberDTO login = (MemberDTO) session.getAttribute("login");
	    if (login == null)	return "redirect:/member/login";
	    board.setMemberId(login.getId());	// 작성자 저장
	    
	    boardService.updateBoard(board);
	    
	    
        return "redirect:/board/boardList";
	}
 
    // 게시글 삭제
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session) {
        boardService.deleteBoard(id);
        return "redirect:/board/boardList";       
    }
    
    // 댓글
    @PostMapping("/{boardId}")
    public String writeReply(ReplyDTO dto, HttpSession session) {
        MemberDTO login = (MemberDTO) session.getAttribute("login");      
        if (login == null) {
            return "redirect:/member/login";
        }
        
        dto.setMemberId(login.getId());	// 작성자 저장

        boardService.writeReply(dto);
        
        return "redirect:/board/view/" + dto.getBoardId();
    }
    
    
	
}
