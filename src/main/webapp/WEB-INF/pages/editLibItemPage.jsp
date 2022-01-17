<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 17.01.2022
  Time: 5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="<c:url value="/res/style.css"/>" rel="stylesheet" type="text/css"/>
    <link rel="icon" type="image/png" href="<c:url value="/res/favicon.png"/>"/>
    <c:choose>
        <c:when test="${empty film.itemName}">
            <title>Добавить книгу</title>
        </c:when>
        <c:otherwise>
            <title>Редактировать книгу</title>
        </c:otherwise>
    </c:choose>
</head>
<body class="style library">
<c:url value="/addlibitem" var="addUrl"/>
<c:url value="/editlibitem" var="editUrl"/>
<form class="style" action="${empty film.itemName ? addUrl : editUrl}" name="film" method="POST">
    <%--
return Objects.equals(libraryItemNo, libitem.libraryItemNo)
        && Objects.equals(libraryNo, libitem.libraryNo)
        && Objects.equals(itemName, libitem.itemName)
        && Objects.equals(itemAuthor, libitem.itemAuthor)
        && Objects.equals(genre, libitem.genre)
        && Objects.equals(itemDesc, libitem.itemDesc)
        && Objects.equals(itemYear, libitem.itemYear)
        && Objects.equals(publisherName, libitem.publisherName)
        && Objects.equals(pages, libitem.pages)
        && Objects.equals(addingDate, libitem.addingDate);
    --%>
    <c:choose>
        <c:when test="${!empty film.itemName}">
            <p class="heading">Редактировать книгу</p>
            <input type="hidden" name="id" value="${film.libraryItemNo}">
        </c:when>
        <c:otherwise>
            <p class="heading">Добавить книгу</p>
        </c:otherwise>
    </c:choose>
    <p><input type="hidden" name="libraryItemNo" placeholder="libraryItemNo" value="${film.libraryItemNo}"></p>
    <p><input type="hidden" name="libraryNo" placeholder="libraryNo [*]" value="${!empty film.libraryNo ? film.libraryNo : "1"}" required></p>
    <p><input type="text" name="itemName" placeholder="Название" value="${film.itemName}" maxlength="2000" required autofocus pattern="^[^\s]+(\s.*)?$"></p>
    <p><input type="text" name="itemAuthor" placeholder="Автор" value="${film.itemAuthor}" maxlength="255"></p>
    <p><input type="text" name="genre" placeholder="Жанр" value="${film.genre}" maxlength="255"></p>
    <p><input type="text" name="itemDesc" placeholder="Описание" value="${film.itemDesc}" maxlength="4000"></p>

    <p><input type="number" name="itemYear" placeholder="Год" value="${film.itemYear}" maxlength="4"
              oninput="if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"></p>
<%--    <p><input type="number" name="itemYear" placeholder="Год" value="${film.itemYear}" maxlength="4"></p>--%>
    <p><input type="text" name="publisherName" placeholder="Издательство" value="${film.publisherName}" maxlength="500"></p>
    <p><input type="number" name="pages" placeholder="Страниц" value="${film.pages}"></p>

        <%
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

            // Get the date today using Calendar object.
            Date today = Calendar.getInstance().getTime();
            // Using DateFormat format method we can create a string
            // representation of a date with the defined format.
            String reportDate = df.format(today);
        %>
        <c:choose>
            <c:when test="${!empty film.addingDate}">
                <p><input type="hidden" name="addingDate" placeholder="Дата добавления" value="${film.addingDate}" required></p>
            </c:when>
            <c:otherwise>
                <p><input type="hidden" name="addingDate" placeholder="Дата добавления" value="<%=reportDate%>" required></p>
            </c:otherwise>
        </c:choose>


    <%--        <p class="checkbox">--%>
    <%--            <label for="watched">watched--%>
    <%--                <c:if test="${film.watched == true}">--%>
    <%--                    <input type="checkbox" name="watched" id="watched" value="${film.watched}" checked>--%>
    <%--                </c:if>--%>
    <%--                <c:if test="${film.watched != true}">--%>
    <%--                    <input type="checkbox" name="watched" id="watched">--%>
    <%--                </c:if>--%>
    <%--                <span class="checkbox-common checkbox-no">no</span>--%>
    <%--                <span class="checkbox-common checkbox-yes">yes</span>--%>
    <%--            </label>--%>
    <%--        </p>--%>
    <p>
        <c:set value="Добавить" var="add"/>
        <c:set value="Редактировать" var="edit"/>
        <input type="submit" value="${empty film.itemName ? add : edit}">
    </p>
    <p class="heading">${message}</p>
</form>
</body>
</html>

