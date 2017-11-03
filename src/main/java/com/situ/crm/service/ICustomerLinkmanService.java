package com.situ.crm.service;

import java.util.List;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CustomerLinkman;

public interface ICustomerLinkmanService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLinkman customerLinkman);

	ServerResponse delete(String ids);

	ServerResponse add(CustomerLinkman customerLinkman);

	ServerResponse update(CustomerLinkman customerLinkman);

	ServerResponse findById(Integer id);

	List<CustomerLinkman> findGenderList();

	ServerResponse delete(Integer id);
}
