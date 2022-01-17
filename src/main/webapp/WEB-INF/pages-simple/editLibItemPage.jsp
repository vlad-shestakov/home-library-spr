<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 17.01.2022
  Time: 5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <c:choose>
        <c:when test="${empty film.itemName}">
            <title>Add</title>
        </c:when>
        <c:otherwise>
            <title>Edit</title>
        </c:otherwise>
    </c:choose>
</head>
<body>
<c:url value="/add" var="addUrl"/>
<c:url value="/edit" var="editUrl"/>
<form action="${empty film.itemName ? addUrl : editUrl}" name="film" method="POST">
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
            <p>Edit film</p>
            <input type="hidden" name="id" value="${film.libraryItemNo}">
        </c:when>
        <c:otherwise>
            <p>Add new film</p>
        </c:otherwise>
    </c:choose>
    <p><input type="text" name="title" placeholder="title" value="${film.itemName}" maxlength="100" required>
    <p><input type="number" name="year" placeholder="year" value="${film.itemYear}" required>
    <p><input type="text" name="genre" placeholder="genre" value="${film.genre}" maxlength="20" required>
<%--    <p>--%>
<%--        <c:if test="${film.watched == true}">--%>
<%--            <input type="checkbox" name="watched" id="watched" checked>--%>
<%--        </c:if>--%>
<%--        <c:if test="${film.watched != true}">--%>
<%--            <input type="checkbox" name="watched" id="watched">--%>
<%--        </c:if>--%>
<%--        <label for="watched">watched</label>--%>
<%--    </p>--%>
    <p>
        <c:set value="add" var="add"/>
        <c:set value="edit" var="edit"/>
        <input type="submit" value="${empty film.itemName ? add : edit}">
    </p>
    <p>${message}</p>
</form>
</body>
</html>

