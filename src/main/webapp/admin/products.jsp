<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Manage Products - 电商平台 Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="../products">电商平台 Admin</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link" href="dashboard.jsp">控制台</a></li>
                            <li class="nav-item"><a class="nav-link active" href="manage?action=products">商品管理</a>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="manage?action=orders">订单管理</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>商品管理</h2>
                    <a href="manage?action=editProduct" class="btn btn-primary">添加新商品</a>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>编号</th>
                            <th>图片</th>
                            <th>名称</th>
                            <th>分类</th>
                            <th>价格</th>
                            <th>库存</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${products}" var="p">
                            <tr>
                                <td>${p.id}</td>
                                <td><img src="../assets/images/${p.image}" width="50"
                                        onerror="this.src='https://via.placeholder.com/50'"></td>
                                <td>${p.name}</td>
                                <td>${p.categoryName}</td>
                                <td>$${p.price}</td>
                                <td>${p.stock}</td>
                                <td>
                                    <a href="manage?action=editProduct&id=${p.id}"
                                        class="btn btn-sm btn-warning">编辑</a>
                                    <a href="manage?action=deleteProduct&id=${p.id}" class="btn btn-sm btn-danger"
                                        onclick="return confirm('确定要删除吗？')">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>