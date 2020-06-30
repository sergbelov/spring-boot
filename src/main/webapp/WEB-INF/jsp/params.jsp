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
        <title>${PROJECT_NAME} (выбор темы)</title>
    </head>
    <body class="ru" id="ru">

<%@ include file="header.jsp" %>

    <c:if test="${not empty errorMessage}">
        <div class="error" id="error">
            <span id="message" class="error_message">${errorMessage}</span>
            <a href="javascript:;" class="error_close" onClick="removeError()"></a>
        </div>
    </c:if>
        <div class="popup" id="popup_enter">
            <div class="popup_top">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td>
                                <img src="${logo}" alt="" class="popup_logo" height="40px"/>
                            </td>
                            <td style="text-align:left;">
                                <span id="title_ru" class="popup_title">${PROJECT_NAME} (версия ${PROJECT_VERSION})</span>
                            </td>
                         </tr>
                    </tbody>
                </table>
            </div>
            <div class="popup_form_params">
<%--                <form:form method="get" action="desktop" name="desktop" autocomplete="on" modelAttribute="webParams">--%>
                <form:form method="post" action="result" name="result" autocomplete="on">
                    <p>
                        <label for="theme" id="label-theme" >
                            <span id="theme_ru" class="label-ru">ТЕМА ТЕСТИРОВАНИЯ</span>
                        </label>
                        <div class="select">
                            <select id="theme" name="theme" required="reguired">
                                <c:forEach items="${themesList}" var="item">
                                    <option value="${item}">${item}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </p>
                    <button type="submit" value="Submit" class="button">
                        <div id="label-report">
                            <span id="report_ru">НАЧАТЬ ТЕСТИРОВАНИЕ</span>
                        </div>
                    </button>

                </form:form>
            </div>
        </div>
        <script type="text/javascript">
            function removeError() {
                var errorParent = document.getElementById('ru')
                var error = document.getElementById('error')
                errorParent.removeChild(error);
            }
        </script>
    </body>
</html>
