package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.pojo.Product;

public interface IProductService {
	
	EasyUIDataGrideResult findAll(Integer page,Integer rows,Product Product);

	ServerResponse delete(String ids);

	ServerResponse add(Product Product);

	ServerResponse update(Product Product);
}
