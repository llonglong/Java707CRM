<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录</title>
</head>
<body>
	<form action="${ctx}/user/login.action">
		用户名：<input type="text" class="easyui-textbox"  name="name"><br>
		密码：<input class="easyui-passwordbox" name="password"><br>
		<input class="easyui-linkbutton" type="submit" value="登录" />
	</form>
</body>
</html>