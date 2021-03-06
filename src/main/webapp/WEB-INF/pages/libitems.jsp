<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 17.01.2022
  Time: 7:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Книжная библиотека</title>
    <link href="<c:url value="/res/style.css"/>" rel="stylesheet" type="text/css"/>
    <link rel="icon" type="image/png" href="<c:url value="/res/favicon.png"/>"/>
</head>
<body class="style library">
<table class="style">
    <caption class="heading">Книжная библиотека</caption>
    <c:if test="${filmsCount > 0}">
        <tr>
            <th class="left-side">№</th>
            <%--        <th>libraryItemNo</th>--%>
            <%--        <th>libraryNo</th>--%>
<%--            <th>libraryNo</th>--%>
            <th style="width: 100%">Название</th>
            <th>Автор</th>
            <th>Жанр</th>
<%--            <th>description</th>--%>
            <th>Год</th>
<%--            <th>publisher</th>--%>
<%--            <th>pages</th>--%>
<%--            <th>adding date</th>--%>
            <%--        <th>watched</th>--%>
            <th colspan="2" class="right-side">Действие</th>
        </tr>
        <c:forEach var="film" items="${filmsList}" varStatus="i">
            <tr>
                <td class="left-side">${i.index + 1 + (page - 1) * 10}</td>
                    <%--            <td>${film.libraryItemNo}</td>--%>
<%--                <td>${film.libraryNo}</td>--%>
                <td class="title">${film.itemName}</td>
                <td>${film.itemAuthor}</td>
                <td>${film.genre}</td>
<%--                <td>${film.itemDesc}</td>--%>
                <td>${film.itemYear}</td>
<%--                <td>${film.publisherName}</td>--%>
<%--                <td>${film.pages}</td>--%>
<%--                <td>${film.addingDate}</td>--%>
<%--                <td>--%>
<%--                    <c:if test="${film.watched}">--%>
<%--                        <span class="icon icon-watched"></span>--%>
<%--                    </c:if>--%>
<%--                </td>--%>
                <td>
                    <a href="/editlibitem/${film.libraryItemNo}">
                        <span class="icon icon-edit"></span>
                    </a>
                </td>
                <td class="right-side">
                    <a href="/deletelibitem/${film.libraryItemNo}">
                        <span class="icon icon-delete"></span>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${filmsCount == 0}">
        <tr>
            <td colspan="7" style="font-size: 150%" class="left-side right-side">
                Список пустой, но вы можете добавить книгу
            </td>
        </tr>
    </c:if>
    <tr>
        <td colspan="7" class="left-side link right-side">
            <a style="margin-right: 70px; font-size: 100%" href="<c:url value="/addlibitem"/>">
                <span class="icon icon-add"></span>Добавить книгу
            </a>
            <c:if test="${pagesCount > 1}">
                <c:set value="disabled" var="disabled"/>
                <c:set value="" var="active"/>
                <c:url value="/libitems" var="url">
                    <c:param name="page" value="1"/>
                </c:url>
                <a class="${page == 1 ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-first"></span>&nbsp
                </a>
                <c:url value="/libitems" var="url">
                    <c:param name="page" value="${page - 1}"/>
                </c:url>
                <a class="${page == 1 ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-prev"></span>&nbsp
                </a>

                <c:if test="${pagesCount <= 5}">
                    <c:set var="begin" value="1"/>
                    <c:set var="end" value="${pagesCount}"/>
                </c:if>
                <c:if test="${pagesCount > 5}">
                    <c:choose>
                        <c:when test="${page < 3}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="5"/>
                        </c:when>
                        <c:when test="${page > pagesCount - 2}">
                            <c:set var="begin" value="${pagesCount - 4}"/>
                            <c:set var="end" value="${pagesCount}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="begin" value="${page - 2}"/>
                            <c:set var="end" value="${page + 2}"/>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <c:forEach begin="${begin}" end="${end}" step="1" varStatus="i">
                    <c:url value="/libitems" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <c:set value="current-page" var="current"/>
                    <c:set value="" var="perspective"/>
                    <a class="${page == i.index ? current : perspective}" href="${url}">${i.index}</a>
                </c:forEach>

                <c:url value="/libitems" var="url">
                    <c:param name="page" value="${page + 1}"/>
                </c:url>
                <a class="${page == pagesCount ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-next"></span>&nbsp
                </a>
                <c:url value="/libitems" var="url">
                    <c:param name="page" value="${pagesCount}"/>
                </c:url>
                <a class="${page == pagesCount ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-last"></span>&nbsp
                </a>
            </c:if>
            <span style="margin-left: 70px; font-size: 120%">Всего книг: ${filmsCount}</span>
        </td>
    </tr>



<%--    <tr>--%>
<%--        <td colspan="7">--%>
<%--            <a href="<c:url value="/addlibitem"/>">Add new library item</a>--%>
<%--            <c:forEach begin="${1}" end="${pagesCount}" step="1" varStatus="i">--%>
<%--                <c:url value="libitems" var="url">--%>
<%--                    <c:param name="page" value="${i.index}"/>--%>
<%--                </c:url>--%>
<%--                <a href="${url}">${i.index}</a>--%>
<%--            </c:forEach>--%>
<%--        </td>--%>
<%--    </tr>--%>

<%--    <tr>--%>
<%--        <td colspan="7">--%>
<%--            <a href="<c:url value="/"/>">Films</a>--%>
<%--        </td>--%>
<%--    </tr>--%>


    <td colspan="7" class="left-side link right-side">
        <a style="margin-right: 70px; font-size: 100%" href="<c:url value="/"/>">
            <span class="icon icon-watched"></span>Библиотека фильмов
        </a>
    </td>
</table>
</body>
</html>



