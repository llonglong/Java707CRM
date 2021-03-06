package com.situ.crm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.User;
import com.situ.crm.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private IUserService userService;
	
	@RequestMapping("/index")
	public String index(){
		return "user_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,User user){
		return userService.findAll(page,rows,user);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return userService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(User user){
		return userService.add(user);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(User user){
		return userService.update(user);
	}
	
	@RequestMapping(value="/login")
	public String login(Model model, HttpServletRequest req,String name,String password) {	
		User user = userService.getUser(name,password);
		if(user != null){
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			System.out.println(user);
			return "redirect:/index/index.action";
		}else {
			return "redirect:/index/tologin.action";	
		}
	}
	
	@RequestMapping(value="/getCustomerManagerList")
	@ResponseBody
	public List<User> getCustomerManagerList(){
		return userService.getCustomerManagerList();
	}
	
	@RequestMapping("/updateById")
	@ResponseBody
	public ServerResponse updateById(HttpServletRequest req, User user){
				System.out.println(user.getName());
				return userService.updateById(user);
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		session.invalidate();
		return "redirect:/index/tologin.action";
	}
}
