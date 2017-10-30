package com.situ.crm.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.EasyUIDataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.dao.UserMapper;
import com.situ.crm.pojo.User;
import com.situ.crm.pojo.UserExample;
import com.situ.crm.pojo.UserExample.Criteria;
import com.situ.crm.util.Util;
@Service
public class UserServiceImpl implements IUserService{

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public EasyUIDataGrideResult findAll(Integer page,Integer rows,User user) {
		EasyUIDataGrideResult result = new EasyUIDataGrideResult();
		UserExample example = new UserExample();
		//分页
		PageHelper.startPage(page, rows);
		//查询
		Criteria creatCriteria = example.createCriteria();
		if (StringUtils.isNotEmpty(user.getName())) {
			creatCriteria.andNameLike(Util.formatLike(user.getName()));
		}
		if (StringUtils.isNotEmpty(user.getPassword())) {
			creatCriteria.andPasswordLike(Util.formatLike(user.getPassword()));
		}
		if (StringUtils.isNotEmpty(user.getTrueName())) {
			creatCriteria.andTrueNameLike(Util.formatLike(user.getTrueName()));
		}
		if (StringUtils.isNotEmpty(user.getEmail())) {
			creatCriteria.andEmailLike(Util.formatLike(user.getEmail()));
		}
		if (StringUtils.isNotEmpty(user.getPhone())) {
			creatCriteria.andPhoneLike(Util.formatLike(user.getPhone()));
		}
		if (StringUtils.isNotEmpty(user.getRoleName())) {
			creatCriteria.andRoleNameLike(Util.formatLike(user.getRoleName()));
		}
		List<User> userList = userMapper.selectByExample(example);
		PageInfo<User> pageInfo = new PageInfo<>(userList);
		int total = (int) pageInfo.getTotal();
		
		result.setTotal(total);
		result.setRows(userList);
		return result;
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		for (String id : idArray) {
			userMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return ServerResponse.createSuccess("数据已被成功删除!");
	}

	@Override
	public ServerResponse add(User user) {
		if (userMapper.insert(user)>0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(User user) {
		if (userMapper.updateByPrimaryKey(user)>0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

}
