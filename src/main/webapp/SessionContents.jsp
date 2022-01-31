<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html" />

<title>HTTP Session Content</title>

<link type="text/css" rel="stylesheet" href='<c:url value="/style.css"/>' />

<script type="text/javascript">
	
		function edit(key, value) {
			var n = document.getElementsByName('dataname');
			var v = document.getElementsByName('datavalue');
	
			n[0].value = key;
			v[0].value = value;
		}
	
		function remove(key) {
			var a = document.getElementsByName('dataaction');
			var n = document.getElementsByName('dataname');
			
			a[0].value = 'Remove';
			n[0].value = key;
			
			document.getElementById('sessionForm').submit();
		}
	</script>
</head>

<body>
	<img src="1200px-Redis_Logo.svg.png" width="100px"/>
	<h3>Session Information</h3>
	<%	
			Date created = new Date(session.getCreationTime());
			Date accessed = new Date(session.getLastAccessedTime());
			String hostName = request.getServerName();
			String sessionId = session.getId();
		%>
	<br />
	<table>
		<tr>
			<td>Session creation time:</td>
			<td><%=created%></td>
		</tr>
		<tr>
			<td>Session Last access time:</td>
			<td><%=accessed%></td>
		</tr>
		<tr>
			<td>Servlet container host name:</td>
			<td><%=hostName%></td>
		</tr>
		<tr>
			<td>Session ID:</td>
			<td><%=sessionId%></td>
		</tr>
	</table>
	<h3>Session Edit:</h3>
	<p />

	<form id="sessionForm" action='<%=response.encodeURL("SimpleServlet")%>' method="post">

		<table id="table1" align="left">
			<tr>
				<td>Session Attribute Name: <input type="hidden" name="dataaction" /></td>
				<td><input type="text" size="20" name="dataname" /></td>
			</tr>
			<tr>
				<td>Session Attribute Value:</td>
				<td><input type="text" size="20" name="datavalue" /></td>
			</tr>
			<tr>
				<td><input type="submit" value="Update Session" /></td>
			</tr>
		</table>

	</form>

	<br />
	<br />
	<br />
	<h3>Session Content:</h3>
	<p />

	<table style="width: 60%" border="1" >
		<tr>
			<td width="25%" align="center"><b>Name</b></td>
			<td width="50%" align="center"><b>Value</b></td>
			<td width="25%" align="center"></td>
		</tr>
		<%
				Enumeration names = session.getAttributeNames();
				while (names.hasMoreElements()) {
					String name = (String) names.nextElement();
					String value = session.getAttribute(name).toString();
			%>
		<tr>
			<td width="25%" ><%=name%></td>
			<td width="50%" ><%=value%></td>
			<td width="25%" ><a href="javascript:edit('<%=name%>','<%=value%>');">Edit</a>
				&nbsp;|&nbsp;<a href="javascript:remove('<%=name%>')">Delete</a></td>
		</tr>

		<%
				}
			%>
	</table>

</body>
</html>