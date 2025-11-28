DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_db;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    role INT DEFAULT 0 COMMENT '0: User, 1: Admin',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Products Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    image VARCHAR(255),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10, 2) NOT NULL,
    status INT DEFAULT 1 COMMENT '1: Pending, 2: Paid, 3: Shipped, 4: Completed, 5: Cancelled',
    address VARCHAR(255),
    phone VARCHAR(20),
    receiver VARCHAR(50),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items Table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert default admin
INSERT INTO users (username, password, role) VALUES ('admin', 'admin123', 1);

-- Insert some categories
INSERT INTO categories (name, description) VALUES 
('Electronics', 'Phones, Laptops, etc.'),
('Books', 'Fiction, Non-fiction, etc.'),
('Clothing', 'Men, Women, Kids');

-- Insert some sample products
INSERT INTO products (category_id, name, description, price, stock, image) VALUES
(1, 'Smartphone X', 'Latest model smartphone', 999.99, 50, 'phone.jpg'),
(1, 'Laptop Pro', 'High performance laptop', 1299.99, 30, 'laptop.jpg'),
(2, 'Java Programming', 'Learn Java from scratch', 49.99, 100, 'java_book.jpg'),
(3, 'T-Shirt', 'Cotton T-Shirt', 19.99, 200, 'tshirt.jpg');
