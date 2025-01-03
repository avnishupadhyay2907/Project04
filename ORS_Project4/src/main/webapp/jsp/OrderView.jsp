<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.controller.OrderCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order View</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#udate4" ).datepicker({
      changeMonth: true,
      changeYear: true,
	  yearRange:'1980:2002', 
	  
    });
  } );
  </script>


</head>
<body>
    <jsp:useBean id="bean" class="com.rays.pro4.Bean.OrderBean" scope="request"></jsp:useBean>
    	
	<form action="<%=ORSView.ORDER_CTL%>" method="post">
    <%@include file="Header.jsp"%>
    
    <% 
    	List <CustomerBean> clist = (List <CustomerBean>)request.getAttribute("customerList");
    
    %>
    
    <center>
        <h1>
        	<%
        		if( bean != null && bean.getId()>0){
        	%> 
        	<tr><th><font>Update Order</font></th></tr>
        	<% }else{%>
        	<tr><th><font>Add Order</font></th></tr>
        	<% }%>
        </h1>
		
		<div>
		<h3><font style="color: green"><%=ServletUtility.getSuccessMessage(request) %></font></h1>
		<h3><font style="color: red"><%=ServletUtility.getErrorMessage(request) %></font>
		</h1>
		</div>
		
		<input type="hidden" name="id" value="<%=bean.getId()%>">
		<input type="hidden" name="createdby" value="<%=bean.getCreatedBy()%>">
		<input type="hidden" name="modifiedby" value="<%=bean.getModifiedBy()%>">
		<input type="hidden" name="createddatetime" value="<%=bean.getCreatedDatetime()%>">
		<input type="hidden" name="modifieddatetime" value="<%=bean.getModifiedDatetime()%>">

	<table>
	
		<tr>
		<th align="left">Customer Name <span style="color: red">*</span> :</th>
		<td><%=HTMLUtility.getList("customerName", String.valueOf(bean.getCustomerId()), clist)%>
		<td style="position: fixed"><font color="red" ><%=ServletUtility.getErrorMessage("customerName", request)%></font>
		</td>
		</tr>
		
	  <tr><th style="padding: 3px"></th></tr>    	
		
		 
		
		 <tr>
		  <th align="left">Order Date <span style="color: red">*</span> :</th>
          <td><input type="text" name="orderDate" id="udate4" readonly="readonly" placeholder=" Order Date" size="25"  value="<%=DataUtility.getDateString(bean.getOrderDate())%>"></td> 
         <td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("orderDate", request)%></font></td>
                </tr>
   
   <tr><th style="padding: 3px"></th></tr>    
	
		<tr>
		<th align="left">Total Amount <span style="color: red">*</span> :</th>
		<td><input type="text" name="totalAmount" maxlength="10" placeholder="Enter Total Amount" size="25" value="<%=DataUtility.getStringData(bean.getTotalAmount())%>"></td>
		<td style="position: fixed" ><font color="red"><%=ServletUtility.getErrorMessage("totalAmount", request)%></font>
		</td>
		</tr>
	
		  <tr><th style="padding: 3px"></th></tr>    
	
		
		

	<tr>
	<th></th>
		<%
		if(bean.getId() > 0){ %>
		<td>
		 &nbsp;  &emsp;
		<input type="submit" name="operation" value="<%=OrderCtl.OP_UPDATE %>">
		 &nbsp;  &nbsp;
		<input type="submit" name="operation" value="<%=OrderCtl.OP_CANCEL%>"></td>
		<%}else{ %>
		<td>
		 &nbsp;  &emsp;
		<input type="submit" name="operation" value="<%=OrderCtl.OP_SAVE %>">
		 &nbsp;  &nbsp;
		<input type="submit" name="operation" value="<%=OrderCtl.OP_RESET%>"></td>
	
		<%} %>
	</tr>
	
	</table>
</form>
</center>

<%@ include file = "Footer.jsp" %>
</body>
</html>