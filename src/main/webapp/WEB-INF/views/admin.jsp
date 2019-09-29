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
            <h1 class="admin__heading">Admin panel</h1>
        </div>
        <div class="row">
            <p class="admin__text">List of users</p>
        </div>
        <div class="row">
            <div class="admin__container">
                <table class="admin__table">
                    <tr class="admin__tr">
                        <th class="admin__th">ID</th>
                        <th class="admin__th">Name</th>
                        <th class="admin__th">Role</th>
                        <th class="admin__th"></th>
                    </tr>
                    <c:forEach items="${users}" var="user">
                        <tr class="admin__tr">
                            <td class="admin__td">${user.id}</td>
                            <td class="admin__td">${user.name}</td>
                            <td class="admin__td">
                                <ul class="admin__list">
                                    <c:forEach items="${user.roles}" var="role">
                                        <li class="admin__item">${role}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td class="admin__td">
                                <a class="admin__link" href="<c:url value="/admin/user/edit/${user.id}"/>">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
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
<script type="text/javascript" src="<c:url value="/resources/js/main.js"/>"></script>
</body>
</html>