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
import com.situ.crm.pojo.CustomerOrder;
import com.situ.crm.service.ICustomerOrderService;

@Controller
@RequestMapping("/customerOrder")
public class CustomerOrderController {
	@Autowired
	private ICustomerOrderService customerOrderService;
	
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/index")
	public String index(){
		return "customer_order_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerOrder customerOrder){
		return customerOrderService.findAll(page,rows,customerOrder);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return customerOrderService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(CustomerOrder customerOrder){
		return customerOrderService.add(customerOrder);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(CustomerOrder customerOrder){
		return customerOrderService.update(customerOrder);
	}
		
	@RequestMapping("/deleteById")
	@ResponseBody
	public ServerResponse deleteById(Integer id){
		return customerOrderService.delete(id);
	}
}
