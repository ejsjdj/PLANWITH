package com.itbank.PLANWITH.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/map")
public class ScheduleController {

	@GetMapping("/schedule")
	public void schedule(Model model) {
		String setDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 (E)"));
		model.addAttribute("setDate", setDate);
	}
	
	@PostMapping("/schedule")
	public void schedule(Model model, @RequestParam String inputDate) {
		
		String[] arr = inputDate.split("-");
		
		LocalDate date = LocalDate.of(Integer.parseInt(arr[0]), Integer.parseInt(arr[1]), Integer.parseInt(arr[2]));
		String setDate = date.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 (E)"));
		
		model.addAttribute("setDate", setDate);
	}
}
