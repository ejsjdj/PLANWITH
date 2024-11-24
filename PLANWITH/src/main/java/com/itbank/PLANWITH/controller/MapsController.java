package com.itbank.PLANWITH.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		return list;
	}
	
	@GetMapping("/imageSearch")
	public List<NaverImageDTO> imageSearch(String title) {
		List<NaverImageDTO> list = mapService.getImageSearch(title);
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
		return list;
	}
	
//	@PostMapping("/delete")
//	public List<ScheduleDTO> delete(ScheduleDTO dto, HttpSession session) {
//	    List<ScheduleDTO> list = (List<ScheduleDTO>) session.getAttribute("scheduleList");
//	    System.out.println("delete 메서드 실행");
//        list.removeIf(o1 -> 
//            o1.getAddress().equals(dto.getAddress()) && 
//            o1.getTitle().equals(dto.getTitle())
//        );	// 이름과 주소가 똑같으면 삭제
//        session.setAttribute("scheduleList", list);  // 세션 업데이트
//	    return list;  // 수정된 리스트 반환
//	}
	
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
	
	@PostMapping("/addWishList")
	public List<PlaceDTO> addWishList(HttpSession session, @RequestBody ScheduleDTO scheduleDTO) {
		
    	mapService.insertPlace(scheduleDTO);
    	// placeId설정
    	int placeId = mapService.searchId(scheduleDTO);
    	PlaceDTO place = mapService.selectPlaceById(placeId);
    	List<PlaceDTO> wishList = (List<PlaceDTO>) session.getAttribute("wishList");    	
    	if (wishList == null) wishList = new ArrayList<PlaceDTO>();
    	wishList.add(place);
    	session.setAttribute("wishList", wishList);    	
    	return wishList;
	}
	
	@PostMapping("/deleteWishList")
	public List<PlaceDTO> deleteWishList(HttpSession session, int id) {
		
		List<PlaceDTO> wishList = (List<PlaceDTO>) session.getAttribute("wishList");
		wishList.removeIf(o1 -> o1.getId() == id);
		session.setAttribute("wishList", wishList);
		return wishList;
	}
	
	@GetMapping("/getWishList")
	public List<PlaceDTO> getWishList(HttpSession session) {
		List<PlaceDTO> wishList = (List<PlaceDTO>) session.getAttribute("wishList");
		return wishList;
	}
}