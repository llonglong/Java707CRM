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
						"${ctx}/dataDic/delete.action",
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
			url = "${ctx}/dataDic/add.action";
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
			url = "${ctx}/dataDic/update.action";
			$('#form').form("load", row);
		}
		
		function closeDialog(){
			 $("#dialog").dialog("close");
		}
		
		function doSave(){
			$("#form").form('submit',{
				url:url,
				onSubmit:function(){
					/* if($("#roleName").combobox("getValue") == ""){
						$.message.alert("系统提示","请选择用户角色");
						return false; }*/
					
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
	singleSelect:false,url:'${ctx}/dataDic/findAll.action',method:'get',
	toolbar:'#toolbar',fitColumns:true,pagination:true">
		<thead>
			<tr>
				<th data-options="field:'cb',checkbox:true,align:'center'"></th>
				<th data-options="field:'id',width:80,align:'center'">编号</th>
				<th data-options="field:'dataDicName',width:100,align:'center'">数据字典名称</th>
				<th data-options="field:'dataDicValue',width:80,align:'center'">数据字典值</th>
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
		<form action="" id="form" method=""post>
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
				<tr>
					<td>数据字典名称：</td>
					<td><input typr="text" id="dataDicName" name="dataDicName" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>数据字典值：</td>
					<td><input typr="text" id="dataDicValue" name="dataDicValue" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
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