<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Register - E-Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-header text-center">
                            <h3>Register</h3>
                        </div>
                        <div class="card-body">
                            <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                                <div class="alert alert-danger">
                                    <%= error %>
                                </div>
                                <% } %>
                                    <form action="auth" method="post">
                                        <input type="hidden" name="action" value="register">
                                        <div class="mb-3">
                                            <label class="form-label">Username</label>
                                            <input type="text" name="username" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" name="email" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Phone</label>
                                            <input type="text" name="phone" class="form-control">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Password</label>
                                            <input type="password" name="password" class="form-control" required>
                                        </div>
                                        <button type="submit" class="btn btn-success w-100">Register</button>
                                    </form>
                        </div>
                        <div class="card-footer text-center">
                            <a href="login.jsp">Already have an account? Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>