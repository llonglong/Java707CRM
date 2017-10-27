package com.situ.crm.common;

import java.io.Serializable;

public class ServerResponse<T> implements Serializable{
	// ��ǰ״̬(����Ա�ж�״̬):�ɹ���ʧ�ܣ�δ��½��û��Ȩ��
	private Integer status;
	
	// ������Ϣ(��Ҫ�Ǹ��û�������ʾ��Ϣ)
	private String message;
	
	// ��̨���ظ�ǰ�˵�����
	private T data;

	public ServerResponse() {
		super();
	}
	
	public ServerResponse(Integer status) {
		super();
		this.status = status;
	}

	public ServerResponse(Integer status, T data) {
		super();
		this.status = status;
		this.data = data;
	}

	public ServerResponse(Integer status, String message) {
		super();
		this.status = status;
		this.message = message;
	}

	public ServerResponse(Integer status, String message, T data) {
		super();
		this.status = status;
		this.message = message;
		this.data = data;
	}
	
	// ֻ�Ǹ���ǰ̨���ɹ����״̬
	public static<T> ServerResponse<T> createSuccess(){
		return new ServerResponse<T>(ResponseCode.SUCCESS.getCode());
	}
	// ֻ�Ǹ���ǰ̨��status,msg
		public static <T> ServerResponse<T> createSuccess(String msg) {
			return new ServerResponse<>(ResponseCode.SUCCESS.getCode(), msg);
		}

		// ֻ�Ǹ���ǰ̨��status,msg,data
		public static <T> ServerResponse<T> createSuccess(String msg, T data) {
			return new ServerResponse<>(ResponseCode.SUCCESS.getCode(), msg, data);
		}

		// ֻ�Ǹ���ǰ̨��ʧ�����״̬
		public static <T> ServerResponse<T> createError() {
			return new ServerResponse<>(ResponseCode.ERROR.getCode());
		}

		// ֻ�Ǹ���ǰ̨��status,msg
		public static <T> ServerResponse<T> createError(String msg) {
			return new ServerResponse<>(ResponseCode.ERROR.getCode(), msg);
		}

		// ֻ�Ǹ���ǰ̨��status,msg,data
		public static <T> ServerResponse<T> createError(String msg, T data) {
			return new ServerResponse<>(ResponseCode.ERROR.getCode(), msg, data);
		}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "ServerResponse [status=" + status + ", message=" + message + ", data=" + data + "]";
	}
	
	
	
	
	
	
}
