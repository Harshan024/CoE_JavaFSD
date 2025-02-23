import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Auth.css";

const Login = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = (e) => {
    e.preventDefault();
    // Dummy login check (Replace this with real authentication logic)
    if (email === "user@example.com" && password === "password") {
      alert("Login successful!");
      navigate("/");
    } else {
      alert("Invalid credentials, please try again.");
    }
  };

  return (
    <div className="auth-container">
      <h2>Login to EduVantage</h2>
      <form onSubmit={handleLogin}>
        <input
          type="email"
          placeholder="Enter Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <input
          type="password"
          placeholder="Enter Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <button type="submit">Login</button>
      </form>
      <p>Don't have an account? <span onClick={() => navigate("/signup")}>Sign Up</span></p>
    </div>
  );
};

export default Login;
