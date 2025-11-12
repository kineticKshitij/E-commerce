# Installation Guide

This guide will help you set up and run the E-Commerce Web Application on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Java Development Kit (JDK) 8 or higher**
   - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or use OpenJDK
   - Verify installation: `java -version`

2. **Apache Tomcat 9.0 or higher**
   - Download from [Apache Tomcat](https://tomcat.apache.org/download-90.cgi)
   - Extract to a directory (e.g., `C:\tomcat` or `/opt/tomcat`)

3. **MySQL Server 8.0 or higher**
   - Download from [MySQL](https://dev.mysql.com/downloads/mysql/)
   - Note your root password during installation

4. **Maven 3.6 or higher** (optional, but recommended)
   - Download from [Apache Maven](https://maven.apache.org/download.cgi)
   - Verify installation: `mvn -version`

5. **IDE** (optional, but recommended)
   - Eclipse IDE for Java EE Developers, or
   - IntelliJ IDEA Ultimate, or
   - Visual Studio Code with Java extensions

## Step 1: Clone or Download the Project

```bash
git clone https://github.com/kineticKshitij/E-commerce.git
cd E-commerce
```

Or download and extract the ZIP file from GitHub.

## Step 2: Setup MySQL Database

1. Start MySQL server:
   - **Windows**: Start MySQL from Services or run `mysqld`
   - **Linux/Mac**: `sudo systemctl start mysql` or `sudo service mysql start`

2. Login to MySQL:
   ```bash
   mysql -u root -p
   ```

3. Create the database and tables:
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

   Or simply run the provided SQL file:
   ```bash
   mysql -u root -p < database_schema.sql
   ```

4. Create an admin user:
   ```sql
   INSERT INTO users (name, email, password, role) 
   VALUES ('Admin', 'admin@example.com', 'admin123', 'admin');
   ```

5. (Optional) Add sample products:
   ```sql
   INSERT INTO products (name, description, price, image) VALUES
   ('Laptop', 'High-performance laptop for work and gaming', 50000.00, 'https://via.placeholder.com/200/0000FF/FFFFFF?text=Laptop'),
   ('Smartphone', 'Latest flagship smartphone', 30000.00, 'https://via.placeholder.com/200/FF0000/FFFFFF?text=Phone'),
   ('Headphones', 'Wireless noise-cancelling headphones', 5000.00, 'https://via.placeholder.com/200/00FF00/FFFFFF?text=Headphones'),
   ('Smartwatch', 'Fitness tracker and smartwatch', 15000.00, 'https://via.placeholder.com/200/FFFF00/000000?text=Watch');
   ```

## Step 3: Configure Database Connection

Edit `src/util/DBConnection.java` and update the database credentials:

```java
connection = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/ecommerce_db", 
    "root",           // Your MySQL username
    "your_password"   // Your MySQL password
);
```

## Step 4: Build the Project

### Option A: Using Maven (Recommended)

```bash
mvn clean install
```

This will:
- Download all dependencies
- Compile Java source files
- Create the WAR file in `target/ECommerce.war`

### Option B: Using an IDE

**Eclipse:**
1. Import project: File → Import → Existing Maven Projects
2. Select the project directory
3. Right-click project → Maven → Update Project
4. Right-click project → Run As → Maven install

**IntelliJ IDEA:**
1. Open the project directory
2. IntelliJ will automatically detect the Maven project
3. Click on Maven tab → Lifecycle → install

## Step 5: Deploy to Tomcat

### Option A: Deploy WAR file

1. Copy the WAR file to Tomcat's webapps directory:
   ```bash
   cp target/ECommerce.war /path/to/tomcat/webapps/
   ```

2. Start Tomcat:
   - **Windows**: Run `bin\startup.bat`
   - **Linux/Mac**: Run `bin/startup.sh`

3. Tomcat will automatically deploy the WAR file

### Option B: Deploy using IDE

**Eclipse:**
1. Window → Show View → Servers
2. Right-click in Servers view → New → Server
3. Select Apache Tomcat version
4. Add the project to configured server
5. Right-click server → Start

**IntelliJ IDEA:**
1. Run → Edit Configurations
2. Add New Configuration → Tomcat Server → Local
3. Configure Tomcat installation directory
4. Deployment tab → Add → Artifact → ECommerce.war
5. Click Run

## Step 6: Access the Application

Open your web browser and navigate to:

**Main Application:**
- http://localhost:8080/ECommerce/

**Key URLs:**
- Home: http://localhost:8080/ECommerce/index.jsp
- Products: http://localhost:8080/ECommerce/products
- Login: http://localhost:8080/ECommerce/login.jsp
- Register: http://localhost:8080/ECommerce/register.jsp
- Admin Panel: http://localhost:8080/ECommerce/admin/manageProducts.jsp

## Step 7: Login

**Customer Account:**
- Register a new account through the registration page

**Admin Account:**
- Email: admin@example.com
- Password: admin123

## Troubleshooting

### Issue: "java.lang.ClassNotFoundException: com.mysql.cj.jdbc.Driver"

**Solution:** Ensure MySQL Connector is in the classpath
- If using Maven, it should be downloaded automatically
- If not, download mysql-connector-java-8.0.33.jar and place it in `WEB-INF/lib/`

### Issue: "Access denied for user 'root'@'localhost'"

**Solution:** Check database credentials in `DBConnection.java`
- Verify username and password
- Ensure MySQL server is running

### Issue: "HTTP Status 404 – Not Found"

**Solution:** 
- Verify Tomcat is running
- Check deployment was successful
- Ensure URL includes the application context path: `/ECommerce/`

### Issue: "Table 'ecommerce_db.users' doesn't exist"

**Solution:** Run the database schema SQL script again

### Issue: JSP pages not compiling

**Solution:**
- Clear Tomcat's work directory: `tomcat/work/`
- Restart Tomcat server
- Redeploy the application

## Default Port Configuration

If port 8080 is already in use, you can change Tomcat's port:

1. Edit `tomcat/conf/server.xml`
2. Find: `<Connector port="8080" protocol="HTTP/1.1"`
3. Change to: `<Connector port="8081" protocol="HTTP/1.1"`
4. Restart Tomcat
5. Access at: http://localhost:8081/ECommerce/

## Next Steps

1. Test the registration and login functionality
2. Add products through the admin panel
3. Test the shopping cart and checkout process
4. Customize the UI and add your own product images
5. Implement additional features as needed

## Support

For issues or questions:
- Check the README.md file
- Review the troubleshooting section above
- Create an issue on GitHub
