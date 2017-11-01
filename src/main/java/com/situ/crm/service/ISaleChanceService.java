package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.SaleChance;

public interface ISaleChanceService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,SaleChance saleChance);

	ServerResponse delete(String ids);

	ServerResponse add(SaleChance saleChance);

	ServerResponse update(SaleChance saleChance);
}
