package com.mire.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping("/")
	public String home(){
		return "redirect:/index.jsp";// template> home.html 으로 보내줌
	}
}
