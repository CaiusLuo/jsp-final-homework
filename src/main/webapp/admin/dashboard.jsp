<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - E-Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="../products">E-Shop Admin</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="manage?action=products">Products</a></li>
                        <li class="nav-item"><a class="nav-link" href="manage?action=orders">Orders</a></li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link" href="../auth?action=logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h1>Welcome, Admin!</h1>
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-header">Products</div>
                        <div class="card-body">
                            <h5 class="card-title">Manage Products</h5>
                            <p class="card-text">Add, edit, or delete products.</p>
                            <a href="manage?action=products" class="btn btn-light">Go to Products</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-header">Orders</div>
                        <div class="card-body">
                            <h5 class="card-title">Manage Orders</h5>
                            <p class="card-text">View and update order status.</p>
                            <a href="manage?action=orders" class="btn btn-light">Go to Orders</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>