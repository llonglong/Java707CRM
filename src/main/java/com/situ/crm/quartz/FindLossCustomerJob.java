package com.situ.crm.quartz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.situ.crm.service.ICustomerService;

/**
 * 查找流失客户的定时任务
 * @author 杨林
 *
 */
@Component
public class FindLossCustomerJob {

	@Autowired
	private ICustomerService customerService;
	
	//每天2点触发
	//@Scheduled(cron = "0/30 * * * * ?") 没30秒刷新一次
	@Scheduled(cron="0 0 2 * * ?")
	public void work(){
		System.out.println("FindLossCustomerJob.work()");
		customerService.checkCustomerLoss();
	}
}
