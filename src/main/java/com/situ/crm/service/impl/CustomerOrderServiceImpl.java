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
import com.situ.crm.dao.CustomerOrderMapper;
import com.situ.crm.pojo.CustomerOrder;
import com.situ.crm.pojo.CustomerOrderExample;
import com.situ.crm.pojo.CustomerOrderExample.Criteria;
import com.situ.crm.service.ICustomerOrderService;
import com.situ.crm.util.Util;
@Service
public class CustomerOrderServiceImpl implements ICustomerOrderService{

	@Autowired
	private CustomerOrderMapper customerOrderMapper;
	
	@Override
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerOrder customerOrder) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		CustomerOrderExample example = new CustomerOrderExample();
		//分页
		//查询
		Criteria creatCriteria = example.createCriteria();
		
		List<CustomerOrder> customerOrderList = customerOrderMapper.selectByExample(example);
		PageInfo<CustomerOrder> pageInfo = new PageInfo<>(customerOrderList);
		int total = (int) pageInfo.getTotal();
		
		result.setTotal(total);
		result.setRows(customerOrderList);
		return result;
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			customerOrderMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSuccess("数据已被成功删除!");
	}

	@Override
	public ServerResponse add(CustomerOrder customerOrder) {
		if (customerOrderMapper.insert(customerOrder)>0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(CustomerOrder customerOrder) {
		if (customerOrderMapper.updateByPrimaryKeySelective(customerOrder)>0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

	@Override
	public ServerResponse findById(Integer id) {
		CustomerOrder customerOrder = customerOrderMapper.selectByPrimaryKey(id);
		if (customerOrder != null) {
			return ServerResponse.createSuccess("查找成功！",customerOrder);
		}
		return ServerResponse.createError("查找失败！");
	}

	@Override
	public ServerResponse delete(Integer id) {
		if (customerOrderMapper.deleteByPrimaryKey(id) > 0) {
			return ServerResponse.createSuccess("删除数据成功 ");
		}
		return ServerResponse.createSuccess("数据已经成功删除");
	}
	
	
}


