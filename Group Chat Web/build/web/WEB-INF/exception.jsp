<%-- 
    Document   : exception
    Created on : Mar 11, 2019, 2:50:54 PM
    Author     : Lenovo T530
--%>

<%@page import="exception.MyException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Exception Occurred</h1>
        <h3>Exception Code : <%= ((MyException) request.getAttribute("exception")).getErrorCode() %></h3>
    </body>
</html>
