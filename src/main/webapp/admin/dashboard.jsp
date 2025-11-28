<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - 电商平台</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="../products">电商平台 Admin</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">控制台</a></li>
                        <li class="nav-item"><a class="nav-link" href="manage?action=products">商品管理</a></li>
                        <li class="nav-item"><a class="nav-link" href="manage?action=orders">订单管理</a></li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link" href="../auth?action=logout">退出登录</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h1>欢迎，管理员！</h1>
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-header">商品管理</div>
                        <div class="card-body">
                            <h5 class="card-title">管理商品</h5>
                            <p class="card-text">添加、编辑或删除商品。</p>
                            <a href="manage?action=products" class="btn btn-light">进入商品管理</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-header">订单管理</div>
                        <div class="card-body">
                            <h5 class="card-title">管理订单</h5>
                            <p class="card-text">查看和更新订单状态。</p>
                            <a href="manage?action=orders" class="btn btn-light">进入订单管理</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>