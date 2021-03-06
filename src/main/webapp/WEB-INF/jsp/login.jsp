<%@taglib prefix="tags" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page language="Java"
        contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Подключаем bootstrap CSS (webjars в pom.xml) -->
        <link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />

        <c:url value="/css/style.css" var="style" />
        <c:url value="/img/test.png" var="logo"/>
        <link rel="stylesheet" type="text/css" href="${style}">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${PROJECT_NAME} (авторизация)</title>
    </head>

    <body class="ru" id="ru">
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
            <div class="popup_form">
                <form:form method="post" action="params" name="params" autocomplete="off">
<%--                <form:form method="post" action="params" name="params" autocomplete="off" modelAttribute="webParams">--%>
<%--                <form th:action="@{/login}" method="post">--%>
					<table width="100%">
						<tbody>
							<tr>
								<td style="text-align:right;">
								    <label><span id="username_ru" class="label-ru">ИМЯ ПОЛЬЗОВАТЕЛЯ</span></label>
                                </td>
								<td style="text-align:right;">
<%--								    <input id="field-username" name="userName" type="text" value="${webUser.getUserName()}">--%>
								    <input id="field-username" name="userName" type="text" value="">
                                </td>
							</tr>
							<tr>
								<td style="text-align:right;">
								    <label><span id="password_ru" class="label-ru">ПАРОЛЬ</span></label>
                                </td>
								<td style="text-align:right;">
								    <input id="field-password" name="password" type="password" value="">
                                </td>
							</tr>
						</tbody>
					</table>
                    <button type="submit" value="Submit" class="button">
                        <div id="label-logon">
                            <span id="logon_ru">АВТОРИЗАЦИЯ</span>
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
