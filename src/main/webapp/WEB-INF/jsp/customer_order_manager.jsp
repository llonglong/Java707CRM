<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="${ctx}/resources/thirdlib/jquery-easyui/jquery.edatagrid.js"></script>
<title>Insert title here</title>
</head>
	<script type="text/javascript">
	$(function(){
		$.post("${ctx}/customer/findById.action",
			{id:'${param.id}'},		
			function(result){
				if(result.status == Util.SUCCESS){
					$("#num").val(result.data.num);
					$("#name").val(result.data.name);
				}
			
			},
		"json");
		
		/*展示数据的datagrid表格*/
		$("#datagrid").edatagrid({
			url:'${ctx}/customerOrder/findAll.action?id=${param.id}',//只查询已分配咨询师的
			saveUrl:'${ctx}/customerOrder/add.action?saleChanceId=${param.id}',
			updateUrl:'${ctx}/customerOrder/update.action?saleChanceId=${param.id}',
			destroyUrl:'${ctx}/customerOrder/deleteById.action',
			title:'订单信息管理',
			singleSelect:true,
			toolbar:'#toolbar',
			rownumbers:true,
			fitColumns:true,
			columns:[[    
			     {field:'id',title:'编号',width:50,align:'center'},    
			     {field:'orderNo',title:'订单号',width:100,align:'center',editor:{type:'validatebox',options:{required:true}}},    
			     {field:'orderDate',title:'订单日期',width:80,align:'center',editor:{type:'datebox',options:{required:true}}}, 
			     {field:'address',title:'送货地址',width:80,align:'center',editor:{type:'validatebox',options:{required:true}}},
			     {field:'status',title:'状态',width:80,align:'center',editor:{type:'validatebox',options:{required:true}},formatter:function(value,row,index){
			    	 if(value == 0){
			    		 return "未付款";
			    	 }else{
			    		 return "已付款";
			    	 }
			     }},
			]]
		});
	});
	
	/* //更新销售机会客户开发状态
	function updateSaleChanceDevResult(devResult){
		 $.post("${ctx}/saleChance/updateDevResult.action",
				 {saleChanceId:'${param.saleChanceId}',devResult:devResult},
				 function(result){
					 if(result.status == Util.SUCCESS){
						 $.messager.alert("系统提示","执行成功！");
					 }else{
						 $.messager.alert("系统提示","执行失败！");
					 }
		 		},
		 		"json");
	 } */
	</script>

<body>
	<!-- 营销机会信息面板  开始 -->
	<div id="p" class="easyui-panel" title="客户信息" style="width: 700px;height: 100px">
	 	<table cellspacing="8px">
	   		<tr>
	   			<td>客户编号：</td>
	   			<td><input type="text" id="num" name="num" readonly="readonly"/></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>客户名称：</td>
	   			<td><input type="text" id="name" name="name" readonly="readonly"/></td>
	   		</tr>
	   	</table>
	 </div>
	 <!-- 营销机会信息面板  结束  -->
	
	 <br>
	 
	 <!-- 客户开发计划项table -->
	<table id="datagrid" style="width:700px;height:250px"></table>
	
	<!-- toolbar 开始 -->
	 <div id="toolbar">
	 	<c:if test="${param.show!='true' }">
		 	<a href="javascript:$('#datagrid').edatagrid('addRow')" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		 	<a href="javascript:$('#datagrid').edatagrid('destroyRow')" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		 	<a href="javascript:$('#datagrid').edatagrid('cancelRow')" class="easyui-linkbutton" iconCls="icon-undo" plain="true">撤销行</a>
		 	<a href="javascript:$('#datagrid').edatagrid('saveRow');$('#datagrid').edatagrid('reload')" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	 	</c:if>
	 </div>
	<!-- toolbar 结束 -->

</body>
</html>