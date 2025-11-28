<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>My Orders - 电商平台</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="products">电商平台</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="products">首页</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <h2>我的订单</h2>
                <% String msg=request.getParameter("msg"); if (msg !=null) { %>
                    <div class="alert alert-success">
                        <%= msg %>
                    </div>
                    <% } %>

                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="alert alert-info">您还没有订单。</div>
                            </c:when>
                            <c:otherwise>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>订单编号</th>
                                            <th>日期</th>
                                            <th>小计</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${orders}" var="o">
                                            <tr>
                                                <td>#${o.id}</td>
                                                <td>${o.createTime}</td>
                                                <td>$${o.totalAmount}</td>
                                                <td>
                                                    <span
                                                        class="badge bg-${o.status == 1 ? 'warning' : (o.status == 2 ? 'info' : (o.status == 3 ? 'primary' : (o.status == 4 ? 'success' : 'secondary')))}">
                                                        ${o.statusText}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="order?action=detail&id=${o.id}"
                                                        class="btn btn-sm btn-outline-primary">查看详情</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>