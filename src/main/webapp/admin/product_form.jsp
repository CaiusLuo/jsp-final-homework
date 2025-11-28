<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>${empty product ? 'Add' : 'Edit'} Product - E-Shop Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3>${empty product ? 'Add New' : 'Edit'} Product</h3>
                            </div>
                            <div class="card-body">
                                <form action="manage" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="saveProduct">
                                    <input type="hidden" name="id" value="${product.id}">

                                    <div class="mb-3">
                                        <label class="form-label">Name</label>
                                        <input type="text" name="name" class="form-control" required
                                            value="${product.name}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Category</label>
                                        <select name="categoryId" class="form-select" required>
                                            <c:forEach items="${categories}" var="c">
                                                <option value="${c.id}" ${product.categoryId==c.id ? 'selected' : '' }>
                                                    ${c.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Price</label>
                                        <input type="number" step="0.01" name="price" class="form-control" required
                                            value="${product.price}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Stock</label>
                                        <input type="number" name="stock" class="form-control" required
                                            value="${product.stock}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea name="description" class="form-control"
                                            rows="3">${product.description}</textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Image</label>
                                        <input type="file" name="image" class="form-control">
                                        <c:if test="${not empty product.image}">
                                            <div class="mt-2">Current: <img src="../assets/images/${product.image}"
                                                    width="100"></div>
                                        </c:if>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <a href="manage?action=products" class="btn btn-secondary">Cancel</a>
                                        <button type="submit" class="btn btn-primary">Save Product</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>