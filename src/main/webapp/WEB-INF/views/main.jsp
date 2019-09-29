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
    <title>Intelligent Financial Helper</title>
</head>
<body>
<!--header-->
<header class="header">
    <div class="container">
        <div class="row">
            <div class="logo">
                <a class="logo__link" href="<c:url value="/"/>">
                    <img class="logo__img" src="<c:url value="/resources/img/logo.svg"/>" alt="logo"/>
                </a>
            </div>
            <nav class="nav">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a class="nav__link" href="<c:url value="/"/>">Home</a>
                    </li>
                    <c:if test="${!isActive}">
                        <li class="nav__item">
                            <a class="nav__link" href="<c:url value="/user"/>">Login</a>
                        </li>
                        <li class="nav__item">
                            <a class="nav__link" href="<c:url value="/registration"/>">Registration</a>
                        </li>
                    </c:if>
                    <c:if test="${isActive}">
                        <li class="nav__item">
                            <a class="nav__link" href="<c:url value="/user"/>">Account</a>
                        </li>
                        <li class="nav__item">
                            <form class="nav__link nav__link--logout" action="<c:url value="/logout"/>" method="post">
                                <input class="nav__logout" type="submit" value="Sign Out"/>
                            </form>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <div class="row">
            <section class="greeting">
                <div class="greeting__container">
                    <h1 class="greeting__heading">Intelligent Financial Helper</h1>
                    <div class="register">
                        <c:if test="${isActive == false}">
                            <a class="register__btn" href="<c:url value="/registration"/>">Try it now!</a>
                        </c:if>
                    </div>
                </div>
            </section>
        </div>
    </div>
</header>
<!--content-->

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
<script type="text/javascript" src="<c:url value="/resources/js/main.js"/>"></script>
</body>
</html>