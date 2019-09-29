<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/reset.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/fonts.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>"/>
    <title>${userName}'s account</title>
</head>
<body>
<!--header-->
<header class="header header--account">
    <div class="container">
        <div class="row">
            <div class="logo">
                <a class="logo__link" href="<c:url value="/"/>">
                    <img class="logo__img" src="<c:url value="/resources/img/logo.svg"/>" alt="logo"/>
                </a>
            </div>
            <div class="app-name">
                <h1 class="app-name__heading">Intelligent Financial Helper</h1>
            </div>
            <nav class="nav">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a class="nav__link" href="<c:url value="/"/>">Home</a>
                    </li>
                    <li class="nav__item">
                        <a class="nav__link" href="<c:url value="/user"/>">Account</a>
                    </li>
                    <li class="nav__item">
                        <a class="nav__link" href="<c:url value="/admin"/>">Admin</a>
                    </li>
                    <li class="nav__item">
                        <form class="nav__link nav__link--logout" action="<c:url value="/logout"/>" method="post">
                            <input class="nav__logout" type="submit" value="Sign Out"/>
                        </form>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<!--content-->
<section class="exchange">
    <div class="container">
        <div class="row"></div>
    </div>
</section>

<section class="admin">
    <div class="container admin__wrapper">
        <div class="row">
            <h1 class="admin__heading">User editor</h1>
        </div>
        <div class="row">
            <p class="admin__text">Update user</p>
        </div>
        <div class="row">
            <form class="admin__form" action="<c:url value="/admin/user/update"/>" method="post"
                  onsubmit="return CheckValidInput.check(
                                        '.admin__form',
                                        '.admin__input',
                                        '',
                                        '.admin__text')">
                <label><input class="admin__input" type="text" value="${user.name}" name="username"/></label>
                <ul class="admin__list">
                    <c:forEach items="${roles}" var="role">
                        <c:set var="contains" value="false"/>
                        <c:forEach items="${user.roles}" var="userRole">
                            <c:if test="${role eq userRole}">
                                <c:set var="contains" value="true"/>
                            </c:if>
                        </c:forEach>
                        <li class="admin__item">
                            <label>
                                <input class="admin__input admin__input--sm" type="checkbox" name="${role}"
                                        <c:if test="${contains}"> checked</c:if> />${role}
                            </label>
                        </li>
                    </c:forEach>
                </ul>
                <label><input type="hidden" value="${user.id}" name="userId"/></label>
                <input class="admin__submit" type="submit" value="Update"/>
                <p class="admin__text"></p>
            </form>
        </div>
        <div class="row">
            <p class="admin__text">Delete user</p>
        </div>
        <div class="row">
            <form class="admin__from" action="<c:url value="/admin/user/delete"/>" method="post">
                <label><input type="hidden" value="${user.id}" name="userId"/></label>
                <input class="admin__submit" type="submit" value="Delete"/>
            </form>
        </div>
    </div>
</section>
<!--footer-->
<footer class="footer">
    <div class="container">
        <div class="social-links">
            <a class="social-links__link" href="<c:url value="#"/>">
                <span class="social-links__pic social-links__pic--fb"></span>
            </a>
            <a class="social-links__link" href="<c:url value="#"/>">
                <span class="social-links__pic social-links__pic--twitter"></span>
            </a>
            <a class="social-links__link" href="<c:url value="#"/>">
                <span class="social-links__pic social-links__pic--linkedin"></span>
            </a>
            <a class="social-links__link" href="<c:url value="#"/>">
                <span class="social-links__pic social-links__pic--google-plus"></span>
            </a>
        </div>
        <div class="logo">
            <a class="logo__link" href="<c:url value="/"/>">
                <img class="logo__img" src="<c:url value="/resources/img/logo.svg"/>" alt="logo"/>
            </a>
        </div>
        <p class="footer__copyright">
            © Copyright <%= Calendar.getInstance().get(Calendar.YEAR)%>
        </p>
    </div>
</footer>

<script type="text/javascript" src="<c:url value="/resources/js/Ajax.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modules/Module.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modules/Exchange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modules/CheckValidInput.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/main.js"/>"></script>
</body>
</html>