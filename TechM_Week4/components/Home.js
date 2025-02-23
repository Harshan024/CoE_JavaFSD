import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Home.css";

const Home = () => {
  const navigate = useNavigate();
  const [isLoggedIn, setIsLoggedIn] = useState(false); // Fix: useState imported properly

  
  const handleNavigation = (id, route) => {
    const section = document.getElementById(id);
    if (section) {
      section.scrollIntoView({ behavior: "smooth" });
    } else {
      navigate(route);
    }
  };

  const handleLoginSignup = () => {
    if (isLoggedIn) {
      setIsLoggedIn(false); // Logout logic
      alert("Logged out successfully!");
    } else {
      navigate("/login"); // Redirect to login page
    }
  };


  return (
    <div className="home-container">
      {/* Navbar */}
      <div className="navbar">
        <h1 className="logo">EduVantage</h1>
        <div className="nav-links">
          <button onClick={() => handleNavigation("home", "/")} className="nav-button">Home</button>
          <button onClick={() => handleNavigation("courses", "/courses")} className="nav-button">Courses</button>
          <button onClick={() => handleNavigation("instructors", "/instructors")} className="nav-button">Instructors</button>
          <button onClick={handleLoginSignup} className="login-button">
            {isLoggedIn ? "Logout" : "Login / Sign Up"}
          </button>
        </div>
      </div>

      <section id="home" className="first">
        <div className="first-content">
          <h1>Unlock Your Path to Knowledge with EduVantage</h1>
          <p>Explore a comprehensive selection of online courses designed to elevate your career and foster personal growth, all at your convenience.</p>
          <button onClick={() => handleNavigation("courses", "/courses")} className="start-learning-button">Start Learning Today</button>
          <div className="testimonial">
            <img src="/assets/jane.png" alt="Reload" className="testimonial-image" />
            <p className="testimonial-author">
              <strong>Jane Doe</strong> <span className="testimonial-role">(Marketing Specialist)</span>
            </p>
            <div className="testimonial-content">
              <p className="testimonial-text">
                <span className="quote-mark">“</span> EduVantage transformed my learning experience, providing me with valuable insights and the confidence to excel. <span className="quote-mark">”</span>
              </p>
            </div>
          </div>
        </div>
        <div className="first-image">
          <img src="/assets/homeimg.png" alt="Online Learning" />
        </div>
      </section>

      {/* How It Works Section */}
      <section id="how-it-works" className="how-it-works">
        <h2>How EduVantage Works</h2>
        <p>Unlock educational potential effortlessly with EduVantage</p>
        <div className="steps-container">
          <div className="step">
            <div className="step-number">1</div>
            <h3>Connect with Courses</h3>
            <p>Effortlessly link your profile to our extensive catalog of courses designed for learners at every level.</p>
          </div>
          <div className="step">
            <div className="step-number">2</div>
            <h3>Customize Your Learning</h3>
            <p>Tailor your course experience by setting preferences for pace, notifications, and milestones.</p>
          </div>
          <div className="step">
            <div className="step-number">3</div>
            <h3>Engage with Peers</h3>
            <p>Collaborate and interact with fellow learners, sharing insights in an engaging online environment.</p>
          </div>
          <div className="step">
            <div className="step-number">4</div>
            <h3>Secure Your Journey</h3>
            <p>Enjoy peace of mind knowing your educational data is protected with top-notch security measures.</p>
          </div>
        </div>
      </section>

      {/* Hero Section */}
      <section id="hero" className="hero">
        <div className="hero-content">
          <h1>Transform Your Learning Journey with EduVantage</h1>
          <p>Unlock a wide range of courses tailored to your personal and professional growth. Our platform is designed to empower you whether you seek to advance in your career or explore new interests, EduVantage has the perfect course for you.</p>
          <button onClick={handleLoginSignup} className="login-button">Login Now</button>
        </div>
        <div className="hero-image">
          <img src="/assets/tranformimg.png" alt="Online Learning" />
        </div>
      </section>
      

      {/* Footer */}
      <footer className="footer">
  <h2>EduVantage</h2>
  <div className="footer-links">
    <a onClick={() => handleNavigation("home", "/")} className="footer-link">Home</a>
    <a onClick={() => handleNavigation("courses", "/courses")} className="footer-link">Courses</a>
    <a onClick={() => handleNavigation("instructors", "/instructors")} className="footer-link">Instructors</a>
    <a onClick={() => handleNavigation("contact", "/contact")} className="nav-button">Contact</a>
    <a onClick={() => handleNavigation("faq", "/faq")} className="nav-button">FAQ</a>
  </div>
  <p>© 2025 EduVantage. All Rights Reserved</p>
</footer>

    </div>
  );
};

export default Home;
