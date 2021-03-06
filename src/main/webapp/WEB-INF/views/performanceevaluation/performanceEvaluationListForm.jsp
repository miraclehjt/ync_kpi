<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>用户管理</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<ul class="nav nav-tabs nav-stacked">
					<li class="nav-header"><h4>${em.departmentName }绩效总评</h4></li>
					<c:forEach items="${pe.getContent()}" var="pc">
						<li><a
							href="${ctx }/performanceEvaluation/list?date=<fmt:formatDate value="${pc.createTime}" pattern="yyyy-MM"/>">${pc.peDateDepartment.replace('_','') }</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="span10">
				<h3>
				${em.departmentName }
					<fmt:formatDate value="${date}" pattern="yyyy-MM" />
					绩效总评
				</h3>
				<form id="updateForm" action="${ctx}/performanceEvaluation/update"
					method="POST">
					<table id="contentTable"
						class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>姓名</th>
								<th>效能</th>
								<th>专业</th>
								<th>客户满意</th>
								<th>上级评价</th>
								<th>总分</th>
								<th>总评级</th>
								<th>修改</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.getContent()}" var="p"
								varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${p.beEvaluatedName}</td>
									<td>${p.efficiencyScore}</td>
									<td>${p.specialtyScore}</td>
									<td>${p.satisfactionScore}</td>
									<td>${p.leaderAssessmentScore}</td>
									<td>${p.totalScore}</td>
									<td>${p.totalGrade}</td>
									<td><select
										name="PerformanceEvaluation[${status.index }].totalGrade">
											<c:if test="${p.totalScore >= avg}">
												<option
													<c:if test="${p.totalGrade == 'S'}"> selected = "selected"</c:if>
													value="S">S</option>
												<option
													<c:if test="${p.totalGrade == 'A'}"> selected = "selected"</c:if>
													value="A">A</option>
											</c:if>
											<option
												<c:if test="${p.totalGrade == 'B'}"> selected = "selected"</c:if>
												value="B">B</option>
											<option
												<c:if test="${p.totalGrade == 'C'}"> selected = "selected"</c:if>
												value="C">C</option>
											<option
												<c:if test="${p.totalGrade == 'D'}"> selected = "selected"</c:if>
												value="D">D</option>
									</select></td>
								</tr>
								<td><input type="hidden"
									name="PerformanceEvaluation[${status.index }].id"
									value="${p.id}" /></td>
							</c:forEach>
						</tbody>
					</table>
					<input id="btn" class="btn btn-large" type="button" value="提交" />
				</form>
				<h4>
					部门负责人调整绩效规则：<br />1.部门中有俩个S及以上人员，必须评一个D <br />2.分数后50%的部门员工不能改评A
				</h4>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var month = ${dateMonth};
		function sub() {
			var date = new Date();
			if (date.getDate() >= 3 && date.getDate() <= 5
					&& date.getMonth() + 1 == month) {

			} else {
				alert("太晚了T-T");
				return false;
			}
			var options = $("select option:selected");
			var s = 0;
			var d = 0;
			options.each(function(index, el) {
				if ($(el).val() == 'S') {
					s += 1;
				} else if ($(el).val() == 'D') {
					d += 1;
				}
			})
			if (s >= 2 && d < 1) {
				alert("部门中有俩个S及以上人员，必须评一个D");
			} else {
				return true;
			}
		}

		$(function() {
			$("#updateForm").submit(function() {
				var b = sub();
				if (b) {
					return true;
				}
				return false;
			});
			$("#btn").click(function() {
				$("#updateForm").submit();
			})
		})
	</script>
</body>
</html>
