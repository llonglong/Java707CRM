package com.situ.crm.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.dao.CustomerMapper;
import com.situ.crm.pojo.Customer;
import com.situ.crm.pojo.CustomerExample;
import com.situ.crm.pojo.CustomerExample.Criteria;
import com.situ.crm.service.ICustomerService;
import com.situ.crm.util.Util;
@Service
public class CustomerServiceImpl implements ICustomerService{

	@Autowired
	private CustomerMapper customerMapper;
	
	@Override
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,Customer customer) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		CustomerExample example = new CustomerExample();
		//分页
		PageHelper.startPage(page, rows);
		//查询
		Criteria creatCriteria = example.createCriteria();
		if (StringUtils.isNotEmpty(customer.getName())) {
			creatCriteria.andNameLike(Util.formatLike(customer.getName()));
		}
		
		List<Customer> customerList = customerMapper.selectByExample(example);
		PageInfo<Customer> pageInfo = new PageInfo<>(customerList);
		int total = (int) pageInfo.getTotal();
		
		result.setTotal(total);
		result.setRows(customerList);
		return result;
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			customerMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSuccess("数据已被成功删除!");
	}

	@Override
	public ServerResponse add(Customer customer) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date date = new Date();
		customer.setNum("KH" + simpleDateFormat.format(date));
		if (customerMapper.insert(customer)>0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(Customer customer) {
		if (customerMapper.updateByPrimaryKeySelective(customer)>0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

}
