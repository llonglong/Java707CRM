<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
	function openTab(text, url, iconCls) {
		if ($("#tabs").tabs("exists", text)) {
			$("#tabs").tabs("select", text);
		} else {
			var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='"
					+ url + "'></iframe>";
			$("#tabs").tabs("add", {
				title : text,
				iconCls : iconCls,
				closable : true,
				content : content
			});
		}
	}
	/* var url;
	function openPasswordModifyDialog(){
		$("#dialog").dialog("open").dialog("setTitle","修改密码");
		url:"${ctx}/user/update.action";
		var row = selections[0];
		$('#form').form("load", row);
	}
	
	function closeDialog(){
		 $("#dialog").dialog("close");
	} */
	
	/* function doSave(){
		$("#form").form('submit',{
			url:url,
			onSubmit:function(){
				if($("#password")!=($("#passwordPardon"))){
					$.message.alert("系统提示","请确定新密码是否正确");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(data){
				
				var data = eval('(' + data + ')'); 
				if(data.status == Util.SUCCESS){
					$.messager.alert("系统提示", data.message);
		    		$("#dialog").dialog("close");
		    		$("#datagrid").datagrid("reload");
				}
			}
		});
	} */
</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 78px; background-color: #E0ECFF">
		<table style="padding: 5px" width="100%">
			<tr>
				<td width="50%"><img alt="logo"
					src="${pageContext.request.contextPath}/images/bglogo.png"></td>
				<td valign="bottom" align="right" width="50%"><font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${user.name}</font>【${user.trueName}】【${user.roleName }】
				</td>
			</tr>
		</table>
	</div>
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center" style="padding-top: 100px">
					<font color="red" size="10">欢迎使用</font>
				</div>
			</div>
		</div>
	</div>
	<div region="west" style="width: 200px" title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			<div title="营销管理" data-options="selected:true,iconCls:'icon-yxgl'"
				style="padding: 10px">
				<a
					href="javascript:openTab('营销机会管理','${ctx}/saleChance/index.action','icon-yxjhgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-yxjhgl'"
					style="width: 150px">营销机会管理</a> <a
					href="javascript:openTab('客户开发计划','${ctx}/saleChance/cusDevPlan.action','icon-khkfjh')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khkfjh'"
					style="width: 150px">客户开发计划</a>
			</div>
			<div title="客户管理" data-options="iconCls:'icon-khgl'"
				style="padding: 10px;">
				<a
					href="javascript:openTab('客户信息管理','${ctx}/customer/index.action','icon-khxxgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khxxgl'"
					style="width: 150px;">客户信息管理</a> <a
					href="javascript:openTab('客户流失管理','customerLossManage.jsp','icon-khlsgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khlsgl'"
					style="width: 150px;">客户流失管理</a>
			</div>
			<div title="服务管理" data-options="iconCls:'icon-fwgl'"
				style="padding: 10px">
				<a
					href="javascript:openTab('服务创建','customerServiceCreate.jsp','icon-fwcj')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-fwcj'" style="width: 150px;">服务创建</a>
				<a
					href="javascript:openTab('服务分配','customerServiceAssign.jsp','icon-fwfp')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-fwfp'" style="width: 150px;">服务分配</a>
				<a
					href="javascript:openTab('服务处理','customerServiceProce.jsp','icon-fwcl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-fwcl'" style="width: 150px;">服务处理</a>
				<a
					href="javascript:openTab('服务反馈','customerServiceFeedback.jsp','icon-fwfk')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-fwfk'" style="width: 150px;">服务反馈</a>
				<a
					href="javascript:openTab('服务归档','customerServiceFile.jsp','icon-fwgd')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-fwgd'" style="width: 150px;">服务归档</a>
			</div>
			<div title="统计报表" data-options="iconCls:'icon-tjbb'"
				style="padding: 10px">
				<a href="javascript:openTab('客户贡献分析','khgxfx.jsp','icon-khgxfx')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khgxfx'"
					style="width: 150px;">客户贡献分析</a> <a
					href="javascript:openTab('客户构成分析','khgcfx.jsp','icon-khgcfx')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khgcfx'"
					style="width: 150px;">客户构成分析</a> <a
					href="javascript:openTab('客户服务分析','khfwfx.jsp','icon-khfwfx')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khfwfx'"
					style="width: 150px;">客户服务分析</a> <a
					href="javascript:openTab('客户流失分析','khlsfx.jsp','icon-khlsfx')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-khlsfx'"
					style="width: 150px;">客户流失分析</a>
			</div>
			<div title="基础数据管理" data-options="iconCls:'icon-jcsjgl'"
				style="padding: 10px">
				<a
					href="javascript:openTab('数据字典管理','${ctx}/dataDic/index.action','icon-sjzdgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-sjzdgl'"
					style="width: 150px;">数据字典管理</a> <a
					href="javascript:openTab('产品信息查询','${ctx}/product/index.action','icon-cpxxgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-cpxxgl'"
					style="width: 150px;">产品信息查询</a> 
					<a href="javascript:openTab('用户信息管理','${ctx}/user/index.action','icon-user')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-user'" style="width: 150px;">用户信息管理</a>
			</div>
			<div title="系统管理" data-options="iconCls:'icon-item'"
				style="padding: 10px">
				<a href="javascript:openPasswordModifyDialog()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-modifyPassword'"
					style="width: 150px;">修改密码</a> 
					<a href="javascript:logout()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
			</div>
		</div>
	</div>
	<!-- dialog -->
	<div id="dialog" class="easyui-dialog" closed="true"
	style="width:350;height:300,padding: 10px 20px" buttons="#dialog-button">
		<form action="" id="form" method=""post>
			<input type="hidden" id="id" name="id"/>
			<table cellspacing="8px">
				<tr>
					<td>用户名：</td>
					<td><input typr="text" id="name" name="name" value="${user.name}" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input typr="text" value="${user.password}" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>修改密码：</td>
					<td><input typr="text" id="password" name="password" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td>确定新密码：</td>
					<td><input typr="text" id="passwordPardon" name="passwordPardon" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dialog-button">
		<a href="javascript:doSave()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div region="south" style="height: 25px; padding: 5px" align="center">
		Java1707CRM管理系统
	</div>

</body>
</html>