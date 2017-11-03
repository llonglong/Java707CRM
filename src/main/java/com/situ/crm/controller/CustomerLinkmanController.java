package com.situ.crm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CustomerLinkman;
import com.situ.crm.service.ICustomerLinkmanService;

@Controller
@RequestMapping("/customerLinkman")
public class CustomerLinkmanController {
	@Autowired
	private ICustomerLinkmanService customerLinkmanService;
	
	@RequestMapping("/index")
	public String index(){
		return "customer_linkman_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLinkman customerLinkman){
		return customerLinkmanService.findAll(page,rows,customerLinkman);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return customerLinkmanService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(CustomerLinkman customerLinkman){
		return customerLinkmanService.add(customerLinkman);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(CustomerLinkman customerLinkman){
		return customerLinkmanService.update(customerLinkman);
	}
	
	@RequestMapping("/findGender")
	@ResponseBody
	public List<CustomerLinkman> findGenderList(){
		return customerLinkmanService.findGenderList();
	}
	
	@RequestMapping("/deleteById")
	@ResponseBody
	public ServerResponse deleteById(Integer id){
		return customerLinkmanService.delete(id);
	}
}
