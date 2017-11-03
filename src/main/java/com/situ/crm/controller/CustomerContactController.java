package com.situ.crm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CustomerContact;
import com.situ.crm.service.ICustomerContactService;

@Controller
@RequestMapping("/customerContact")
public class CustomerContactController {
	@Autowired
	private ICustomerContactService customerContactService;
	
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/index")
	public String index(){
		return "customer_contact_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerContact customerContact){
		return customerContactService.findAll(page,rows,customerContact);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return customerContactService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(CustomerContact customerContact){
		return customerContactService.add(customerContact);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(CustomerContact customerContact){
		return customerContactService.update(customerContact);
	}
		
	@RequestMapping("/deleteById")
	@ResponseBody
	public ServerResponse deleteById(Integer id){
		return customerContactService.delete(id);
	}
}
