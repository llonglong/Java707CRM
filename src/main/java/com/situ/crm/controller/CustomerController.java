package com.situ.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.Customer;
import com.situ.crm.service.ICustomerService;
import com.situ.crm.vo.CustomerConstitute;
import com.situ.crm.vo.CustomerContribute;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	@Autowired
	private ICustomerService customerService;
	
	@RequestMapping("/index")
	public String index(){
		return "customer_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,Customer customer){
		return customerService.findAll(page,rows,customer);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return customerService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(Customer customer){
		return customerService.add(customer);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(Customer customer){
		return customerService.update(customer);
	}
	
	@RequestMapping("/findById")
	@ResponseBody
	public ServerResponse findById(Integer id){
		return customerService.findById(id);
	}
	
	@RequestMapping("/getCustomerContributePage")
	public String getCustomerContributePage(){
		return "customer_contribute_analysis";
	}
	
	@RequestMapping("/findCustomerContribute")
	@ResponseBody
	public EasyUIDataGrideResult findCustomerContribute(Integer page, Integer rows, CustomerContribute customerContribute){
		return customerService.findCustomerContribute(page, rows, customerContribute);
	}
	
	@RequestMapping("/getCustomerConstitutePage")
	public String getCustomerConstitutePage(){
		return "customer_constitute_analysis";
	}
	
	@RequestMapping("/findCustomerConstitute")
	@ResponseBody
	public ServerResponse findCustomerConstitute(){
		return customerService.findCustomerConstitute();
	}
	
	@RequestMapping("/getCustomerServicePage")
	public String getCustomerServicePage(){
		return "customer_service_analysis";
	}
	
	@RequestMapping("/findCustomerService")
	@ResponseBody
	public ServerResponse findCustomerService(){
		return customerService.findCustomerService();
	}
}
