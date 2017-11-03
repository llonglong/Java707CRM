package com.situ.crm.service;

import java.util.List;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.CustomerLossMeasure;

public interface ICustomerLossMeasureService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLossMeasure customerLossMeasure);

	ServerResponse delete(String ids);

	ServerResponse add(CustomerLossMeasure customerLossMeasure);

	ServerResponse update(CustomerLossMeasure customerLossMeasure);

	ServerResponse findById(Integer lossId);

	ServerResponse delete(Integer lossId);

	List<CustomerLossMeasure> findByLossId(Integer lossId);
}
