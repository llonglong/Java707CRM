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
			url:'${ctx}/customerLoss/findAll.action',
			method:'get',
			fit:true,
			singleSelect:false,
			toolbar:'#toolbar',
			rownumbers:true,
			fitColumns:true,
			pagination:true,
			columns:[[    
			     {field:'cb',checkbox:true,align:'center'},    
			     {field:'id',title:'编号',width:50,align:'center'},    
			     {field:'customerName',title:'客户名称',width:100,align:'center'},    
			     {field:'customerManager',title:'客户经理',width:80,align:'center'},
			     {field:'lastOrderTime',title:'上次下单日期',width:80,align:'center'},
			     {field:'confirmLossTime',title:'确定流失日期',width:80,align:'center'},
			     {field:'status',title:'客户状态',width:80,align:'center',formatter:function(value,row,index){
			    	 if(value == 0){
			    		 return "暂未流失";
			    	 }else{
			    		 return "确定流失";
			    	 }
			     }},
			     {field:'lossReason',title:'流失原因',width:100,align:'center'},
			     {field:'a',title:'操作',width:80,align:'center',formatter:function(value,row,index){
			    	 if(row.status==1){
			    		 return "客户确定流失";
			    	 }else{
			    		 return "<a href='javascript:openCustomerLossInfoTab("+row.id+")'>暂未流失</a>";
			    	 }
			     }}, 
			]] 
		})
	});	
	
		//如果分配指派人，指派时间为当前时间
		$(function(){
			$("#assignMan").combobox({
				onSelect:function(record){
					if(record.roleName !=''){
						$("#assignTime").val(Util.getCurrentDateTime());
					}else{
						$("#assignTime").val("");
					}
				}
			})
		});
		
		function doSearch(){
			$("#datagrid").datagrid("load",{
				'customerName':$("#s_customerName").val(),
				'overview':$("#s_overview").val(), 				
				'devResult':$("#s_devResult").val()
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
						"${ctx}/customerLoss/delete.action",
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
			$('#form').form("clear");
			$('#createMan').val("${user.name}");
			$('#createTime').val(Util.getCurrentDateTime());
			url = "${ctx}/customerLoss/add.action";
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
			url = "${ctx}/customerLoss/update.action";
			$('#form').form("load", row);
		}
		
		function formatStatus(val,row){
			 if(val==1){
				 return "已分配";
			 }else{
				 return "未分配";
			 }
		 }
		
		
		/* 关闭 */
		function closeDialog(){
			 $("#dialog").dialog("close");
		}
		
		/* 保存 */
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
		
		//可以修改添加开发项
		function openCustomerLossInfoTab(id){
			 window.parent.openTab('客户开发计划项管理','${ctx}/customerLossMeasure/index.action?lossId='+id,'icon-khkfjh');
		}
		 
	</script>

<body>
	<table id="datagrid" ></table>
	
	<!-- toolbar -->
	<div id="toolbar">
		<!-- <div>
			<a class="easyui-linkbutton" href="javascript:openAddDialog()" iconCls="icon-add">添加</a>
			<a class="easyui-linkbutton" href="javascript:openUpdateDialog()" iconCls="icon-edit">修改</a>
			<a class="easyui-linkbutton" href="javascript:doDelete()" iconCls="icon-remove">删除</a>
		</div> -->
		<div>
			客户名称：<input type="text" id="s_customerName"/>
		           概要：<input type="text" id="s_overview"/>
		           客户状态：<select type="text" id="s_devResult" class="easyui-combobox"
		     		panelHeight="auto" editable="false" style="width:100px">
		     		<option value="">请选择...</option>	
 					<option value="0">暂未流失</option>
 					<option value="1">确认流失</option>	
		     	</select>
			<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
	</div>
	
	<!-- dialog -->
	<div id="dialog" class="easyui-dialog" closed="true"
	style="width:650;height:280,padding: 10px 20px" buttons="#dialog-button">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
				<tr>
					<td>客户名称：</td>
					<td>
						<input type="text" id="customerName" name="customerName" class="easyui-validatebox" required="true"/><font color="red">*</font>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>机会来源：</td>
					<td>
						<input type="text" id="chanceSource" name="chanceSource" />
					</td>
				</tr>
				<tr>
					<td>联系人：</td>
					<td>
						<input type="text" id="linkMan" name="linkMan"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>联系电话：</td>
					<td>
						<input type="text" id="linkPhone" name="linkPhone" />
					</td>
				</tr>
				<tr>
					<td>成功几率(%)：</td>
					<td>
						<input type="text" id="successRate" name="successRate" class="easyui-validatebox" required="true"/><font color="red">*</font>
					</td>
					<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td>概要：</td>
					<td colspan="4">
						<input type="text" id="overview" name="overview" style="width: 420px"/>
					</td>
				</tr>
				<tr>
					<td>机会描述：</td>
					<td colspan="4">
						<textarea rows="5" cols="50" id="description" name="description"></textarea>
					</td>
				</tr>
				<tr>
					<td>创建人：</td>
					<td>
						<input type="text" id="createMan" name="createMan" class="easyui-validatebox" required="true"/><font color="red">*</font>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>创建时间：</td>
					<td>
						<input type="text" id="createTime" name="createTime" readonly="true" />&nbsp;<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>指派人：</td>
					<td>
						<input type="text" id="assignMan" name="assignMan" class="easyui-combobox" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/user/getCustomerManagerList.action'"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>指派时间：</td>
					<td>
						<input type="text" id="assignTime" name="assignTime" readonly="true" />
					</td>
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