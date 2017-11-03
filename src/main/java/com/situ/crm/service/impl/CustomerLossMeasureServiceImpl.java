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
import com.situ.crm.dao.CustomerLossMeasureMapper;
import com.situ.crm.pojo.CustomerLossMeasure;
import com.situ.crm.pojo.CustomerLossMeasureExample;
import com.situ.crm.pojo.CustomerLossMeasureExample.Criteria;
import com.situ.crm.service.ICustomerLossMeasureService;
import com.situ.crm.util.Util;
@Service
public class CustomerLossMeasureServiceImpl implements ICustomerLossMeasureService{

	@Autowired
	private CustomerLossMeasureMapper customerLossMeasureMapper;
	
	@Override
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,CustomerLossMeasure customerLossMeasure) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		CustomerLossMeasureExample example = new CustomerLossMeasureExample();
		//分页
		//查询
		Criteria creatCriteria = example.createCriteria();
		
		List<CustomerLossMeasure> customerLossMeasureList = customerLossMeasureMapper.selectByExample(example);
		PageInfo<CustomerLossMeasure> pageInfo = new PageInfo<>(customerLossMeasureList);
		int total = (int) pageInfo.getTotal();
		
		result.setTotal(total);
		result.setRows(customerLossMeasureList);
		return result;
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			customerLossMeasureMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSuccess("数据已被成功删除!");
	}

	@Override
	public ServerResponse add( CustomerLossMeasure customerLossMeasure) {
		if (customerLossMeasureMapper.insert(customerLossMeasure)>0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(CustomerLossMeasure customerLossMeasure) {
		if (customerLossMeasureMapper.updateByPrimaryKeySelective(customerLossMeasure)>0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

	@Override
	public ServerResponse findById(Integer lossId) {
		CustomerLossMeasure customerLossMeasure = customerLossMeasureMapper.selectByPrimaryKey(lossId);
		if (customerLossMeasure != null) {
			return ServerResponse.createSuccess("查找成功！",customerLossMeasure);
		}
		return ServerResponse.createError("查找失败！");
	}

	@Override
	public ServerResponse delete(Integer lossId) {
		if (customerLossMeasureMapper.deleteByPrimaryKey(lossId) > 0) {
			return ServerResponse.createSuccess("删除数据成功 ");
		}
		return ServerResponse.createSuccess("数据已经成功删除");
	}

	@Override
	public List<CustomerLossMeasure> findByLossId(Integer id) {
		return customerLossMeasureMapper.findByLossId(id);
	}
	
	
}


