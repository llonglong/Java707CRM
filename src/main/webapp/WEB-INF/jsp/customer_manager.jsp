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
			url:'${ctx}/customer/findAll.action',
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
			     {field:'num',title:'客户编号',width:100,align:'center'},    
			     {field:'name',title:'客户名称',width:80,align:'center'},    
			     {field:'managerName',title:'客户经理',width:80,align:'center'},    
			     {field:'level',title:'客户等级',width:100,align:'center'},    
			     {field:'phone',title:'联系电话',width:100,align:'center'},    
			     {field:'region',title:'客户地区',width:100,align:'center'},
			     {field:'satisfy',title:'客户满意度',width:100,align:'center'},  
			     {field:'credit',title:'客户信用度',width:100,align:'center'},  
			]] 
		})
	});
	
		function doSearch(value){
			$("#datagrid").datagrid("load",{
				'num':$("#s_num").val(),
				'name':$("#s_name").val()
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
						"${ctx}/customer/delete.action",
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
			url = "${ctx}/customer/add.action";
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
			url = "${ctx}/customer/update.action";
			$('#form').form("load", row);
		}
		/* 联系人管理 */
		function customerLinkman(id){
			var selections = $("#datagrid").datagrid("getSelections");
			if(selections.length == 0) {
				$.messager.alert("系统提示", "请选择要查看的数据");
				return;
			}
			var row = selections[0];
			window.parent.openTab('联系人管理','${ctx}/customerLinkman/index.action?id=' + row.id,'icon-lxr')
		}
		
		/* 交往记录管理 */
		function customerContact(id){
			var selections = $("#datagrid").datagrid("getSelections");
			if(selections.length == 0) {
				$.messager.alert("系统提示", "请选择要查看的数据");
				return;
			}
			var row = selections[0];
			window.parent.openTab('联系人管理','${ctx}/customerContact/index.action?id=' + row.id,'icon-jwjl')
		}
		
		/* 订单管理 */
		function customerOrder(id){
			var selections = $("#datagrid").datagrid("getSelections");
			if(selections.length == 0) {
				$.messager.alert("系统提示", "请选择要查看的数据");
				return;
			}
			var row = selections[0];
			window.parent.openTab('联系人管理','${ctx}/customerOrder/index.action?id=' + row.id,'icon-lsdd')
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
		
	</script>

<body>
	
	<table id="datagrid"></table>
	
	<!-- toolbar -->
	<div id="toolbar">
		<div>
			<a class="easyui-linkbutton" href="javascript:openAddDialog()" iconCls="icon-add">添加</a>
			<a class="easyui-linkbutton" href="javascript:openUpdateDialog()" iconCls="icon-edit">修改</a>
			<a class="easyui-linkbutton" href="javascript:doDelete()" iconCls="icon-remove">删除</a>
			<a class="easyui-linkbutton" href="javascript:customerLinkman(id)" iconCls="icon-lxr">联系人管理</a>
			<a class="easyui-linkbutton" href="javascript:customerContact(id)" iconCls="icon-jwjl">交往记录管理</a>
			<a class="easyui-linkbutton" href="javascript:customerOrder(id)" iconCls="icon-lsdd">历史订单管理</a>
		</div>
		<div>
			客户编号：<input type="text" id="s_num" style="width:100px"/>
			客户名称：<input type="text" id="s_name" style="width:100px"/>
			<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
	</div>
	
	<!-- dialog -->
	<div id="dialog" class="easyui-dialog" closed="true"
	style="width:700;height:280,padding: 10px 20px" buttons="#dialog-button">
		<form action="" id="form" method="post">
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
				<tr>
					<td>客户名称：</td>
					<td><input typr="text" id="name" name="name" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>地区：</td>
					<td>
						<select type="text" id="region" name="region" class="easyui-combobox"
		     				panelHeight="auto" editable="false" required="true" style="width:160px">	
 					  		<option value="北京">北京</option>
 					 		<option value="上海">上海</option>
 					 		<option value="南京">南京</option>
 					 		<option value="广州">广州</option>	
		     	  		</select><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>客户经理：</td>
					<td>
						<input type="text" id="managerName" name="managerName" class="easyui-combobox" data-options="panelHeight:'auto',required:true,editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/user/getCustomerManagerList.action'"/><font color="red">*</font>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户等级：</td>
					<td>
						<input type="text" id="level" name="level" class="easyui-combobox" data-options="panelHeight:'auto',required:true,editable:false,valueField:'dataDicValue',textField:'dataDicValue',url:'${ctx}/dataDic/getDataDicValueList.action'"/><font color="red">*</font>
		     	  	</td>
				</tr>
				<tr>
					<td>客户满意度：</td>
					<td>
						<select type="text" id="satisfy" name="satisfy" class="easyui-combobox"
		     				panelHeight="auto" editable="false" required="true" style="width:160px">
		     		  		<!-- <option value="">请选择...</option> -->	
 					  		<option value="☆">☆</option>
 					 		<option value="☆☆">☆☆</option>
 					 		<option value="☆☆☆">☆☆☆</option>
 					 		<option value="☆☆☆☆">☆☆☆☆</option>
 					 		<option value="☆☆☆☆☆">☆☆☆☆☆</option>	
		     	  		</select><font color="red">*</font>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户信用度：</td>
					<td>
						<select type="text" id="credit" name="credit" class="easyui-combobox"
		     				panelHeight="auto" editable="false" required="true" style="width:160px">
		     		  		<!-- <option value="">请选择...</option> -->	
 					  		<option value="☆">☆</option>
 					 		<option value="☆☆">☆☆</option>
 					 		<option value="☆☆☆">☆☆☆</option>
 					 		<option value="☆☆☆☆">☆☆☆☆</option>
 					 		<option value="☆☆☆☆☆">☆☆☆☆☆</option>	
		     	  		</select><font color="red">*</font>
		     	  	</td>
				</tr>
				<tr>
					<td>邮政编码：</td>
					<td><input type="text" id="postCode" name="postCode" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>联系电话：</td>
					<td><input typr="text" id="phone" name="phone" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>传真：</td>
					<td><input type="text" id="fax" name="fax" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>网址：</td>
					<td><input typr="text" id="webSite" name="webSite" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>客户地址：</td>
					<td colspan="4">
						<input type="text" id="address" name="address" style="width: 420px" class="easyui-validatebox" required="true"/><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>营业执照注册号：</td>
					<td><input type="text" id="licenceNo" name="licenceNo" class="easyui-validatebox"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>法人：</td>
					<td><input typr="text" id="legalPerson" name="legalPerson" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>注册资金(万元)：</td>
					<td><input type="text" id="bankroll" name="bankroll" class="easyui-validatebox"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>年营业额(万元)：</td>
					<td><input typr="text" id="turnover" name="turnover" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>开户银行：</td>
					<td><input type="text" id="bankName" name="bankName" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>开户账户：</td>
					<td><input typr="text" id="bankAccount" name="bankAccount" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>地税登记号：</td>
					<td><input type="text" id="localTaxNo" name="localTaxNo" class="easyui-validatebox"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>国税登记号：</td>
					<td><input typr="text" id="nationalTaxNo" name="nationalTaxNo" class="easyui-validatebox" /></td>
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