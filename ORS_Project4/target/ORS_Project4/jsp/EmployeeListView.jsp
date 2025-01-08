<%@page import="com.rays.pro4.Bean.EmployeeBean"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Model.EmployeeModel"%>
<%@page import="com.rays.pro4.controller.EmployeeListCtl"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>Student List</title>

<script src="<%=ORSView.APP_CONTEXT %>/js/jquery.min.js""></script>
<script src="<%=ORSView.APP_CONTEXT %>/js/Checkbox11.js"></script>


</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.EmployeeBean"
		scope="request"></jsp:useBean>


	<form action="<%=ORSView.EMPLOYEE_LIST_CTL%>" method="post">
		<%@include file="Header.jsp"%>

		<center>

			<div align="center">
				<h1>Employee List</h1>
				<h3>
					<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
					<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>
			</div>



			<%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<EmployeeBean> it = list.iterator();

	       			if(list.size() !=0){
                    %>

			<table width="100%" align="center">
				<tr align="center">
					<td align="center"><label>Full Name:</label> <input type="text"
						name="fullName" placeholder="Enter Full Name" Size="22"
						value="<%=ServletUtility.getParameter("fullName", request)%>">
						<!-- 	&nbsp;
                 --> <label>User Name:</label> <input type="text"
						name="userName" placeholder="Enter User Name" Size="22"
						value="<%=ServletUtility.getParameter("userName", request)%>">
						<!--     &nbsp;
 --> <label>ContactNumber:</label> <input type="text"
						name="contactNumber" placeholder="Enter Contact Number" Size="22"
						value="<%=ServletUtility.getParameter("contactNumber", request)%>">
						<!--  &nbsp; --> <input type="submit" name="operation"
						value="<%=EmployeeListCtl.OP_SEARCH%>"> <input
						type="submit" name="operation"
						value="<%=EmployeeListCtl.OP_RESET%>"></td>
				</tr>
			</table>

			<br>

			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: skyblue">
					<th><input type="checkbox" id="select_all" name="select">Select
						All.</th>

					<th>S No.</th>
					<th>Full Name.</th>
					<th>User Name.</th>
					<th>Password.</th>
					<th>Date Of Birth.</th>
					<th>Contact Number.</th>
					<th>Edit</th>
				</tr>

				<%
                	while(it.hasNext())
                	{
                	 bean = it.next();
                %>



				<tr align="center">
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId() %>">
					<td><%=index++%></td>
					<td><%=bean.getFullName()%></td>
					<td><%=bean.getUserName()%></td>
					<td><%=bean.getPassword()%></td>
					<td><%=bean.getBirthDate()%></td>
					<td><%=bean.getContactNumber()%></td>
					<td><a href="EmployeeCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
                    }
                %>
			</table>
			<table width="100%">
				<tr>
					<%if(pageNo == 1){ %>
					<td><input type="submit" name="operation" disabled="disabled"
						value="<%=EmployeeListCtl.OP_PREVIOUS%>"> <%}else{ %>
					<td><input type="submit" name="operation"
						value="<%=EmployeeListCtl.OP_PREVIOUS%>"></td>
					<%} %>

					<td><input type="submit" name="operation"
						value="<%=EmployeeListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=EmployeeListCtl.OP_NEW%>"></td>

					<% EmployeeModel model = new EmployeeModel();                  
                  %>
					<% if(list.size() < pageSize || model.nextPK()-1 == bean.getId()){ %>
					<td align="right"><input type="submit" name="operation"
						disabled="disabled" value="<%=EmployeeListCtl.OP_NEXT%>"></td>
					<%}else{ %>
					<td align="right"><input type="submit" name="operation"
						value="<%=EmployeeListCtl.OP_NEXT%>"></td>
					<%} %>

				</tr>
			</table>
			<%}if(list.size() == 0){ %>
			<td align="center"><input type="submit" name="operation"
				value="<%=EmployeeListCtl.OP_BACK%>"></td>
			<% } %>

			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</center>

	<%@include file="Footer.jsp"%>
</body>
</html>