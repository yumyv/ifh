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
                    <c:forEach items="${userRoles}" var="role">
                        <c:if test="${role eq 'ADMIN'}">
                            <li class="nav__item">
                                <a class="nav__link" href="<c:url value="/admin"/>">Admin</a>
                            </li>
                        </c:if>
                    </c:forEach>
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

<section class="account">
    <div class="container page-tab">
        <div class="page-tab__container">
            <button id="defaultOpenPageTab" class="page-tab__link" data-content="main" data-color="#00796b">Main
                panel
            </button>
            <button class="page-tab__link" data-content="wallets" data-color="#455a64">Wallets</button>
            <button class="page-tab__link" data-content="categories" data-color="#1565c0">Categories</button>
            <button class="page-tab__link" data-content="operations" data-color="#bb4d00">Operations</button>
            <button class="page-tab__link" data-content="settings" data-color="#6c6f00">Settings</button>
        </div>

        <div id="main" class="page-tab__content page-tab__content--main">
            <div class="row">
                <h1 class="account__heading">Welcome
                    <span class="account__heading account__heading--user-name">${userName} </span>
                    to Intelligent Financial Helper!</h1>
            </div>
            <div class="row">
                <div class="wallet-cell">
                    <div class="wallet-cell__container">
                        <c:if test="${wallets[0].id != null}">
                            <table class="wallet-cell__table">
                                <tr class="wallet-cell__tr">
                                    <th class="wallet-cell__th">Wallet</th>
                                    <th class="wallet-cell__th">Currency</th>
                                    <th class="wallet-cell__th">Value</th>
                                </tr>
                                <c:forEach items="${wallets}" var="wallet">
                                    <tr class="wallet-cell__tr">
                                        <td class="wallet-cell__td">${wallet.name}</td>
                                        <td class="wallet-cell__td">${wallet.currency}</td>
                                        <td class="wallet-cell__td">${wallet.value}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>
                    </div>

                    <c:if test="${wallets[0].id == null}">
                        <p class="wallet-cell__text">The list of wallets is empty! Please add a wallet.</p>
                    </c:if>

                    <p class="wallet-cell__text">Add new wallet</p>
                    <form class="wallet-cell__form" action="<c:url value="/user/wallet/add"/>" method="post"
                          onsubmit="return CheckValidInput.check(
                              '.wallet-cell__form',
                              '.wallet-cell__input--text',
                              '.wallet-cell__input--number',
                              '.wallet-cell__text')">
                        <div class="row">
                            <label class="wallet-cell__label" for="wallet-name">Name: </label>
                        </div>
                        <div class="row">
                            <input class="wallet-cell__input wallet-cell__input--text" type="text" id="wallet-name"
                                   name="name" placeholder="Example: Credit card" required/>
                        </div>
                        <div class="row">
                            <label class="wallet-cell__label" for="wallet-currency">Currency: </label>
                        </div>
                        <div class="row">
                            <input class="wallet-cell__input wallet-cell__input--text" type="text" id="wallet-currency"
                                   name="currency" placeholder="Example: USD" required/>
                        </div>
                        <div class="row">
                            <label class="wallet-cell__label" for="wallet-value">Start value: </label>
                        </div>
                        <div class="row">
                            <input class="wallet-cell__input wallet-cell__input--number" type="text" id="wallet-value"
                                   name="value" placeholder="Example: 100.50" required/>
                        </div>
                        <input class="wallet-cell__submit" type="submit" value="Add"/>
                        <p class="wallet-cell__text"></p>
                    </form>
                </div>

                <div class="main-cell">
                    <div class="operation-tab">
                        <div class="operation-tab__container">
                            <button id="defaultOpenOperationTab" class="operation-tab__link" data-content="expense"
                                    data-color="#8d6e63">Expense
                            </button>
                            <button class="operation-tab__link" data-content="transfer" data-color="#8d6e63">Transfer
                            </button>
                            <button class="operation-tab__link" data-content="income" data-color="#8d6e63">Income
                            </button>
                        </div>

                        <div id="expense" class="operation-tab__content">
                            <c:if test="${(categories[0].id != null) && (records[0].id != null) && (wallets[0].id != null)}">
                                <form class="operation-tab__form operation-tab__form--expense"
                                      action="<c:url value="/user/operation/add"/>" method="post"
                                      onsubmit="return CheckValidInput.check(
                                        '.operation-tab__form--expense',
                                        '',
                                        '.operation-tab__input',
                                        '.operation-tab__text')">
                                    <div class="row">
                                        <label class="operation-tab__label">From wallet:</label>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select" name="walletId">
                                                <c:forEach items="${wallets}" var="wallet">
                                                    <option class="operation-tab__option"
                                                            value="${wallet.id}">${wallet.name}</option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="row">
                                        <label class="operation-tab__label">Category:</label>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select" name="categoryId">
                                                <c:forEach items="${categories}" var="category">
                                                    <option class="operation-tab__option"
                                                            value="${category.id}">${category.name}</option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="row">
                                        <label class="operation-tab__label" for="operation-expense-value">Value:</label>
                                    </div>
                                    <div class="row">
                                        <input class="operation-tab__input" type="text" id="operation-expense-value"
                                               name="value" placeholder="Example: 100.50" required/>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select operation-tab__select--hidden"
                                                    name="recordId">
                                                <c:forEach items="${records}" var="record">
                                                    <c:if test="${record.name == 'expense'}">
                                                        <option class="operation-tab__option" value="${record.id}"
                                                                selected hidden></option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <input class="operation-tab__submit" type="submit" value="Add"/>
                                    <p class="operation-tab__text"></p>
                                </form>
                            </c:if>
                            <c:if test="${(categories[0].id == null) || (wallets[0].id == null)}">
                                <div class="row">
                                    <p>To add a new operation, you must add at least one wallet and one category</p>
                                </div>
                            </c:if>
                        </div>
                        <div id="transfer" class="operation-tab__content">
                            <c:if test="${(records[0].id != null) && (wallets[0].id != null)}">
                                <form class="operation-tab__form operation-tab__form--transfer"
                                      action="<c:url value="/user/operation/transfer"/>" method="post"
                                      onsubmit="return CheckValidInput.check(
                                        '.operation-tab__form--transfer',
                                        '',
                                        '.operation-tab__input--transfer',
                                        '.operation-tab__text')">
                                    <div class="row">
                                        <label class="operation-tab__label">From wallet:</label>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select" name="fromWalletId">
                                                <c:forEach items="${wallets}" var="wallet">
                                                    <option class="operation-tab__option"
                                                            value="${wallet.id}">${wallet.name}</option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="row">
                                        <label class="operation-tab__label">To wallet:</label>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select" name="toWalletId">
                                                <c:forEach items="${wallets}" var="wallet">
                                                    <option class="operation-tab__option"
                                                            value="${wallet.id}">${wallet.name}</option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="row">
                                        <label class="operation-tab__label"
                                               for="operation-transfer-value">Value:</label>
                                    </div>
                                    <div class="row">
                                        <input class="operation-tab__input operation-tab__input--transfer" type="text"
                                               id="operation-transfer-value"
                                               name="value" placeholder="Example: 100.50" required/>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select operation-tab__select--hidden"
                                                    name="recordId">
                                                <c:forEach items="${records}" var="record">
                                                    <c:if test="${record.name == 'transfer'}">
                                                        <option class="operation-tab__option" value="${record.id}"
                                                                selected hidden></option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <input class="operation-tab__submit" type="submit" value="Add"/>
                                    <p class="operation-tab__text"></p>
                                </form>
                            </c:if>
                            <c:if test="${wallets[0].id == null}">
                                <div class="row">
                                    <p>To add a new operation, you must add at least one wallet</p>
                                </div>
                            </c:if>
                        </div>
                        <div id="income" class="operation-tab__content">
                            <c:if test="${(categories[0].id != null) && (records[0].id != null) && (wallets[0].id != null)}">
                                <form class="operation-tab__form operation-tab__form--income"
                                      action="<c:url value="/user/operation/add"/>"
                                      method="post" onsubmit="return CheckValidInput.check(
                                        '.operation-tab__form--income',
                                        '',
                                        '.operation-tab__input',
                                        '.operation-tab__text')">
                                    <div class="row">
                                        <label class="operation-tab__label">To wallet:</label>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select" name="walletId">
                                                <c:forEach items="${wallets}" var="wallet">
                                                    <option class="operation-tab__option"
                                                            value="${wallet.id}">${wallet.name}</option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="row">
                                        <label class="operation-tab__label">Category:</label>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select" name="categoryId">
                                                <c:forEach items="${categories}" var="category">
                                                    <option class="operation-tab__option"
                                                            value="${category.id}">${category.name}</option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="row">
                                        <label class="operation-tab__label" for="operation-income-value">Value:</label>
                                    </div>
                                    <div class="row">
                                        <input class="operation-tab__input" type="text" id="operation-income-value"
                                               name="value" placeholder="Example: 100.50" required/>
                                    </div>
                                    <div class="row">
                                        <label>
                                            <select class="operation-tab__select operation-tab__select--hidden"
                                                    name="recordId">
                                                <c:forEach items="${records}" var="record">
                                                    <c:if test="${record.name == 'income'}">
                                                        <option class="operation-tab__option" value="${record.id}"
                                                                selected hidden></option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <input class="operation-tab__submit" type="submit" value="Add"/>
                                    <p class="operation-tab__text"></p>
                                </form>
                            </c:if>
                            <c:if test="${(categories[0].id == null) || (wallets[0].id == null)}">
                                <div class="row">
                                    <p>To add a new operation, you must add at least one wallet and one category</p>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="last-operations">
                        <p class="last-operations__text">List of last operations</p>
                        <c:if test="${lastOperations[0].id != null}">
                            <table class="last-operations__table">
                                <tr class="last-operations__tr">
                                    <th class="last-operations__th">Date</th>
                                    <th class="last-operations__th">Wallet</th>
                                    <th class="last-operations__th">Category</th>
                                    <th class="last-operations__th">Record</th>
                                    <th class="last-operations__th">Value</th>
                                </tr>
                                <c:forEach items="${lastOperations}" var="lastOperation">
                                    <tr class="last-operations__tr">
                                        <td class="last-operations__td">${lastOperation.date}</td>
                                        <td class="last-operations__td">${lastOperation.wallet}</td>
                                        <td class="last-operations__td">${lastOperation.category}</td>
                                        <td class="last-operations__td">${lastOperation.record}</td>
                                        <td class="last-operations__td">${lastOperation.value}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>

                        <c:if test="${lastOperations[0].id == null}">
                            <p class="last-operations__text">The list is empty</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div id="wallets" class="page-tab__content page-tab__content--wallets">
            <section class="wallets">
                <h3 class="wallets__text">Add new wallet</h3>
                <form class="wallets__form wallets__form--add" action="<c:url value="/user/wallet/add"/>" method="post"
                      onsubmit="return CheckValidInput.check(
                                        '.wallets__form--add',
                                        '.wallets__input',
                                        '.wallets__input--number',
                                        '.wallets__text')">
                    <div class="row">
                        <label class="wallets__label" for="wallets-wallet-name">Name: </label>
                    </div>
                    <div class="row">
                        <input class="wallets__input" type="text" id="wallets-wallet-name" name="name"
                               placeholder="Example: Credit card" required/>
                    </div>
                    <div class="row">
                        <label class="wallets__label" for="wallets-wallet-currency">Currency: </label>
                    </div>
                    <div class="row">
                        <input class="wallets__input" type="text" id="wallets-wallet-currency" name="currency"
                               placeholder="Example: USD" required/>
                    </div>
                    <div class="row">
                        <label class="wallets__label" for="wallets-wallet-value">Start value: </label>
                    </div>
                    <div class="row">
                        <input class="wallets__input wallets__input--number" type="text" id="wallets-wallet-value"
                               name="value" placeholder="Example: 100.50" required/>
                    </div>
                    <input class="wallets__submit" type="submit" value="Add"/>
                    <p class="wallets__text"></p>
                </form>

                <c:if test="${wallets[0].id != null}">
                    <p class="wallets__text">Change wallet name</p>
                    <form class="wallets__form wallets__form--update" action="<c:url value="/user/wallet/update"/>"
                          method="post" onsubmit="return CheckValidInput.check(
                                        '.wallets__form--update',
                                        '.wallets__input',
                                        '',
                                        '.wallets__text')">
                        <div class="row">
                            <label class="wallets__label">Choose wallet</label>
                        </div>
                        <div class="row">
                            <label>
                                <select class="wallets__select" name="id">
                                    <c:forEach items="${wallets}" var="wallet">
                                        <option class="wallets__option" value="${wallet.id}">${wallet.name}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <div class="row">
                            <label class="wallets__label">New name:</label>
                        </div>
                        <div class="row">
                            <label>
                                <input class="wallets__input" type="text" name="name" placeholder="Example: Credit card"
                                       required/>
                            </label>
                        </div>
                        <input class="wallets__submit" type="submit" value="Update"/>
                        <p class="wallets__text"></p>
                    </form>
                </c:if>

                <c:if test="${wallets[0].id != null}">
                    <p class="wallets__text">Delete wallet</p>
                    <form class="wallets__form" action="<c:url value="/user/wallet/delete"/>" method="post">
                        <div class="row">
                            <label class="wallets__label">Choose wallet</label>
                        </div>
                        <div class="row">
                            <label>
                                <select class="wallets__select" name="id">
                                    <c:forEach items="${wallets}" var="wallet">
                                        <option class="wallets__option" value="${wallet.id}">${wallet.name}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <input class="wallets__submit" type="submit" value="Delete"/>
                    </form>
                </c:if>

                <p class="wallets__text">Wallet list</p>
                <div class="wallets__container">
                    <c:if test="${wallets[0].id != null}">
                        <table class="wallets__table">
                            <tr class="wallets__tr">
                                <th class="wallets__th">Wallet</th>
                                <th class="wallets__th">Currency</th>
                                <th class="wallets__th">Value</th>
                            </tr>
                            <c:forEach items="${wallets}" var="wallet">
                                <tr class="wallets__tr">
                                    <td class="wallets__td">${wallet.name}</td>
                                    <td class="wallets__td">${wallet.currency}</td>
                                    <td class="wallets__td">${wallet.value}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:if>
                </div>

                <c:if test="${wallets[0].id == null}">
                    <p class="wallets__text">The list of wallets is empty! Please add a wallet.</p>
                </c:if>
            </section>
        </div>

        <div id="categories" class="page-tab__content page-tab__content--categories">
            <section class="categories">
                <h3 class="categories__text">Add new category</h3>
                <form class="categories__form categories__form--add" action="<c:url value="/user/category/add"/>"
                      method="post" onsubmit="return CheckValidInput.check(
                                        '.categories__form--add',
                                        '.categories__input',
                                        '',
                                        '.categories__text')">
                    <div class="row">
                        <label class="categories__label" for="category-name">Name:</label>
                    </div>
                    <div class="row">
                        <input class="categories__input" type="text" id="category-name" name="name"
                               placeholder="Example: Salary" required/>
                    </div>
                    <input class="categories__submit" type="submit" value="Add"/>
                    <p class="categories__text"></p>
                </form>

                <c:if test="${categories[0].id != null}">
                    <p class="categories__text">Change category name</p>
                    <form class="categories__form categories__form--update"
                          action="<c:url value="/user/category/update"/>"
                          method="post" onsubmit="return CheckValidInput.check(
                                        '.categories__form--update',
                                        '.categories__input',
                                        '',
                                        '.categories__text')">
                        <div class="row">
                            <label class="categories__label">Choose category</label>
                        </div>
                        <div class="row">
                            <label>
                                <select class="categories__select" name="id">
                                    <c:forEach items="${categories}" var="category">
                                        <option class="categories__option"
                                                value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <div class="row">
                            <label class="categories__label">New name:</label>
                        </div>
                        <div class="row">
                            <label>
                                <input class="categories__input" type="text" name="name" placeholder="Example: Salary"
                                       required/>
                            </label>
                        </div>
                        <input class="categories__submit" type="submit" value="Update"/>
                        <p class="categories__text"></p>
                    </form>
                </c:if>

                <c:if test="${categories[0].id != null}">
                    <p class="categories__text">Delete category</p>
                    <form class="categories__form" action="<c:url value="/user/category/delete"/>" method="post">
                        <div class="row">
                            <label class="categories__label">Choose category</label>
                        </div>
                        <div class="row">
                            <label>
                                <select class="categories__select" name="id">
                                    <c:forEach items="${categories}" var="category">
                                        <option class="categories__option"
                                                value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <input class="categories__submit" type="submit" value="Delete"/>
                    </form>
                </c:if>

                <p class="categories__text">Category list</p>
                <div class="categories__container">
                    <c:if test="${categories[0].id != null}">
                        <div class="row">
                            <label class="categories__label">Name:</label>
                        </div>
                        <ul class="categories__list">
                            <c:forEach items="${categories}" var="category">
                                <li class="categories__item">${category.name}</li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </div>

                <c:if test="${categories[0].id == null}">
                    <p class="categories__text">The list of categories is empty! Please add a category.</p>
                </c:if>
            </section>
        </div>

        <div id="operations" class="page-tab__content page-tab__content--operations">
            <section class="operations">
                <h3 class="operations__text operations__text--left">Clear operations list</h3>
                <form class="operations__form" action="<c:url value="/user/operation/delete"/>" method="get">
                    <input class="operations__submit" type="submit" value="Clear"/>
                </form>
                <div class="row">
                    <p class="operations__text">Operation list</p>
                </div>
                <div class="operations__container">
                    <c:if test="${operations[0].id != null}">
                        <table class="operations__table">
                            <tr class="operations__tr">
                                <th class="operations__th">Date</th>
                                <th class="operations__th">Wallet</th>
                                <th class="operations__th">Category</th>
                                <th class="operations__th">Record</th>
                                <th class="operations__th">Value</th>
                            </tr>
                            <c:forEach items="${operations}" var="operation">
                                <tr class="operations__tr">
                                    <td class="operations__td">${operation.date}</td>
                                    <td class="operations__td">${operation.wallet}</td>
                                    <td class="operations__td">${operation.category}</td>
                                    <td class="operations__td">${operation.record}</td>
                                    <td class="operations__td">${operation.value}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:if>
                </div>

                <c:if test="${operations[0].id == null}">
                    <p class="operations__text">The list is empty</p>
                </c:if>
            </section>
        </div>

        <div id="settings" class="page-tab__content page-tab__content--settings">
            <section class="settings">
                <h3 class="settings__text">Renew password</h3>
                <form class="settings__form" action="<c:url value="/user/update"/>" method="post"
                      onsubmit="return CheckValidInput.check(
                                        '.settings__form',
                                        '.settings__input',
                                        '',
                                        '.settings__text')">
                    <div class="row">
                        <label class="settings__label" for="update-pass">New password:</label>
                    </div>
                    <div class="row">
                        <input class="settings__input" type="password" id="update-pass" name="pass" placeholder="******"
                               required/>
                    </div>
                    <input class="settings__submit" type="submit" value="Update"/>
                    <p class="settings__text"></p>
                </form>
            </section>
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
<script type="text/javascript" src="<c:url value="/resources/js/modules/TabsSwitcher.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modules/Exchange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/modules/CheckValidInput.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/main.js"/>"></script>
</body>
</html>