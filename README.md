# Rental-Management-System
A website that keeps track of rental records

Rental Management System (RMS)A full-stack application designed to streamline property rental operations, including listing management, tenant tracking, payment processing, and maintenance logging.

OverviewThis project is built using a modern JavaScript/Node.js stack, leveraging the power of React for the dynamic frontend and Express for a robust RESTful API, backed by a MySQL database.

Key FeaturesUser Roles: 
Separate access controls for Admin, Agent, and Tenant.
Property Management: CRUD operations for rental listings (add, view, update, delete).
Rental Booking: Tracking rental start/end dates and occupancy status.
Financial Tracking: Logging payments, generating invoices, and tracking overdue balances.
Client Profiles: Managing tenant and agent details.Maintenance: Submitting and tracking repair requests.

Tech Stack

Backend (API Server)ComponentDescription
Node.jsJavaScript runtime environment.
Express.jsLightweight framework for building the REST API.
MySQLRelational database for storing structured data.
mysql2Node.js driver for connecting to MySQL (using promises).
Bcrypt.jsFor secure password hashing.
JWTFor implementing stateless user authentication.

Frontend (Client Interface)ComponentDescription
React.jsLibrary for building the dynamic user interface.
React RouterFor handling client-side routing.
AxiosHTTP client for communicating with the backend API.
HTML5 & CSS3Core structure and styling.

Getting Started
Follow these steps to get the Rental Management System running locally on your machine.
1. Database SetupInstall MySQL: Ensure you have a MySQL server running (e.g., using XAMPP, MAMP, or a local MySQL installation).
2. Create Database: Log into your MySQL client and create the database:SQLCREATE DATABASE rental_management_system;

USE rental_management_system;
Run Schema: Execute the schema file to create the necessary tables:SQLSOURCE /path/to/rental-management/database/rental_system.sql;
3. Backend InstallationNavigate to the backend directory:Bashcd rental-management/backend
Install dependencies:Bashnpm install
Configure Database: Open server.js and update the dbConfig with your MySQL credentials:JavaScriptconst dbConfig = {
    host: 'localhost',
    user: 'your_mysql_user', // <- Update this
    password: 'your_mysql_password', // <- Update this
    database: 'rental_management_system' 
};

Start the server:Bash node server.js
# or using nodemon for development:
# npm install -g nodemon
# nodemon server.js
The API server should start on http://localhost:5000.3. Frontend InstallationNavigate to the frontend directory:Bashcd rental-management/frontend
Install dependencies:Bash npm install
Start the React development server:Bash npm start
The application should open in your browser at http://localhost:3000.
API Endpoints (WIP)The backend provides a RESTful API accessible on port 5000.
CategoryMethodEndpointDescriptionAuthPOST/api/auth/registerCreate a new user account.
AuthPOST/api/auth/loginAuthenticate and receive a JWT.PropertiesGET/api/propertiesFetch all available listings.
PropertiesPOST/api/propertiesAdd a new property (Admin/Agent required).RentalsGET/api/rentals/user/:idGet all active rentals for a user/tenant.
