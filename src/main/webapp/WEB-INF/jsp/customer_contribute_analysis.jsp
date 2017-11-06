<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
	<script type="text/javascript">
		$(function(){
			/*展示数据的datagrid表格*/
			$("#datagrid").datagrid({
				url:'${ctx}/customer/findCustomerContribute.action',
				method:'get',
				fit:true,
				singleSelect:false,
				toolbar:'#toolbar',
				rownumbers:true,
				fitColumns:true,
				pagination:true,
				columns:[[    
				     {field:'cb',checkbox:true,align:'center'},    
				     {field:'name',title:'客户名称',width:100,align:'center'},    
				     {field:'contribute',title:'订单总金额',width:100,align:'center'},    
				]]  
			});
		});
		
		function doSearch(){
			$("#datagrid").datagrid("load",{
				'name':$("#s_name").val(),
			})
		}
	</script>

<body>
	<table id="datagrid"></table>
	<!-- toolbar -->
	<div id="toolbar">
		客户名称:<input type="text" id="s_name" style="width:150px"></input>
		<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
	</div>
</body>
</html>