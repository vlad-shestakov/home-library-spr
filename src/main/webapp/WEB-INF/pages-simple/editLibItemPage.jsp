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
<c:url value="/addlibitem" var="addUrl"/>
<c:url value="/editlibitem" var="editUrl"/>
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
            <p>Edit library item</p>
            <input type="hidden" name="id" value="${film.libraryItemNo}">
        </c:when>
        <c:otherwise>
            <p>Add new library item</p>
        </c:otherwise>
    </c:choose>
        <p><input type="number" name="libraryItemNo" placeholder="libraryItemNo" value="${film.libraryItemNo}"></p>
        <p><input type="number" name="libraryNo" placeholder="libraryNo [*]" value="${film.libraryNo}" required></p>
        <p><input type="text" name="itemName" placeholder="itemName [*]" value="${film.itemName}" maxlength="2000" required></p>
        <p><input type="text" name="itemAuthor" placeholder="itemAuthor" value="${film.itemAuthor}" maxlength="255"></p>
        <p><input type="text" name="genre" placeholder="genre" value="${film.genre}" maxlength="255"></p>
        <p><input type="text" name="itemDesc" placeholder="itemDesc" value="${film.itemDesc}" maxlength="4000"></p>
        <p><input type="number" name="year" placeholder="year" value="${film.itemYear}"></p>
        <p><input type="text" name="publisherName" placeholder="publisherName" value="${film.publisherName}" maxlength="500"></p>
        <p><input type="number" name="pages" placeholder="pages" value="${film.pages}"></p>
        <p><input type="text" name="addingDate" placeholder="addingDate" value="${film.addingDate}"></p>
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
        <c:set value="add item" var="add"/>
        <c:set value="edit item" var="edit"/>
        <input type="submit" value="${empty film.itemName ? add : edit}">
    </p>
    <p>${message}</p>
</form>
</body>
</html>

