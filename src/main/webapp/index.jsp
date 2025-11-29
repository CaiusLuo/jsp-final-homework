<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>电商平台 Home</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
            <link href="assets/css/style.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="products">电商平台</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link" href="products">首页</a></li>
                            <c:forEach items="${categories}" var="c">
                                <li class="nav-item">
                                    <a class="nav-link ${c.id == currentCategoryId ? 'active' : ''}"
                                        href="products?action=category&categoryId=${c.id}">${c.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                        <form class="d-flex me-3" action="products">
                            <input type="hidden" name="action" value="search">
                            <input class="form-control me-2 rounded-pill" type="search" name="keyword"
                                placeholder="搜索商品..." value="${searchKeyword}">
                            <button class="btn btn-outline-light rounded-pill" type="submit">搜索</button>
                        </form>
                        <ul class="navbar-nav">
                            <li class="nav-item"><a class="nav-link" href="cart?action=view">购物车</a></li>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" role="button"
                                            data-bs-toggle="dropdown">
                                            ${sessionScope.user.username}
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="orders?action=my">我的订单</a></li>
                                            <c:if test="${sessionScope.user.role == 1}">
                                                <li><a class="dropdown-item" href="admin/dashboard.jsp">管理员控制台</a></li>
                                            </c:if>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li><a class="dropdown-item" href="auth?action=logout">退出登录</a></li>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item"><a class="nav-link" href="login.jsp">登录</a></li>
                                    <li class="nav-item"><a class="nav-link" href="register.jsp">注册</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container">
                <div class="row">
                    <c:forEach items="${products}" var="p">
                        <div class="col-md-3 mb-4">
                            <div class="card product-card h-100 border-0">
                                <div class="overflow-hidden">
                                    <img src="assets/images/${p.image}" class="card-img-top" alt="${p.name}"
                                        onerror="this.src='https://via.placeholder.com/300x300?text=No+Image'">
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title fw-bold text-dark">${p.name}</h5>
                                    <span
                                        class="badge bg-light text-secondary mb-2 align-self-start">${p.categoryName}</span>
                                    <p class="card-text text-muted small flex-grow-1">${p.description}</p>
                                    <div class="mt-3 d-flex justify-content-between align-items-center">
                                        <span class="price-tag">$${p.price}</span>
                                        <a href="products?action=detail&id=${p.id}"
                                            class="btn btn-primary btn-sm px-4">立即购买</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <div class="col-12 text-center mt-5">
                            <h3 class="text-muted">没有找到商品。</h3>
                        </div>
                    </c:if>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>