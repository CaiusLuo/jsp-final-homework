<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Login - 电商平台</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
    </head>

    <body>
        <div class="container auth-container">
            <div class="card auth-card">
                <div class="card-header text-center border-0">
                    <h3 class="fw-bold text-primary">欢迎回来</h3>
                    <p class="text-muted small">登录您的账户</p>
                </div>
                <div class="card-body">
                    <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                        <div class="alert alert-danger rounded-pill px-4">
                            <%= error %>
                        </div>
                        <% } %>
                            <% String msg=request.getParameter("msg"); if (msg !=null) { %>
                                <div class="alert alert-success rounded-pill px-4">
                                    <%= msg %>
                                </div>
                                <% } %>
                                    <form action="auth" method="post">
                                        <input type="hidden" name="action" value="login">
                                        <div class="mb-3">
                                            <label class="form-label fw-bold text-secondary">用户名</label>
                                            <input type="text" name="username" class="form-control rounded-pill px-3"
                                                required>
                                        </div>
                                        <div class="mb-4">
                                            <label class="form-label fw-bold text-secondary">密码</label>
                                            <input type="password" name="password"
                                                class="form-control rounded-pill px-3" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary w-100 py-2">登录</button>
                                    </form>
                </div>
                <div class="card-footer text-center border-0 bg-transparent">
                    <p class="text-muted">还没有账户？ <a href="register.jsp"
                            class="text-primary fw-bold text-decoration-none">注册</a></p>
                </div>
            </div>
        </div>
    </body>

    </html>