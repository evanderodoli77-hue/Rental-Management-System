// backend/server.js

const express = require('express');
const mysql = require('mysql2/promise'); // Using 'mysql2/promise' for async/await
const cors = require('cors'); // To allow requests from the React frontend

// --- Configuration ---
const dbConfig = {
    host: 'localhost',
    user: 'your_mysql_user', // **CHANGE THIS**
    password: 'your_mysql_password', // **CHANGE THIS**
    database: 'rental_management_system' // Must match the name in your SQL file
};

const app = express();
const PORT = process.env.PORT || 5000;

// --- Middleware ---
app.use(cors());
app.use(express.json()); // Allows parsing of JSON request bodies

// --- Database Connection Pool ---
let pool;
async function connectDB() {
    try {
        pool = mysql.createPool(dbConfig);
        await pool.query('SELECT 1'); // Test the connection
        console.log('✅ MySQL Pool established and connected successfully!');
    } catch (error) {
        console.error('❌ Database connection failed:', error.message);
        // Exit process or handle error appropriately
        process.exit(1);
    }
}
connectDB();

// Middleware to attach the DB pool to the request (so controllers can use it)
app.use((req, res, next) => {
    req.db = pool;
    next();
});

// --- API Routes Placeholder ---
// You will import and use your route files here
// Example:
// const rentalRoutes = require('./routes/rentalRoutes');
// app.use('/api/rentals', rentalRoutes);

app.get('/', (req, res) => {
    res.send('Rental Management System Backend is running!');
});

// A simple test route to ensure DB connection is accessible
app.get('/api/test-db', async (req, res) => {
    try {
        // Query a small piece of data from the database
        const [rows] = await req.db.query('SELECT COUNT(*) AS userCount FROM Users;');
        res.status(200).json({ 
            message: 'Database connection check successful!', 
            userCount: rows[0].userCount 
        });
    } catch (error) {
        console.error('DB Test Error:', error);
        res.status(500).json({ error: 'Failed to query database.' });
    }
});


// --- Start Server ---
app.listen(PORT, () => {
    console.log(`📡 Server running on port ${PORT}`);
});