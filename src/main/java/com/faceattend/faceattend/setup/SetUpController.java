package com.faceattend.faceattend.setup;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SetUpController {
	@GetMapping("/setup")
	public String get() {
		return"setuppics";
	}
}
