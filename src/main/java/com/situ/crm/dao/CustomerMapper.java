package com.situ.crm.dao;

import com.situ.crm.pojo.Customer;
import com.situ.crm.pojo.CustomerExample;
import com.situ.crm.vo.CustomerConstitute;
import com.situ.crm.vo.CustomerContribute;
import com.situ.crm.vo.CustomerServiceAna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface CustomerMapper {
    int countByExample(CustomerExample example);

    int deleteByExample(CustomerExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Customer record);

    int insertSelective(Customer record);

    List<Customer> selectByExample(CustomerExample example);

    Customer selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Customer record, @Param("example") CustomerExample example);

    int updateByExample(@Param("record") Customer record, @Param("example") CustomerExample example);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);

    /**
     * 查找最近六个月的流失客户
     * @return
     */
	List<Customer> findLossCustomer();

	List<CustomerContribute> findCustomerContribute(Map<String, Object> map);

	List<CustomerConstitute> findCustomerConstitute();


}