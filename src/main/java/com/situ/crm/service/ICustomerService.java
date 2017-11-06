package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.Customer;
import com.situ.crm.vo.CustomerConstitute;
import com.situ.crm.vo.CustomerContribute;

public interface ICustomerService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,Customer customer);

	ServerResponse delete(String ids);

	ServerResponse add(Customer customer);

	ServerResponse update(Customer customer);

	ServerResponse findById(Integer id);

	/**
	 * 查询流失客户
	 */
	void checkCustomerLoss();

	EasyUIDataGrideResult findCustomerContribute(Integer page, Integer rows, CustomerContribute customerContribute);

	ServerResponse findCustomerConstitute();

	ServerResponse findCustomerService();
}
