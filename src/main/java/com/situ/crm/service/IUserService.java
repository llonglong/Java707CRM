package com.situ.crm.service;

import com.situ.crm.common.EasyUIDataGrideResult;

public interface IUserService {

	EasyUIDataGrideResult findAll(Integer page,Integer rows);

}
