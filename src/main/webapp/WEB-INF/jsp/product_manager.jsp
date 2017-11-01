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
		function doSearch(value){
			$("#datagrid").datagrid("load",{
				'Name':value
			})
		}
		/* 删除 */
		function doDelete(){
			var ids = Util.getSelectionsIds("#datagrid");
			if (ids.length == 0) {
				$.messager.alert("系统提示", "请选择要删除的数据");
				return;
			}
			$.messager.confirm("系统提示", "您确认要删除么", function(r){
				if (r){
					$.post(
						"${ctx}/product/delete.action",
						{ids:ids}, 
						function(result) {
							$.messager.alert("系统提示", result.message);
							if(result.status == Util.SUCCESS) {
								$("#datagrid").datagrid("reload");
							}
						},
						"json"
					);
				}
			})
		}
		var url;
		/* 添加dialog */
		function openAddDialog() {
			$("#dialog").dialog("open").dialog("setTitle","添加信息");
			url = "${ctx}/product/add.action";
			$('#form').form("clear");	
		}
		
		/* 修改dialog */
		function openUpdateDialog() {
			var selections = $("#datagrid").datagrid("getSelections");
			if(selections.length == 0) {
				$.messager.alert("系统提示", "请选择要修改的数据");
				return;
			}
			var row = selections[0];
			$("#dialog").dialog("open").dialog("setTitle","修改信息");
			url = "${ctx}/product/update.action";
			$('#form').form("load", row);
		}
		
		function closeDialog(){
			 $("#dialog").dialog("close");
		}
		
		function doSave(){
			$("#form").form('submit',{
				url:url,
				onSubmit:function(){
					return $(this).form("validate");
				},
				success:function(data){
					/* alert(data); */
					var data = eval('(' + data + ')'); 
					if(data.status == Util.SUCCESS){
						$.messager.alert("系统提示", data.message);
			    		$("#dialog").dialog("close");
			    		$("#datagrid").datagrid("reload");
					}
				}
			});
		}
		
	</script>

<body>
	<table id="datagrid" class="easyui-datagrid" data-options="rownumbers:true,fit:true,
	singleSelect:false,url:'${ctx}/product/findAll.action',method:'get',
	toolbar:'#toolbar',fitColumns:true,pagination:true">
		<thead>
			<tr>
				<th data-options="field:'cb',checkbox:true,align:'center'"></th>
				<th data-options="field:'id',width:80,align:'center'">编号</th>
				<th data-options="field:'name',width:100,align:'center'">产品名称</th>
				<th data-options="field:'model',width:80,align:'center'">型号</th>
				<th data-options="field:'unit',width:80,align:'center'">单位</th>
				<th data-options="field:'price',width:150,align:'center'">价格</th>
				<th data-options="field:'stock',width:100,align:'center'">库存</th>
				<th data-options="field:'remark',width:100,align:'center'">备注</th>
			</tr>
		</thead>
	</table>
	
	<!-- toolbar -->
	<div id="toolbar">
		<a class="easyui-linkbutton" href="javascript:openAddDialog()" iconCls="icon-add">添加</a>
		<a class="easyui-linkbutton" href="javascript:openUpdateDialog()" iconCls="icon-edit">修改</a>
		<a class="easyui-linkbutton" href="javascript:doDelete()" iconCls="icon-remove">删除</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="easyui-searchbox" data-options="prompt:'用户名',searcher:doSearch" style="width:150px"></input>
	</div>
	
	<!-- dialog -->
	<div id="dialog" class="easyui-dialog" closed="true"
	style="width:650;height:280,padding: 10px 20px" buttons="#dialog-button">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
				<tr>
					<td>产品名称：</td>
					<td><input typr="text" id="name" name="name" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>型号：</td>
					<td><input typr="text" id="model" name="model" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>单位：</td>
					<td><input typr="text" id="unit" name="unit" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>价格：</td>
					<td><input typr="text" id="price" name="price" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>库存：</td>
					<td><input type="text" id="stock" name="stock" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>备注：</td>
					<td><input typr="text" id="remark" name="remark" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dialog-button">
		<a href="javascript:doSave()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>

</body>
</html>