<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 17.01.2022
  Time: 4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>LIBRARY ITEMS</title>
</head>
<body>
<table>
    <caption>Library items</caption>
    <tr>
        <th>№</th>
<%--        <th>libraryItemNo</th>--%>
<%--        <th>libraryNo</th>--%>
        <th>libraryNo</th>
        <th>title</th>
        <th>author</th>
        <th>genre</th>
        <th>description</th>
        <th>year</th>
        <th>publisher</th>
        <th>pages</th>
        <th>adding date</th>
<%--        <th>watched</th>--%>
        <th colspan="2">action</th>
    </tr>
    <c:forEach var="film" items="${filmsList}" varStatus="i">
        <tr>
            <td>${i.index + 1 + (page - 1) * 10}</td>
<%--            <td>${film.libraryItemNo}</td>--%>
            <td>${film.libraryNo}</td>
            <td>${film.itemName}</td>
            <td>${film.itemAuthor}</td>
            <td>${film.genre}</td>
            <td>${film.itemDesc}</td>
            <td>${film.itemYear}</td>
            <td>${film.publisherName}</td>
            <td>${film.pages}</td>
            <td>${film.addingDate}</td>
<%--            <td>${film.watched}</td>--%>
            <td><a href="<c:url value="/editlibitem/${film.libraryItemNo}"/>">edit</a></td>
            <td><a href="<c:url value="/deletelibitem/${film.libraryItemNo}"/>">delete</a></td>
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
        </tr>
    </c:forEach>
    <tr>
        <td colspan="7">
            <a href="<c:url value="/addlibitem"/>">Add new library item</a>
            <c:forEach begin="${1}" end="${pagesCount}" step="1" varStatus="i">
                <c:url value="libitems" var="url">
                    <c:param name="page" value="${i.index}"/>
                </c:url>
                <a href="${url}">${i.index}</a>
            </c:forEach>
        </td>
    </tr>
    <tr>
        <td colspan="7">
            <a href="<c:url value="/"/>">Films</a>
        </td>
    </tr>
</table>
</body>
</html>



