package com.situ.crm.vo;

public class CustomerServiceAna {
	
	private String serviceType;
	
	private Integer num;
	
	public CustomerServiceAna() {
		super();
	}

	public CustomerServiceAna(String serviceType, Integer num) {
		super();
		this.serviceType = serviceType;
		this.num = num;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "CustomerService [serviceType=" + serviceType + ", num=" + num + "]";
	}
	
	
}
