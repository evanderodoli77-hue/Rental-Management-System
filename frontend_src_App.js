// frontend/src/App.js

import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import Dashboard from './pages/Dashboard';
import RentalListings from './pages/RentalListings';
import ClientManagement from './pages/ClientManagement';
import LoginPage from './pages/LoginPage';

function App() {
  return (
    <Router>
      <div className="App">
        {/* Navbar will show on all pages except perhaps the login page */}
        <Navbar /> 
        <main className="container">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/rentals" element={<RentalListings />} />
            <Route path="/clients" element={<ClientManagement />} />
            {/* Add more routes for Payments, Maintenance, etc. */}
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;