<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>效能-项目页面</title>
	<!-- 时间控件 css  -->
	<link rel="stylesheet" type="text/css" href="${ctx}/static/My97/skin/WdatePicker.css" />
	<!-- 时间控件js  -->
	<script type="text/javascript" src="${ctx}/static/My97/WdatePicker.js"></script>
	
	<script type="text/javascript" src="${ctx}/static/custom/depar.js"></script>
	
	<!-- 工时校验-->
	<script type="text/javascript" src="${ctx}/static/custom/validateT.js"></script>
	
	<script type="text/javascript">
		$(function () { 
			startPlugin.init("${ctx}");
			startPlugin.startInit();
		});
		
		
		
		//alert(i);
		var i = $("#tags").find("tr").length+1;
		function addValueFun(){  
			var h=$("td.project_table_no_cls").size()+1;
			
			var str = "<tr>"
							+"<td class='project_table_no_cls'>"+h+"<input type =\"hidden\" id='' name='efficiencyRecordBo["+i+"].efficiencyIds' /></td>"
							+"<td><select id='department_id_"+i+"' onchange='empFun(this.id)' name='efficiencyRecordBo["+i+"].departmentId' class='span2 required'><option>--请选择--</option></select></td>"
							+"<td><select id='employe_id_"+i+"' name='efficiencyRecordBo["+i+"].employeId' class='span2 required'><option>--请选择--</option></select></td>"
							+"<td>"
								+"周期："
						   	   	+"<input class='Wdate input-small required' readonly='readonly' onFocus=\"WdatePicker({lang:\'zh-cn\',dateFmt:\'yyyy-MM-dd\',minDate:\'%y-%M-%d\' ,maxDate:\'#F{$dp.$D(\\'efficiencyRecordBo["+i+"].planEndTime\\')}\'})\""
								+"type='text' placeholder='—请选择—' id='efficiencyRecordBo["+i+"].planBeginTime' name='efficiencyRecordBo["+i+"].planBeginTime' />"
								+"-"
								+"<input class='Wdate input-small required' readonly='readonly' onFocus=\"WdatePicker({lang:\'zh-cn\',dateFmt:\'yyyy-MM-dd \',minDate:\'%y-%M-%d\',minDate:\'#F{$dp.$D(\\'efficiencyRecordBo["+i+"].planBeginTime\\')}\'})\" "
								+"type='text' placeholder='—请选择—' id='efficiencyRecordBo["+i+"].planEndTime' name='efficiencyRecordBo["+i+"].planEndTime' />&nbsp;"
								+"工时：<input type='text' id='efficiencyRecordBo["+i+"].planHours' name='efficiencyRecordBo["+i+"].planHours' class='input-small required digits workhours' minlength='1'/>"
							+"</td>"
							+"<td><input type='button' value='清空' onclick='delValueFun(this)'/></td>"
						+"</tr>";
						startPlugin.startInitParam({
							departmentId:"department_id_"+i
						});
			$("#tags").append(str);
			i=i+1;
		} 
		
		function delValueFun(obj){  
			$(obj).parent().parent().remove();
			genProjectTableNo();
		}
		
		function genProjectTableNo(){
			$("td.project_table_no_cls").each(function(index,element){
				$(element).html(index+1);
				
			});
			
		}
		
		function empFun(dep_id){
			var t = dep_id;
			var h = $("#"+t).find("option:selected").val();
		
			var first=$("#"+t );
			var second=first.parent().next().find('select')[0].id;
			
				$.ajax({ 
			        type: "GET", 
			       	url: "${ctx}/admin/employe/listAjax?departmentId="+h, 
			        dataType:"json", 
			        success: function(data){ 
			        		$("#"+second).html("");
			        	 	var tml = "<option  value = ''>--请选择--</option>"
				             $.each(data, function(){
				                tml += "<option value= "+this.id+">"+this.name+"</option>" ;
				             });
			        	 	$("#"+second).html(tml);
			        } ,
				});
		}
		
		
		function formatDate(times) {
			var date = new Date(times);
			var fm = date.format('yyyy-MM-dd');
			return fm;
		}
		
	</script>
</head>

