<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Register - 电商平台</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
    </head>

    <body>
        <div class="container auth-container">
            <div class="card auth-card">
                <div class="card-header text-center border-0">
                    <h3 class="fw-bold text-success">创建账户</h3>
                    <p class="text-muted small">立即加入我们！</p>
                </div>
                <div class="card-body">
                    <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                        <div class="alert alert-danger rounded-pill px-4">
                            <%= error %>
                        </div>
                        <% } %>
                            <form action="auth" method="post">
                                <input type="hidden" name="action" value="register">
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">用户名</label>
                                    <input type="text" name="username" class="form-control rounded-pill px-3" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">邮箱</label>
                                    <input type="email" name="email" class="form-control rounded-pill px-3" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">电话</label>
                                    <input type="text" name="phone" class="form-control rounded-pill px-3">
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-bold text-secondary">密码</label>
                                    <input type="password" name="password" class="form-control rounded-pill px-3"
                                        required>
                                </div>
                                <button type="submit"
                                    class="btn btn-success w-100 py-2 rounded-pill fw-bold">注册</button>
                            </form>
                </div>
                <div class="card-footer text-center border-0 bg-transparent">
                    <p class="text-muted">已有账户？ <a href="login.jsp"
                            class="text-success fw-bold text-decoration-none">登录</a></p>
                </div>
            </div>
        </div>
    </body>

    </html>