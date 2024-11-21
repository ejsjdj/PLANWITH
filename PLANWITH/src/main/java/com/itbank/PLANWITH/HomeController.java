package com.itbank.PLANWITH;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	// 기범기범기범기범
	
}
