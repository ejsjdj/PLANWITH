package com.itbank.PLANWITH;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	// 성재의 테스트

	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
}
