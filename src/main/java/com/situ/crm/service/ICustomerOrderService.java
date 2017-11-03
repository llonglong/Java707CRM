package com.situ.crm.service;

import java.util.List;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CustomerOrder;

public interface ICustomerOrderService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerOrder customerOrder);

	ServerResponse delete(String ids);

	ServerResponse add(CustomerOrder customerOrder);

	ServerResponse update(CustomerOrder customerOrder);

	ServerResponse findById(Integer id);

	ServerResponse delete(Integer id);
}
