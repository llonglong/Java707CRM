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
import com.situ.crm.dao.CustomerLossMapper;
import com.situ.crm.pojo.CustomerLoss;
import com.situ.crm.pojo.CustomerLossExample;
import com.situ.crm.pojo.SaleChance;
import com.situ.crm.pojo.CustomerLossExample.Criteria;
import com.situ.crm.service.ICustomerLossService;
import com.situ.crm.util.Util;
@Service
public class CustomerLossServiceImpl implements ICustomerLossService{

	@Autowired
	private CustomerLossMapper customerLossMapper;
	
	@Override
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLoss customerLoss) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		CustomerLossExample example = new CustomerLossExample();
		//分页
		//查询
		Criteria creatCriteria = example.createCriteria();
		
		List<CustomerLoss> customerLossList = customerLossMapper.selectByExample(example);
		PageInfo<CustomerLoss> pageInfo = new PageInfo<>(customerLossList);
		int total = (int) pageInfo.getTotal();
		
		result.setTotal(total);
		result.setRows(customerLossList);
		return result;
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			customerLossMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSuccess("数据已被成功删除!");
	}

	@Override
	public ServerResponse add(CustomerLoss customerLoss) {
		if (customerLossMapper.insert(customerLoss)>0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(CustomerLoss customerLoss) {
		if (customerLossMapper.updateByPrimaryKeySelective(customerLoss)>0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

	@Override
	public ServerResponse findById(Integer id) {
		CustomerLoss customerLoss = customerLossMapper.selectByPrimaryKey(id);
		if (customerLoss != null) {
			return ServerResponse.createSuccess("查找成功！",customerLoss);
		}
		return ServerResponse.createError("查找失败！");
	}

	@Override
	public ServerResponse delete(Integer id) {
		if (customerLossMapper.deleteByPrimaryKey(id) > 0) {
			return ServerResponse.createSuccess("删除数据成功 ");
		}
		return ServerResponse.createSuccess("数据已经成功删除");
	}

	@Override
	public ServerResponse updateStatus(Integer lossId, Integer status) {
		CustomerLoss customerLoss = new CustomerLoss();
		customerLoss.setId(lossId);
		customerLoss.setStatus(status);
		if (customerLossMapper.updateByPrimaryKeySelective(customerLoss) > 0) {
			return ServerResponse.createSuccess("更新成功");
		}
		return ServerResponse.createError("更新失败");
	}
	
	
}


