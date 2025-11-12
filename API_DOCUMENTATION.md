# API Documentation

This document describes the servlets and their endpoints in the E-Commerce Web Application.

## Overview

The application uses Java Servlets to handle HTTP requests. All servlets follow the MVC pattern:
- **Model**: POJOs in `model` package
- **View**: JSP pages in `WebContent`
- **Controller**: Servlets in `servlet` package

## Servlet Endpoints

### 1. RegisterServlet

**URL Pattern**: `/register`

**Methods**: POST

**Description**: Handles user registration

**Parameters**:
- `name` (String, required): User's full name
- `email` (String, required): User's email address
- `password` (String, required): User's password
- `role` (String, optional): User role (defaults to "customer")

**Success Response**:
- Redirects to: `login.jsp?success=true`

**Error Response**:
- Redirects to: `register.jsp?error=true`

**Example**:
```html
<form action="register" method="post">
    <input type="text" name="name" required>
    <input type="email" name="email" required>
    <input type="password" name="password" required>
    <button type="submit">Register</button>
</form>
```

---

### 2. LoginServlet

**URL Pattern**: `/login`

**Methods**: GET, POST

**Description**: Handles user login and logout

#### POST Method (Login)

**Parameters**:
- `email` (String, required): User's email
- `password` (String, required): User's password

**Success Response**:
- Creates user session
- Admin users redirected to: `admin/manageProducts.jsp`
- Regular users redirected to: `products`

**Error Response**:
- Redirects to: `login.jsp?error=true`

#### GET Method (Logout)

**Parameters**:
- `action=logout` (optional): Triggers logout

**Response**:
- Invalidates session
- Redirects to: `login.jsp`

**Example**:
```html
<!-- Login -->
<form action="login" method="post">
    <input type="email" name="email" required>
    <input type="password" name="password" required>
    <button type="submit">Login</button>
</form>

<!-- Logout -->
<a href="login?action=logout">Logout</a>
```

---

### 3. ProductServlet

**URL Patterns**: `/products`, `/ProductServlet`

**Methods**: GET, POST

**Description**: Manages product operations

#### GET Method (List Products)

**Parameters**: None

**Response**:
- Sets `products` attribute with List<Product>
- Forwards to: `products.jsp`

#### POST Method (Admin Operations)

**Parameters**:
- `action` (String, required): Operation type
  - `add`: Add new product
  - `update`: Update existing product
  - `delete`: Delete product

**For action=add**:
- `name` (String, required): Product name
- `description` (String, required): Product description
- `price` (Double, required): Product price
- `image` (String, required): Product image URL

**For action=update**:
- `id` (Integer, required): Product ID
- `name` (String, required): Product name
- `description` (String, required): Product description
- `price` (Double, required): Product price
- `image` (String, required): Product image URL

**For action=delete**:
- `id` (Integer, required): Product ID

**Success Response**:
- Redirects to: `admin/manageProducts.jsp`

**Example**:
```html
<!-- Add Product -->
<form action="ProductServlet" method="post">
    <input type="hidden" name="action" value="add">
    <input type="text" name="name" required>
    <textarea name="description" required></textarea>
    <input type="number" step="0.01" name="price" required>
    <input type="text" name="image" required>
    <button type="submit">Add Product</button>
</form>

<!-- Delete Product -->
<form action="ProductServlet" method="post">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" value="123">
    <button type="submit">Delete</button>
</form>
```

---

### 4. CartServlet

**URL Patterns**: `/cart`, `/CartServlet`

**Methods**: GET, POST

**Description**: Manages shopping cart operations

#### GET Method

**Response**:
- Redirects to: `cart.jsp`

#### POST Method

**Parameters**:
- `action` (String, optional): Operation type (defaults to "add")
  - `add`: Add item to cart
  - `remove`: Remove item from cart
  - `clear`: Clear entire cart

**For action=add**:
- `productId` (Integer, required): Product ID to add

**For action=remove**:
- `productId` (Integer, required): Product ID to remove

**Success Response**:
- Redirects to: `cart.jsp`

**Session Data**:
- Creates/updates `cart` session attribute

