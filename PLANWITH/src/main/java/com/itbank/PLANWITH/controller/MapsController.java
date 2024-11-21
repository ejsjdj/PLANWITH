package com.itbank.PLANWITH.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.PLANWITH.model.NaverBlogDTO;
import com.itbank.PLANWITH.model.NaverImageDTO;
import com.itbank.PLANWITH.model.PlaceDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;
import com.itbank.PLANWITH.service.MapService;

@RestController
@RequestMapping("/maps")
public class MapsController {

	@Autowired MapService mapService;
	
	
	@GetMapping("/blogSearch")
	public List<NaverBlogDTO> blogSerach(String title) {
		List<NaverBlogDTO> list = mapService.getBlogSearch(title);
		
		// 테스트용 출력문 아래 코드가 출력값이 없으면 list 가 비어있는것
//		System.out.println("blogSearch 함수 실행");
//		for (NaverBlogDTO dto : list) {System.out.println(dto.toString());}
		
		return list;
	}
	
	@GetMapping("/imageSearch")
	public List<NaverImageDTO> imageSearch(String title) {
		List<NaverImageDTO> list = mapService.getImageSearch(title);
		
		// 테스트용 출력문 웹페이지에서 이미지가 출력되지 않는다면 테스트
//		System.out.println("imageSearch 함수 실행");
//		for (NaverImageDTO dto : list) {System.out.println(dto.toString());}
		
		return list;
	}
	
	@PostMapping("/add")
	public List<ScheduleDTO> add(ScheduleDTO dto, HttpSession session) {
		List<ScheduleDTO> list = (List<ScheduleDTO>) session.getAttribute("scheduleList");
		if (list == null) list = new ArrayList<ScheduleDTO>();
		mapService.insertPlace(dto);
    	// placeId설정
    	int placeId = mapService.searchId(dto);
		dto.setPlaceId(placeId);
		dto.setStartTime(new Date(dto.getSt()));
		dto.setEndTime(new Date(dto.getEt()));
		list.add(dto);
		
		session.setAttribute("scheduleList", list);
//		System.out.println(dto);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(dto.getStartTime()));
		System.out.println(sdf.format(dto.getEndTime()));
		
		return list;
	}
//	@PostMapping("/add")
//	public List<ScheduleDTO> add(ScheduleDTO dto, HttpSession session) {
//		List<ScheduleDTO> list = (List<ScheduleDTO>) session.getAttribute("scheduleList");
//		if (list == null) list = new ArrayList<ScheduleDTO>();
//		int placeId = mapService.insertPlace(dto);
//		dto.setPlaceId(placeId);
//		dto.setStartTime(new Date(dto.getSt()));
//		dto.setEndTime(new Date(dto.getEt()));
//		list.add(dto);
//		
//		session.setAttribute("scheduleList", list);
////		System.out.println(dto);
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		System.out.println(sdf.format(dto.getStartTime()));
//		System.out.println(sdf.format(dto.getEndTime()));
//		
//		return list;
//	}
	
	@PostMapping("/delete")
	public List<ScheduleDTO> delete(ScheduleDTO dto, HttpSession session) {
	    List<ScheduleDTO> list = (List<ScheduleDTO>) session.getAttribute("scheduleList");

        list.removeIf(o1 -> 
            o1.getAddress().equals(dto.getAddress()) && 
            o1.getTitle().equals(dto.getTitle())
        );	// 이름과 주소가 똑같으면 삭제
        session.setAttribute("scheduleList", list);  // 세션 업데이트
        
	    return list;  // 수정된 리스트 반환
	}
	
	@GetMapping("/teamViewLoad/{teamId}")
	public List<ScheduleDTO> teamViewLoad(@PathVariable int teamId) {
		return mapService.viewLoad(teamId);
	}
	
	// place를 가져와야함
	@GetMapping("/searchPlaceByScheduleId/{id}")
	public PlaceDTO searchPlaceByScheduleId(@PathVariable int id) {
		int placeId = mapService.searchPlaceByScheduleId(id);
		return mapService.selectPlaceById(placeId);
	}
}
