package com.faceattend.faceattend.Chat;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatController {

	 @GetMapping("/chat")
	    public String startChat() {
	            
	            return "chat";
	        
	    }
}
