package com.situ.crm.service;

import java.util.Date;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.SaleChance;

public interface ISaleChanceService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,SaleChance saleChance,Date beginData,Date endData);

	ServerResponse delete(String ids);

	ServerResponse add(SaleChance saleChance);

	ServerResponse update(SaleChance saleChance);

	ServerResponse findById(Integer id);

	ServerResponse updateDevResult(Integer saleChanceId, Integer devResult);
}
