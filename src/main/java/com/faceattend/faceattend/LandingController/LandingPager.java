package com.faceattend.faceattend.LandingController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LandingPager {
	@GetMapping("faceAttend")
	public String index() {
		return "index";
	}
	
}