**Example**:
```html
<!-- Add to Cart -->
<form action="CartServlet" method="post">
    <input type="hidden" name="productId" value="123">
    <input type="hidden" name="action" value="add">
    <button type="submit">Add to Cart</button>
</form>

<!-- Remove from Cart -->
<form action="CartServlet" method="post">
    <input type="hidden" name="productId" value="123">
    <input type="hidden" name="action" value="remove">
    <button type="submit">Remove</button>
</form>

<!-- Clear Cart -->
<form action="CartServlet" method="post">
    <input type="hidden" name="action" value="clear">
    <button type="submit">Clear Cart</button>
</form>
```

---

### 5. CheckoutServlet

**URL Pattern**: `/checkout`

**Methods**: GET, POST

**Description**: Handles order checkout

#### GET Method

**Response**:
- Forwards to: `checkout.jsp`

#### POST Method

**Parameters**: None (uses session data)

**Success Response**:
- Creates order in database
- Clears shopping cart
- Redirects to: `checkout.jsp?success=true`

**Error Responses**:
- User not logged in: Redirects to `login.jsp`
- Empty cart: Redirects to `cart.jsp?error=empty`
- Order creation failed: Redirects to `checkout.jsp?error=true`

**Session Requirements**:
- `user`: User object (must be logged in)
- `cart`: Cart object with items

**Example**:
```html
<form action="checkout" method="post">
    <button type="submit">Place Order</button>
</form>
```

---

## Data Models

### User Model
```java
{
    "id": Integer,
    "name": String,
    "email": String,
    "password": String,
    "role": String  // "customer" or "admin"
}
```

### Product Model
```java
{
    "id": Integer,
    "name": String,
    "description": String,
    "price": Double,
    "image": String  // URL to product image
}
```

### Order Model
```java
{
    "id": Integer,
    "userId": Integer,
    "total": Double,
    "createdAt": Timestamp
}
```

### Cart Model
```java
{
    "items": List<CartItem>
}

CartItem {
    "product": Product,
    "quantity": Integer
}
```

---

## Session Attributes

The application uses the following session attributes:

- `user` (User): Currently logged-in user
- `cart` (Cart): User's shopping cart

---

## Database Connection

The application uses a singleton pattern for database connections via `util.DBConnection`:

```java
Connection conn = DBConnection.getConnection();
```

**Configuration**:
- URL: `jdbc:mysql://localhost:3306/ecommerce_db`
- Default credentials in `DBConnection.java`

---

## Error Handling

All servlets implement basic error handling:
- Database errors are caught and logged
- Users are redirected to appropriate pages with error parameters
- Session validation is performed where required

---

## Security Considerations

⚠️ **Important**: This is a basic implementation for educational purposes. For production:

1. **Password Security**: 
   - Currently passwords are stored in plain text
   - Implement password hashing (BCrypt, Argon2, etc.)

2. **SQL Injection**:
   - All database queries use PreparedStatements
   - Provides basic SQL injection protection

3. **Session Security**:
   - Implement session timeout
   - Add CSRF protection
   - Use HTTPS in production

4. **Input Validation**:
   - Add server-side validation
   - Sanitize all user inputs
   - Implement input length limits

5. **Authentication**:
   - Consider implementing JWT or OAuth2
   - Add password reset functionality
   - Implement account lockout after failed attempts

---

## Admin Access

Admin functionalities require:
- User must be logged in
- User role must be "admin"

Admin pages check for authentication:
```jsp
<%
User user = (User) session.getAttribute("user");
if (user == null || !"admin".equals(user.getRole())) {
    response.sendRedirect("../login.jsp");
    return;
}
%>
```

---

## Extending the Application

To add new features:

1. **Create Model**: Add POJO in `model` package
2. **Create DAO**: Add data access object in `dao` package
3. **Create Servlet**: Add servlet in `servlet` package
4. **Configure web.xml**: Add servlet mapping
5. **Create JSP**: Add view in `WebContent`

Example of adding a review feature:

1. Create `model/Review.java`
2. Create `dao/ReviewDAO.java`
3. Create `servlet/ReviewServlet.java`
4. Add mapping in `web.xml`
5. Create `WebContent/reviews.jsp`
