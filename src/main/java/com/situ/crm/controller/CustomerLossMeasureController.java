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
import com.situ.crm.pojo.CustomerLossMeasure;
import com.situ.crm.service.ICustomerLossMeasureService;

@Controller
@RequestMapping("/customerLossMeasure")
public class CustomerLossMeasureController {
	@Autowired
	private ICustomerLossMeasureService customerLossMeasureService;
	
	@InitBinder 
	public void initBinder(WebDataBinder binder) { 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	    dateFormat.setLenient(false); 
	    binder.registerCustomEditor(Date.class,
	           new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/index")
	public String index(){
		return "customer_loss_measure_manager";
	}
	
	@RequestMapping("/findAll")
	@ResponseBody
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLossMeasure customerLossMeasure){
		return customerLossMeasureService.findAll(page,rows,customerLossMeasure);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public ServerResponse delete(String ids){
		return customerLossMeasureService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(CustomerLossMeasure customerLossMeasure){
		return customerLossMeasureService.add(customerLossMeasure);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(CustomerLossMeasure customerLossMeasure){
		return customerLossMeasureService.update(customerLossMeasure);
	}
		
	@RequestMapping("/deleteById")
	@ResponseBody
	public ServerResponse deleteById(Integer lossId){
		return customerLossMeasureService.delete(lossId);
	}
	
	@RequestMapping("/findById")
	@ResponseBody
	public ServerResponse findById(Integer lossId){
		return customerLossMeasureService.findById(lossId);
	}
	
	@RequestMapping("/findByLossId")
	@ResponseBody
	public List<CustomerLossMeasure> findByLossId(Integer lossId){
		return customerLossMeasureService.findByLossId(lossId);
	}
}
