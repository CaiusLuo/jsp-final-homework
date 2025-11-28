<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>${product.name} - E-Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
            <link href="assets/css/style.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark mb-4">
                <div class="container">
                    <a class="navbar-brand" href="products">E-Shop</a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="products">Back to Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="cart?action=view">Cart</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <div class="card border-0 p-4">
                    <div class="row">
                        <div class="col-md-6">
                            <img src="assets/images/${product.image}" class="img-fluid rounded shadow-sm"
                                alt="${product.name}" onerror="this.src='https://via.placeholder.com/500'">
                        </div>
                        <div class="col-md-6">
                            <h2 class="fw-bold text-dark mt-3 mt-md-0">${product.name}</h2>
                            <span class="badge bg-secondary mb-3">${product.categoryName}</span>
                            <h3 class="text-primary fw-bold my-3">$${product.price}</h3>
                            <p class="lead text-muted">${product.description}</p>
                            <p class="text-success fw-bold"><i class="bi bi-check-circle-fill"></i> In Stock:
                                ${product.stock}</p>

                            <form action="cart" method="post" class="mt-4">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.id}">
                                <div class="d-flex align-items-center mb-3">
                                    <label class="me-3 fw-bold">Quantity:</label>
                                    <div class="input-group" style="max-width: 150px;">
                                        <button class="btn btn-outline-secondary" type="button"
                                            onclick="this.parentNode.querySelector('input[type=number]').stepDown()">-</button>
                                        <input type="number" name="quantity" class="form-control text-center" value="1"
                                            min="1" max="${product.stock}">
                                        <button class="btn btn-outline-secondary" type="button"
                                            onclick="this.parentNode.querySelector('input[type=number]').stepUp()">+</button>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg rounded-pill px-5 shadow-sm">Add to
                                    Cart</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>