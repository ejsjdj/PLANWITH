package com.itbank.PLANWITH;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	// 20241120

	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
}
