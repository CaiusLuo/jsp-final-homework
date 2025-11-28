<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>My Profile - 电商平台</title>
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
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h3>我的资料</h3>
                            </div>
                            <div class="card-body">
                                <% String msg=request.getParameter("msg"); if (msg !=null) { %>
                                    <div class="alert alert-success">
                                        <%= msg %>
                                    </div>
                                    <% } %>
                                        <form action="auth" method="post">
                                            <input type="hidden" name="action" value="updateProfile">
                                            <div class="mb-3">
                                                <label class="form-label">用户名</label>
                                                <input type="text" class="form-control"
                                                    value="${sessionScope.user.username}" disabled>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">邮箱</label>
                                                <input type="email" name="email" class="form-control"
                                                    value="${sessionScope.user.email}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">电话</label>
                                                <input type="text" name="phone" class="form-control"
                                                    value="${sessionScope.user.phone}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">新密码（留空保持不变）</label>
                                                <input type="password" name="password" class="form-control">
                                            </div>
                                            <button type="submit" class="btn btn-primary">更新资料</button>
                                        </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>