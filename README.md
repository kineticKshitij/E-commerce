# E-Commerce Web Application

A full-featured Java-based e-commerce web application built with Servlets, JSP, JDBC, and MySQL.

## 🏗️ Project Overview

This is a complete e-commerce website with the following core features:
- User registration & login
- Product listing & search
- Shopping cart functionality
- Checkout & order management
- Admin dashboard to add/manage products

## 🧩 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML, CSS, JSP, Bootstrap 5 |
| Backend | Java Servlets, JDBC |
| Database | MySQL |
| Web Server | Apache Tomcat |
| Build Tool | Maven |

## 📁 Project Structure

```
E-commerce/
├── src/
│   ├── model/
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Cart.java
│   │   └── Order.java
│   ├── dao/
│   │   ├── UserDAO.java
│   │   ├── ProductDAO.java
│   │   └── OrderDAO.java
│   ├── servlet/
│   │   ├── RegisterServlet.java
│   │   ├── LoginServlet.java
│   │   ├── ProductServlet.java
│   │   ├── CartServlet.java
│   │   └── CheckoutServlet.java
│   └── util/
│       └── DBConnection.java
├── WebContent/
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── products.jsp
│   ├── cart.jsp
│   ├── checkout.jsp
│   └── admin/
│       ├── addProduct.jsp
│       └── manageProducts.jsp
├── WEB-INF/
│   ├── web.xml
│   └── lib/
├── database_schema.sql
└── pom.xml
```

## 🚀 Setup Instructions

### Prerequisites
- Java JDK 8 or higher
- Apache Tomcat 9.0 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher (optional)
- IDE (Eclipse/IntelliJ IDEA recommended)

### Database Setup

1. Install MySQL and start the MySQL server
2. Run the SQL script to create the database and tables:

```bash
mysql -u root -p < database_schema.sql
```

Or manually execute the SQL commands in `database_schema.sql`:

```sql
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(100),
  role VARCHAR(20) DEFAULT 'customer'
);

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  price DOUBLE,
  image VARCHAR(255)
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  total DOUBLE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

3. Update database credentials in `src/util/DBConnection.java`:
```java
connection = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/ecommerce_db", 
    "your_username",  // Change this
    "your_password"   // Change this
);
```

### Application Setup

#### Option 1: Using Maven

1. Build the project:
```bash
mvn clean install
```

2. Deploy the generated WAR file from `target/ECommerce.war` to Tomcat's `webapps` directory

3. Start Tomcat and access the application at:
```
http://localhost:8080/ECommerce/
```

#### Option 2: Using IDE (Eclipse/IntelliJ)

1. Import the project into your IDE
2. Configure Apache Tomcat server in the IDE
3. Add the project to Tomcat
4. Make sure MySQL Connector JAR is in the classpath (or use Maven to manage dependencies)
5. Run the project on Tomcat

### Creating Admin User

To access the admin panel, you need to manually create an admin user in the database:

```sql
INSERT INTO users (name, email, password, role) 
VALUES ('Admin', 'admin@example.com', 'admin123', 'admin');
```

Then login with:
- Email: `admin@example.com`
- Password: `admin123`

### Adding Sample Products

You can add sample products through the admin panel at:
```
http://localhost:8080/ECommerce/admin/addProduct.jsp
```

Or insert directly into the database:

```sql
INSERT INTO products (name, description, price, image) VALUES
('Laptop', 'High-performance laptop', 50000.00, 'https://via.placeholder.com/200'),
('Smartphone', 'Latest smartphone model', 30000.00, 'https://via.placeholder.com/200'),
('Headphones', 'Wireless headphones', 5000.00, 'https://via.placeholder.com/200');
```

## 🌐 Application URLs

- **Home Page**: `http://localhost:8080/ECommerce/`
- **Products**: `http://localhost:8080/ECommerce/products`
- **Login**: `http://localhost:8080/ECommerce/login.jsp`
- **Register**: `http://localhost:8080/ECommerce/register.jsp`
- **Cart**: `http://localhost:8080/ECommerce/cart.jsp`
- **Admin Panel**: `http://localhost:8080/ECommerce/admin/manageProducts.jsp`

## 📝 Features

### Customer Features
- User registration and login
- Browse products
- Add products to cart
- Update cart quantities
- Checkout and place orders
- View order confirmation

### Admin Features
- Add new products
- Update existing products
- Delete products
- View all products in a table

## 🔧 Technology Details

### Backend
- **Java Servlets**: Handle HTTP requests and business logic
- **JDBC**: Database connectivity and operations
- **Session Management**: User authentication and shopping cart

### Frontend
- **JSP**: Dynamic page generation
- **Bootstrap 5**: Responsive UI design
- **HTML/CSS**: Structure and styling

### Database
- **MySQL**: Relational database for data persistence
- **Schema**: Users, Products, and Orders tables with proper relationships

## 🛠️ Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check database credentials in `DBConnection.java`
   - Ensure database `ecommerce_db` exists

2. **404 Error**
   - Verify Tomcat is running
   - Check the deployment path
   - Ensure web.xml mappings are correct

3. **ClassNotFoundException for MySQL Driver**
   - Add MySQL Connector JAR to WEB-INF/lib or use Maven

4. **JSP Compilation Error**
   - Clear Tomcat's work directory
   - Restart Tomcat server

## 📄 License

This project is open source and available for educational purposes.

## 👨‍💻 Contributing

Feel free to fork this project and submit pull requests for any improvements!