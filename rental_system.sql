-- database/rental_system.sql

-- Drop tables if they exist to allow for clean setup/reset
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Properties;
DROP TABLE IF EXISTS Users;

-- 1. Users Table (Admin, Agent, Tenant)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL, -- Stores the hashed password
    email VARCHAR(100) UNIQUE,
    full_name VARCHAR(150),
    phone_number VARCHAR(20),
    role ENUM('admin', 'agent', 'tenant') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Properties Table (Assets)
CREATE TABLE Properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    rental_rate DECIMAL(10, 2) NOT NULL, -- Price per period (e.g., per month)
    status ENUM('available', 'rented', 'maintenance') DEFAULT 'available',
    agent_id INT, -- Agent responsible for this property
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (agent_id) REFERENCES Users(user_id)
);

-- 3. Rentals Table (Booking and Scheduling)
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    tenant_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    monthly_rate DECIMAL(10, 2) NOT NULL,
    deposit_paid DECIMAL(10, 2) DEFAULT 0.00,
    status ENUM('active', 'pending', 'expired', 'canceled') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (tenant_id) REFERENCES Users(user_id)
);

-- 4. Payments Table (Tracking & Invoicing)
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    tenant_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    invoice_number VARCHAR(100) UNIQUE,
    status ENUM('paid', 'pending', 'overdue') DEFAULT 'paid',
    
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id),
    FOREIGN KEY (tenant_id) REFERENCES Users(user_id)
);

-- 5. Maintenance Requests Table (Logging)
CREATE TABLE MaintenanceRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    tenant_id INT,
    description TEXT NOT NULL,
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
    status ENUM('open', 'in_progress', 'completed', 'canceled') DEFAULT 'open',
    reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (tenant_id) REFERENCES Users(user_id)
);

-- Optional: Seed Data (Initial Admin User)
INSERT INTO Users (username, password_hash, role, full_name, email) VALUES
('admin', 'admin_hashed_password', 'admin', 'System Admin', 'admin@rms.com');