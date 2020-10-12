<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
