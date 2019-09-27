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
    <link rel="icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">
    <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">
    <link rel="stylesheet" href="<c:url value="/resources/css/normalize.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/reset.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/fonts.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/main.js"/>"></script>
    <title>Login</title>
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
                </ul>
            </nav>
        </div>
        <div class="row">
            <section class="greeting">
                <div class="greeting__container">
                    <div class="auth__container">
                        <form class="auth-form" action="<c:url value="/login"/>" method="post"
                              onsubmit="return CheckValidInput.check(
                                        '.auth-form',
                                        '.auth-form__input--text',
                                        '',
                                        '.auth-form__text')">
                            <div class="row">
                                <label class="auth-form__label" for="username">User Name: </label>
                            </div>
                            <div class="row">
                                <input class="auth-form__input auth-form__input--text" type="text" name="username"
                                       id="username"/>
                            </div>
                            <div class="row">
                                <label class="auth-form__label" for="password">Password: </label>
                            </div>
                            <div class="row">
                                <input class="auth-form__input auth-form__input--text" type="password" name="password"
                                       id="password"/>
                            </div>
                            <div class="row">
                                <input class="auth-form__input auth-form__input--submit" type="submit" value="Sign In"/>
                                <a class="auth-registration-btn" href="<c:url value="/registration"/>">Registration</a>
                            </div>
                            <p class="auth-form__text"></p>
                        </form>
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
<script type="text/javascript" src="<c:url value="/resources/js/modules/CheckValidInput.js"/>"></script>
</body>
</html>