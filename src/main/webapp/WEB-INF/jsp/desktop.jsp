<%@taglib prefix="tags" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page language="Java"
        contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
<%--        errorPage="login.jsp"--%>
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

<c:choose>
    <c:when test="${questions.isStarted()}">
        <title>${PROJECT_NAME} (тест)</title>
    </c:when>
    <c:otherwise>
        <title>${PROJECT_NAME} (результат тестирования)</title>
    </c:otherwise>
</c:choose>
    </head>
    <body>
<%@ include file="header.jsp" %>
        <div>
            ${result}
        </div>
        <hr>
<c:choose>
    <c:when test="${webUser.isDefinedUser()}">
<c:choose>
    <c:when test="${questions.isStarted()}">
        <form:form method="post" action="result.jsp" name="result" autocomplete="on">
        <% int qq = 0; %>
        <c:forEach items="${questions.getQuestionsList()}" var="itemQuestion">
                <div>
                        <fieldset style="border-radius: 10px;">
                            <legend><h5>[<%=qq+1%> из ${questions.getQuestionMax()}] ${itemQuestion.getAuthor()}</h5></legend>
                            <h3>${itemQuestion.getQuestion()}</h3>
            <% int aa = 0; %>
            <c:forEach items="${itemQuestion.getAnswersList()}" var="itemAnswer">
                                <hr>
                                <p>
                                    <label><input type="${itemQuestion.getType()}" id="answer<%=qq%>" name="answer<%=qq%>" value="<%=aa%>" ${itemAnswer.isSelectedHTML()} />
                                    ${itemAnswer.getAnswer()}</label>
                                </p>
                <% aa++; %>
            </c:forEach>
                        </fieldset>
                </div>
                </br>
                <% qq++; %>
        </c:forEach>
            <hr>
            <button style="width: 250px; height: 32px; background: #19aa39; color: #FFF;" class="button" type="submit" value="Submit">
                <div id="label-desktop">
                    <span id="report_ru">ЗАВЕРШИТЬ ТЕСТИРОВАНИЕ</span>
                </duv>
            </button>
        </form:form>
    </c:when>
    <c:otherwise>
        <form:form method='post' action="params.jsp" name='params' autocomplete='off' modelAttribute="webParams">
            <c:if test="${questions.isShowAnswers()}">
            <% int qq = 0; %>
            <c:forEach items="${questions.getQuestionsList()}" var="itemQuestion">
                <div>
                        <fieldset style="border-radius: 10px;">
                            <legend><h5>[<%=qq+1%> из ${questions.getQuestionMax()}] ${itemQuestion.getAuthor()}</h5></legend>
                            <h3>${itemQuestion.getQuestion()}</h3>
            <% int aa = 0; %>
            <c:forEach items="${itemQuestion.getAnswersList()}" var="itemAnswer">
                                <hr>
                                <p style="background-color:${itemAnswer.getColorHTML()}">
                                    <label><input type="${itemQuestion.getType()}" id="answer<%=qq%>" name="answer<%=qq%>" value="<%=aa%>" ${itemAnswer.isSelectedHTML()} disabled />
                                    ${itemAnswer.getAnswer()}</label>
                                </p>
                <% aa++; %>
            </c:forEach>
                        </fieldset>
                </div>
                </br>
            <% qq++; %>
            </c:forEach>
            </c:if>
            <hr>
             <button style="width: 250px; height: 32px; background: #19aa39; color: #FFF;" class="button" type="submit" value="Submit">
                <span id="report_ru">ВЫБОР ТЕМЫ ТЕСТИРОВАНИЯ</span>
            </button>
        </form:form>
    </c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
    Необходима авторизация !
</c:otherwise>
</c:choose>
    </body>
</html>