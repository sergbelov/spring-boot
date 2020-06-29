<%@taglib prefix="tags" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page language="Java"
        contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
        errorPage="login.jsp"
%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Подключаем bootstrap CSS (webjars в pom.xml) -->
        <link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />

        <c:url value="/css/style.css" var="style" />
        <c:url value="/img/test.png" var="logo"/>
        <c:url value="/img/exit.png" var="exit"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${style}">
        <title>${PROJECT_NAME} (результат тестирования)</title>
    </head>
    <body>
<%@ include file="header.jsp" %>
        <p>Тестирование завершено</p>
        ${result}
    </body>
</html>