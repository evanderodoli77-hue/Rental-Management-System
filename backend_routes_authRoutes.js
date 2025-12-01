// backend/routes/authRoutes.js

const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// POST /api/auth/register
router.post('/register', authController.register);

// POST /api/auth/login
router.post('/login', authController.login);

// You would add this to server.js: app.use('/api/auth', require('./routes/authRoutes'));

module.exports = router;