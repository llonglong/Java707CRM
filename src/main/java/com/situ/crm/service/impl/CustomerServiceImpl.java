package com.situ.crm.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.dao.CustomerLossMapper;
import com.situ.crm.dao.CustomerMapper;
import com.situ.crm.dao.CustomerOrderMapper;
import com.situ.crm.dao.CustomerServiceMapper;
import com.situ.crm.pojo.Customer;
import com.situ.crm.pojo.CustomerExample;
import com.situ.crm.pojo.CustomerExample.Criteria;
import com.situ.crm.pojo.CustomerLoss;
import com.situ.crm.pojo.CustomerOrder;
import com.situ.crm.service.ICustomerService;
import com.situ.crm.util.Util;
import com.situ.crm.vo.CustomerConstitute;
import com.situ.crm.vo.CustomerContribute;
import com.situ.crm.vo.CustomerServiceAna;
@Service
public class CustomerServiceImpl implements ICustomerService{

	@Autowired
	private CustomerMapper customerMapper;
	
	@Autowired
	private CustomerOrderMapper customerOrderMapper;
	
	@Autowired
	private CustomerLossMapper customerLossMapper;
	
	@Autowired
	private CustomerServiceMapper customerServiceMapper;
	
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

	@Override
	public ServerResponse findById(Integer id) {
		Customer customer = customerMapper.selectByPrimaryKey(id);
		if (customer != null) {
			return ServerResponse.createSuccess("查找成功！",customer);
		}
		return ServerResponse.createError("查找失败！");
	}

	@Override
	public void checkCustomerLoss() {
		System.out.println("CustomerServiceImpl.checkCustomerLoss()");
		//1.查找流失客户
		List<Customer> customerList = customerMapper.findLossCustomer();
		for (Customer customer : customerList) {
			//2.实例化CustomerLoss
			CustomerLoss customerLoss = new CustomerLoss();
			//客户编号
			customerLoss.setCustomerNo(customer.getNum());
			//客户名称
			customerLoss.setCustomerName(customer.getName());
			//客户经理
			customerLoss.setCustomerManager(customer.getManagerName());
			//3.查找指定客户最近的一次订单
			CustomerOrder customerOrder = customerOrderMapper.findLastOrderByCustomerId(customer.getId());
			if (customerOrder == null) {
				customerLoss.setLastOrderTime(null);
			}else {
				customerLoss.setLastOrderTime(customerOrder.getOrderDate());
			}
			//4.添加到客户流失表里面
			customerLossMapper.insert(customerLoss);
			//5、客户表中客户状态修改为1：流失状态
			customer.setStatus(1);
			customerMapper.updateByPrimaryKeySelective(customer);
		}
	}

	@Override
	public EasyUIDataGrideResult findCustomerContribute(Integer page, Integer rows,
			CustomerContribute customerContribute) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		//1、设置分页 
		PageHelper.startPage(page, rows);
		//2、执行查询
		//rows(分页之后的数据)
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNoneBlank(customerContribute.getName())) {
			map.put("name", customerContribute.getName());
		}
		List<CustomerContribute> list = customerMapper.findCustomerContribute(map);
		//total
		PageInfo<CustomerContribute> pageInfo = new PageInfo<>(list);
		int total = (int)pageInfo.getTotal();				
		result.setTotal(total);
		result.setRows(list);
		return result;
	}

	@Override
	public ServerResponse findCustomerConstitute() {
		List<CustomerConstitute> list = customerMapper.findCustomerConstitute();
		return ServerResponse.createSuccess("查找成功！", list);
	}

	@Override
	public ServerResponse findCustomerService() {
		List<CustomerServiceAna> list = customerServiceMapper.findCustomerService();
		System.out.println(list);
		return ServerResponse.createSuccess("查找成功！", list);
	}

}


