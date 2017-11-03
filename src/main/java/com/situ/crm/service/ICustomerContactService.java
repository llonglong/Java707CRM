package com.situ.crm.service;

import java.util.List;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CustomerContact;

public interface ICustomerContactService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerContact customerContact);

	ServerResponse delete(String ids);

	ServerResponse add(CustomerContact customerContact);

	ServerResponse update(CustomerContact customerContact);

	ServerResponse findById(Integer id);

	ServerResponse delete(Integer id);
}
