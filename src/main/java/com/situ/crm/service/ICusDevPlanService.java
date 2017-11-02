package com.situ.crm.service;

import java.util.Date;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CusDevPlan;

public interface ICusDevPlanService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,CusDevPlan cusDevPlan);

	ServerResponse delete(String ids);

	ServerResponse add(CusDevPlan cusDevPlan);

	ServerResponse update(CusDevPlan cusDevPlan);

	ServerResponse deleteById(Integer id);
}
