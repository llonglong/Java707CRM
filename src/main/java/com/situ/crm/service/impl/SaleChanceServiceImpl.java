package com.situ.crm.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.dao.SaleChanceMapper;
import com.situ.crm.dao.SaleChanceMapper;
import com.situ.crm.pojo.SaleChance;
import com.situ.crm.pojo.SaleChance;
import com.situ.crm.pojo.SaleChanceExample;
import com.situ.crm.pojo.SaleChanceExample.Criteria;
import com.situ.crm.service.ISaleChanceService;
import com.situ.crm.util.Util;
@Service
public class SaleChanceServiceImpl implements ISaleChanceService{

	@Autowired
	private SaleChanceMapper saleChanceMapper;
	
	@Override
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,SaleChance saleChance) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		SaleChanceExample example = new SaleChanceExample();
		//分页
		PageHelper.startPage(page, rows);
		//查询
		Criteria creatCriteria = example.createCriteria();
		if (StringUtils.isNotEmpty(saleChance.getCustomerName())) {
			creatCriteria.andCustomerNameLike(Util.formatLike(saleChance.getCustomerName()));
		}
		if (StringUtils.isNotEmpty(saleChance.getOverview())) {
			creatCriteria.andOverviewLike(Util.formatLike(saleChance.getOverview()));
		}
		if (StringUtils.isNotEmpty(saleChance.getCreateMan())) {
			creatCriteria.andCreateManLike(Util.formatLike(saleChance.getCreateMan()));
		}
		if (saleChance.getStatus() != null) {
			creatCriteria.andStatusEqualTo(saleChance.getStatus());
		}
		if (saleChance.getDevResult() != null) {
			creatCriteria.andDevResultEqualTo(saleChance.getDevResult());
		}
		
		List<SaleChance> saleChanceList = saleChanceMapper.selectByExample(example);
		PageInfo<SaleChance> pageInfo = new PageInfo<>(saleChanceList);
		int total = (int) pageInfo.getTotal();
		
		result.setTotal(total);
		result.setRows(saleChanceList);
		return result;
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			saleChanceMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSuccess("数据已被成功删除!");
	}

	@Override
	public ServerResponse add(SaleChance saleChance) {
		if(StringUtils.isNotEmpty(saleChance.getAssignMan())){
			saleChance.setStatus(1);
		}else{
			saleChance.setStatus(0);
		}

		if (saleChanceMapper.insert(saleChance)>0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(SaleChance saleChance) {
		if (saleChanceMapper.updateByPrimaryKey(saleChance)>0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

}
