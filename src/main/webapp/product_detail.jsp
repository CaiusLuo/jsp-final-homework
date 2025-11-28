<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>${product.name} - E-Shop</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
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
                <div class="row">
                    <div class="col-md-6">
                        <img src="assets/images/${product.image}" class="img-fluid rounded" alt="${product.name}"
                            onerror="this.src='https://via.placeholder.com/500'">
                    </div>
                    <div class="col-md-6">
                        <h2>${product.name}</h2>
                        <p class="text-muted">Category: ${product.categoryName}</p>
                        <h3 class="text-primary my-3">$${product.price}</h3>
                        <p class="lead">${product.description}</p>
                        <p>Stock: ${product.stock}</p>

                        <form action="cart" method="post" class="mt-4">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.id}">
                            <div class="input-group mb-3" style="max-width: 200px;">
                                <span class="input-group-text">Qty</span>
                                <input type="number" name="quantity" class="form-control" value="1" min="1"
                                    max="${product.stock}">
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>