<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Manage Products - E-Shop Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="../products">E-Shop Admin</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                            <li class="nav-item"><a class="nav-link active" href="manage?action=products">Products</a>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="manage?action=orders">Orders</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Products</h2>
                    <a href="manage?action=editProduct" class="btn btn-primary">Add New Product</a>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
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
                                        class="btn btn-sm btn-warning">Edit</a>
                                    <a href="manage?action=deleteProduct&id=${p.id}" class="btn btn-sm btn-danger"
                                        onclick="return confirm('Are you sure?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>