<body>
	<form id="formId" action="${ctx}/efficiency/edit" method="post" >
		<div class="control-group">
			<label for="" class="control-label">项目名称:</label>
			<div class="controls">
				<input type="text" id="projectNameBo" name="projectNameBo" value="${project.name}"  class="input-large" />
				<input type ="hidden" id="" name="proId" value="${project.id }" />
			</div>
		</div>	
		
		<br/><input type='button' value='添加相关人员' onclick='addValueFun()' class="btn"/>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
			   <tr>
			   		<td>序号</td>
			   		<td>部门</td>
			   		<td>姓名</td>
			   		<td>计划时间</td>
			   		
			   		<td>操作</td>
			   </tr>
		   	</thead>
		   	<tbody id="tags"> 
		   		<c:forEach items="${list}" var="listTemp" varStatus="s" >
				   	 <tr>
				   	   	<td class="project_table_no_cls">
				   	   		${s.index+1}
				   	   		<input type ="hidden" id="" name="efficiencyRecordBo[${s.index}].efficiencyIds" value="${listTemp.id }" />
				   	   	</td>
				   	   	<td>
				   	   		<select id="department_id_${s.index}"  onchange="empFun(this.id)"  name="efficiencyRecordBo[${s.index}].departmentId" class="span2 required">
								<!-- <option value = "">--请选择--</option> -->
								<c:forEach items="${departmentList}" var="temp" varStatus="x" >
										<c:choose>
										 <c:when test="${listTemp.departmentId == temp.id}">
											<option value="${temp.id}" selected="selected">${temp.name}</option>
										</c:when> 
										<%-- <c:otherwise> 
											<option value="${temp.id}" >${temp.name}</option>
										</c:otherwise>  --%>
									</c:choose>
								</c:forEach>
							</select>
						</td>
				   	   	<td>
							<select id="employe_id_${s.index}"  name="efficiencyRecordBo[${s.index}].employeId"  class="span2 required">
								<!-- <option value = "">--请选择--</option> -->
								<c:forEach items="${listTemp.employeList}" var="temp_em" varStatus="x" >
										<c:choose>
										 <c:when test="${listTemp.employeId == temp_em.id}">
											<option value="${temp_em.id}" selected="selected">${temp_em.name}</option>
										</c:when> 
										<%-- <c:otherwise> 
											<option value="${temp_em.id}" >${temp_em.name}</option>
										</c:otherwise>  --%>
									</c:choose>
								</c:forEach>
							</select>
						</td>
				   	   	<td>
				   	   		周期:
				   	   		<input class="Wdate input-small required"  readonly="readonly" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'efficiencyRecordBo[${s.index}].planEndTime\')}'})"
							type="text" placeholder="—请选择—" id="efficiencyRecordBo[${s.index}].planBeginTime"  value = "<fmt:formatDate value= '${listTemp.planBeginTime}' pattern='yyyy-MM-dd'/>" name="efficiencyRecordBo[${s.index}].planBeginTime" />
							-<input class="Wdate input-small required" readonly="readonly" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd ',minDate:'%y-%M-%d' ,minDate:'#F{$dp.$D(\'efficiencyRecordBo[${s.index}].planBeginTime\')}'})" 
							type="text" placeholder="—请选择—" id="efficiencyRecordBo[${s.index}].planEndTime" value = "<fmt:formatDate value= '${listTemp.planEndTime}' pattern='yyyy-MM-dd'/>"  name="efficiencyRecordBo[${s.index}].planEndTime"  />&nbsp;
							工时：<input type="text" id="efficiencyRecordBo[${s.index}].planHours" name="efficiencyRecordBo[${s.index}].planHours" value = "${listTemp.planHours}" class="input-small required digits workhours"  minlength="1"/>
						</td>
				   	   	<td><input type="button" value="清空" onclick="delValueFun(this)"/></td>
				   	  </tr> 
			   	 </c:forEach>	
		   	</tbody>
			
		</table>
		<div class="form-actions">
			<input id="submit_btn" class="btn btn-primary" type="submit" value="提交"/>&nbsp;	
			<!-- <input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/> -->
		</div>
	</form>
	
	<script type="text/javascript">
	$(function() {
		 validate();
	})
	</script>
	<script type="text/javascript">
		function validate() {
			$("#formId").validate({
				rules : {
					projectNameBo:{
						required:true,
						minlength: 2,
						maxlength:20,
					},
				},
				messages : {
					projectNameBo:{
					    required: "必填字段",
					    minlength: jQuery.format("请输入一个长度不能小于{0}"),
					    maxlength: jQuery.format("请输入一个 长度不能超过 {0}"),
					   },
					
				},
				submitHandler:function(form){
					 form.submit();
			    }  
			});
		}
	</script>
</body>
</html>
