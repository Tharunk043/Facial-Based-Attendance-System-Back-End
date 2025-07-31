package com.faceattend.faceattend.imageupload;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RegistrationContoller {
    @RequestMapping("/register")
    public String register() {
    	return "register";
    }

}
