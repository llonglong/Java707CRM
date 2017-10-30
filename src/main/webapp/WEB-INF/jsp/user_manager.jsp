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
			$("#datagrid").datagrid({
				url:'${ctx}/user/findAll.action',
				method:'get',
				fit:true,
				singleSelect:false,
				toolbar:'#toolbar',
				rownumbers:true,
				fitColumns:true,
				pagination:true,
				columns:[[    
				     {field:'cb',checkbox:true,align:'center'},    
				     {field:'id',title:'编号',width:80,align:'center'},    
				     {field:'name',title:'用户名',width:100,align:'center'},    
				     {field:'password',title:'密码',width:80,align:'center'},    
				     {field:'trueName',title:'真实姓名',width:80,align:'center'},    
				     {field:'email',title:'邮件',width:100,align:'center'},    
				     {field:'phone',title:'联系电话',width:100,align:'center'},    
				     {field:'roleName',title:'角色',width:100,align:'center'}    
				]] 
			})
		});
		function doSearch(){
			$("#datagrid").datagrid("load",{
				'name':$("#name").val(),
				'name':$("#password").val(),
				'name':$("#trueName").val(),
				'name':$("#email").val(),
				'phone':$("#phone").val(),
				'roleName':$("#roleName").val()
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
						"${ctx}/user/delete.action",
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
			url = "${ctx}/user/add.action";
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
			url = "${ctx}/user/update.action";
			$('#form').form("load", row);
		}
		
		function closeDialog(){
			 $("#dialog").dialog("close");
		}
		
		function doSave(){
			$("#form").form('submit',{
				url:url,
				onSubmit:function(){
					if($("#roleName").combobox("getValue") == ""){
						$.message.alert("系统提示","请选择用户角色");
						return false;
					}
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
	<table id="datagrid"></table>
	
	<!-- toolbar -->
	<div id="toolbar">
		<div>
			<a class="easyui-linkbutton" href="javascript:openAddDialog()" iconCls="icon-add">添加</a>
			<a class="easyui-linkbutton" href="javascript:openUpdateDialog()" iconCls="icon-edit">修改</a>
			<a class="easyui-linkbutton" href="javascript:doDelete()" iconCls="icon-remove">删除</a>
		</div>
		<div>
			用户名：<input class="easyui-searchbox" id="name" style="width:150px"/>
			密码：<input class="easyui-searchbox" id="password" style="width:150px"/>
			真实姓名：<input class="easyui-searchbox" id="trueName" style="width:150px"/>
			邮箱：<input class="easyui-searchbox" id="email" style="width:150px"/>
			电话：<input class="easyui-searchbox" id="phone" style="width:150px"/>
			用户角色：<select  class="easyui-combobox" id="roleName" editable="false">
						<option></option>
						<option value="系统管理员">系统管理员</option>
						<option value="销售主管">销售主管</option>
						<option value="客户经理">客户经理</option>
						<option value="高管">高管</option>	
				   </select >
			<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
	</div>
	
	<!-- dialog -->
	<div id="dialog" class="easyui-dialog" closed="true"
	style="width:650;height:280,padding: 10px 20px" buttons="#dialog-button">
		<form action="" id="form" method=""post>
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
				<tr>
					<td>用户名：</td>
					<td><input typr="text" id="name" name="name" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>密码：</td>
					<td><input typr="text" id="password" name="password" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>真实姓名：</td>
					<td><input typr="text" id="trueName" name="trueName" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>邮箱：</td>
					<td><input typr="text" id="email" name="email" class="easyui-validatebox" required="true" validType="email"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>联系电话：</td>
					<td><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>用户角色：</td>
					<td>
						<select class="easyui-combobox" id="roleName" name="roleName" style="width:160">
							<option></option>
							<option value="系统管理员">系统管理员</option>
							<option value="销售主管">销售主管</option>
							<option value="客户经理">客户经理</option>
							<option value="高管">高管</option>
						</select>
						<font color="red">*</font></td>
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