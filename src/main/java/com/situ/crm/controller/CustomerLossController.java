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
import com.situ.crm.pojo.CustomerLoss;
import com.situ.crm.service.ICustomerLossService;

@Controller
@RequestMapping("/customerLoss")
public class CustomerLossController {
	@Autowired
	private ICustomerLossService customerLossService;
	
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/index")
	public String index(){
		return "customer_loss_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLoss customerLoss){
		return customerLossService.findAll(page,rows,customerLoss);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return customerLossService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(CustomerLoss customerLoss){
		return customerLossService.add(customerLoss);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(CustomerLoss customerLoss){
		return customerLossService.update(customerLoss);
	}
		
	@RequestMapping("/deleteById")
	@ResponseBody
	public ServerResponse deleteById(Integer id){
		return customerLossService.delete(id);
	}
	
	@RequestMapping("/findById")
	@ResponseBody
	public ServerResponse findById(Integer id){
		return customerLossService.findById(id);
	}
	
	@RequestMapping("/updateStatus")
	@ResponseBody
	public ServerResponse updateStatus(Integer lossId,Integer status){
		return customerLossService.updateStatus(lossId,status);
	}
}
